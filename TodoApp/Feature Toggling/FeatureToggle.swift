import Foundation

enum FeatureToggle: String, CaseIterable {
    case addItem
    
    static let enabledByDefault: [FeatureToggle] = [
        .addItem
    ]
}
