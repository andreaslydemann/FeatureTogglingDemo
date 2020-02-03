import Foundation

public struct JSONParsingService: ParsingService {
    public func parse(_ data: Data, containerName: String) -> ParsingServiceResult? {
        var toggleData = data
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonContainer = json as? [String: Any],
            let featureToggles = jsonContainer[containerName],
            let featureTogglesData = try? JSONSerialization.data(withJSONObject: featureToggles) {
                toggleData = featureTogglesData
        }
        
        return try? JSONDecoder().decode([FeatureToggle].self, from: toggleData)
    }
}
