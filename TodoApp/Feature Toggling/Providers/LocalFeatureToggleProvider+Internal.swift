import Foundation

extension LocalFeatureToggleProvider {
    static let jsonContainerName: String = "featureToggles"
    static let configurationName: String = "FeatureToggles"
    static let configurationType: String = "json"
    
    static func loadConfiguration() -> [FeatureToggle]? {
        guard let configurationURL = bundledConfigurationURL(),
            let data = try? Data(contentsOf: configurationURL) else { return nil }
        
        return parseConfiguration(data: data)
    }
    
    static func parseConfiguration(data: Data) -> ParsingServiceResult? {
        return JSONParsingService().parse(data, containerName: jsonContainerName)
    }
    
    static func bundledConfigurationURL() -> URL? {
        return Bundle.main.url(forResource: configurationName, withExtension: configurationType)
    }
}
