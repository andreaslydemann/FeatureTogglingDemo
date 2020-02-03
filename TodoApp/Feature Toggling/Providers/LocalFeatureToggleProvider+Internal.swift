import Foundation

extension LocalFeatureToggleProvider {
    static let configurationName: String = "FeatureToggles"
    static let configurationType: String = "json"

    static func loadConfiguration() -> [FeatureToggle]? {
        if let configurationURL = bundledConfigurationURL(),
            let data = try? Data(contentsOf: configurationURL) {
            return parseConfiguration(data: data)
        }
        return nil
    }

    static func parseConfiguration(data: Data) -> ParsingServiceResult? {
        return JSONParsingService().parse(data, jsonContainerName: "featureToggles")
    }
    
    static func bundledConfigurationURL() -> URL? {
        return Bundle.main.url(forResource: configurationName, withExtension: configurationType)
    }
}
