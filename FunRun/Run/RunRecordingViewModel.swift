import CoreMotion
import Foundation
import SwiftUI
import Combine

class RunRecordingViewModel: ObservableObject {

    @Published private(set) var recorderState: RunRecorderState

    @Published private(set) var durationText = ""
    @Published private(set) var distanceText = ""
    @Published private(set) var stepsText = ""
    @Published private(set) var paceText = ""
    @Published private(set) var locationText = ""

    private let recorder: RunRecorder = RunRecorder()

    init() {
        recorderState = recorder.state
        recorder.delegate = self
    }

    func startRecording() {
        recorder.start()
    }

    func stopRecording() {
        recorder.stop()
    }
}

extension RunRecordingViewModel: RunRecorderDelegate {
    func recorderDidChangeState(_ recorder: RunRecorder, state: RunRecorderState) {
        DispatchQueue.main.async {
            self.recorderState = state
        }
    }

    func recorderDidUpdateSummary(_ recorder: RunRecorder, summary: RunSummary) {
        DispatchQueue.main.async {
            self.durationText = RunFormatter.durationString(from: summary.totalDuration)
            self.distanceText = RunFormatter.distanceString(from: summary.totalDistance)
            self.stepsText = "\(summary.totalSteps)"

            if let pace = summary.currentPace {
                self.paceText = "\(RunFormatter.decimalString(from: pace)) seconds/meter"
            } else {
                self.paceText = "--"
            }

            if let lastLocation = summary.locations.last {
                let latitudeString = RunFormatter.decimalString(from: lastLocation.latitude)
                let longitudeString = RunFormatter.decimalString(from: lastLocation.longitude)

                self.locationText = "\(latitudeString), \(longitudeString) (of \(summary.locations.count))"
            } else {
                self.locationText = "--"
            }
        }
    }
}
/// Formatting helpers for displaying run metrics.
private enum RunFormatter {
    private static let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    private static let distanceFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .naturalScale
        formatter.numberFormatter.maximumFractionDigits = 2
        return formatter
    }()

    private static let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        return formatter
    }()

    /// Formats a duration in seconds as `h:mm:ss`.
    static func durationString(from duration: TimeInterval) -> String {
        durationFormatter.string(from: duration) ?? "--"
    }

    /// Formats a distance in meters using the user's locale (e.g. km or mi).
    static func distanceString(from meters: Double) -> String {
        distanceFormatter.string(from: Measurement(value: meters, unit: UnitLength.meters))
    }

    static func decimalString(from value: Double) -> String {
        decimalFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

