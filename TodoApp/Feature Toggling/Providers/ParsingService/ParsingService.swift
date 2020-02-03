import Foundation

public typealias ParsingServiceResult = [FeatureToggle]

public protocol ParsingService {
    func parse(_ data: Data, containerName: String) -> ParsingServiceResult?
}
