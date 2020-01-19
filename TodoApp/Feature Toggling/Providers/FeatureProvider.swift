import Foundation

protocol FeatureProvider {
    func fetchEnabledFeatures(_ completion: @escaping([Feature]?) -> Void)
}
