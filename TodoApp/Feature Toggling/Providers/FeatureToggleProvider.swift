import Foundation

typealias FeatureToggleCallback = ([FeatureToggle]) -> Void

protocol FeatureToggleProvider {
    func fetchFeatureToggles(_ completion: @escaping FeatureToggleCallback)
}
