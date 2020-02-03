import Foundation

struct JSONParsingService: ParsingService {
    func parse(_ data: Data, jsonContainerName: String) -> ParsingServiceResult? {
        var toggleData = data
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonContainer = json as? [String: Any],
            let featureToggles = jsonContainer[jsonContainerName],
            let featureTogglesData = try? JSONSerialization.data(withJSONObject: featureToggles) {
                toggleData = featureTogglesData
        }
        
        return try? JSONDecoder().decode([FeatureToggle].self, from: toggleData)
    }
}
