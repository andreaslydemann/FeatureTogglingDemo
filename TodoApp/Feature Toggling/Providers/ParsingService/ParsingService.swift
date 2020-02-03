import Foundation

public typealias ParsingServiceResult = [FeatureToggle]

protocol ParsingService {
    func parse(_ data: Data, jsonContainerName: String) -> ParsingServiceResult?
}
