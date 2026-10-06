import CoreLocation
import Foundation

public struct RunSummary {
    public internal(set) var startDate: Date
    public internal(set) var totalDuration: TimeInterval
    public internal(set) var totalDistance: Double
    public internal(set) var totalSteps: Int
    public internal(set) var currentPace: Double?
    public internal(set) var locations: [CLLocationCoordinate2D]

    init(startDate: Date) {
        self.startDate = startDate
        self.totalDuration = 0
        self.totalDistance = 0
        self.totalSteps = 0
        self.currentPace = nil
        self.locations = []
    }
}

extension RunSummary {
    mutating func update(with metrics: [RunMetric]) {
        metrics.forEach {
            switch $0 {
            case .distance(let value):
                self.totalDistance = value

            case .duration(let value):
                self.totalDuration = value

            case .steps(let value):
                self.totalSteps = value

            case .pace(let value):
                self.currentPace = value

            case .location(let coordinate):
                self.locations.append(coordinate)
            }
        }
    }
}
