import CoreLocation
import Foundation

public enum RunMetric {
    case distance(Double)
    case duration(TimeInterval)
    case steps(Int)
    case pace(Double)
    case location(CLLocationCoordinate2D)
}

extension RunMetric {

    func addingRandomDistance() -> RunMetric {
        guard case let .distance(value) = self else {
            return self
        }

        let randomAddition = Double.random(in: 3...20)
        return RunMetric.distance(value + randomAddition)
    }

    func addingRandomSteps() -> RunMetric {
        guard case let .steps(value) = self else {
            return self
        }

        let randomAddition = Int.random(in: 10...30)
        return RunMetric.steps(value + randomAddition)
    }

    static func randomDistance() -> RunMetric {
        let value = Double.random(in: 3...20)
        return RunMetric.distance(value)
    }

    static func randomSteps() -> RunMetric {
        let value = Int.random(in: 10...30)
        return RunMetric.steps(value)
    }

    static func randomPace() -> RunMetric {
        let value = Double.random(in: 0.2...2.5)
        return .pace(value)
    }
}
