import Foundation

public struct FeatureToggle {
    let name: Feature
    let enabled: Bool
}

extension FeatureToggle: Decodable {
    enum CodingKeys: String, CodingKey {
        case name
        case enabled
    }
}
