import Combine
import CoreMotion
import CoreLocation

public protocol RunRecorderDelegate: AnyObject {
    func recorderDidChangeState(_ recorder: RunRecorder, state: RunRecorderState)
    func recorderDidUpdateSummary(_ recorder: RunRecorder, summary: RunSummary)
}

public class RunRecorder: NSObject {

    // MARK: Public Properties

    public private(set) var state: RunRecorderState = .stopped {
        didSet {
            delegate?.recorderDidChangeState(self, state: state)
        }
    }

    public private(set) var currentRunSummary: RunSummary? {
        didSet {
            if let currentRunSummary {
                delegate?.recorderDidUpdateSummary(self, summary: currentRunSummary)
            }
        }
    }

    public weak var delegate: RunRecorderDelegate?
    
    // MARK: Private Properties

    private let pedometer = CMPedometer()
    private var manager = CLLocationManager()
    private var cancellables: [AnyCancellable] = []

    // MARK: Initialization

    public override init() {
        super.init()
        manager.delegate = self
    }

    // MARK: Public Methods

    public func start() {
        guard state != .recording else {
            return
        }

        let startDate = Date()

        // Start the duration timer
        let cancellable = Timer.publish(
            every: 1,
            on: .main,
            in: .common
        )
            .autoconnect()
            .sink() { [weak self] in
                self?.handleTimer($0)
            }

        manager.requestAlwaysAuthorization()
        
        manager.startUpdatingLocation()
        
        cancellables.append(cancellable)

        // Start the pedometer
        pedometer.startUpdates(from: startDate) { [weak self] data, error in
            if let error {
                debugPrint("pedometer error: \(error)")
                return
            }

            if let data {
                self?.handlePedometerData(data)
            }
        }

        state = .recording
        currentRunSummary = RunSummary(startDate: startDate)
    }

    public func stop() {
        guard state == .recording else {
            return
        }

        cancellables = []
        pedometer.stopUpdates()
        state = .stopped
    }

    // MARK: Private Methods

    private func handleTimer(_ date: Date) {
        guard let summary = currentRunSummary else {
            return
        }

        let duration = date.timeIntervalSince(summary.startDate)
        let distance = RunMetric.steps(summary.totalSteps)
        currentRunSummary?.update(with: [RunMetric.duration(duration)])
        currentRunSummary?.update(with: [distance])
    }

    private func handlePedometerData(_ data: CMPedometerData) {
        if let distance = data.distance?.doubleValue {
            currentRunSummary?.update(with: [RunMetric.distance(distance)])
        }
            
        if let stepCount = data.numberOfSteps as? Int {
            currentRunSummary?.update(with: [RunMetric.steps(stepCount)])
        }
        
        if let pace = data.currentPace as? Double {
            
            currentRunSummary?.update(with: [RunMetric.pace(pace)])
        }

    }
}

extension RunRecorder: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates = locations.map { $0.coordinate }
        
        let metrics: [RunMetric] = coordinates.map { coordinate in
            RunMetric.location(coordinate)
        }
        
        currentRunSummary?.update(with: metrics)
    }
}
