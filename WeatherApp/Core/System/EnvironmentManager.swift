//
//  EnvironmentManager.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Foundation

// MARK: - EnvironmentManager

final class EnvironmentManager {
    static let shared = EnvironmentManager()
    fileprivate let environmentPlistName = "EnvironmentVariables"
    fileprivate let configurationKey = "Configuration"
    fileprivate var environmentsDict: NSDictionary!
    var activeConfiguration: Configuration?

    enum Configuration: String {
        case debug = "Debug"
        case staging = "Staging"
        case release = "Release"
    }

    fileprivate enum EnvironmentProperty: String {
        case baseURL
        case apiKey
        case iconUrl
        
        var stringValue: String {
            let appConfig = try? EnvironmentManager.shared.setting(self)
            return appConfig ?? ""
        }

        var urlValue: URL? {
            let appConfig = try? URL(string: EnvironmentManager.shared.setting(self))
            return appConfig
        }
    }

    fileprivate init() {
        let bundle = Bundle(for: EnvironmentManager.self)
        let configurationName = (bundle.infoDictionary?[configurationKey] as? String)!
        activeConfiguration = Configuration(rawValue: configurationName)
        let environmentsPath = bundle.path(forResource: environmentPlistName, ofType: "plist")!
        if let mainEnvironmentsDict = NSDictionary(contentsOfFile: environmentsPath),
           let activeConfigurationString = activeConfiguration?.rawValue,
           let activeDictionary = mainEnvironmentsDict[activeConfigurationString] as? NSDictionary
        {
            environmentsDict = activeDictionary
        }
    }

    fileprivate func setting(_ property: EnvironmentProperty) throws -> String {
        if let value = environmentsDict[property.rawValue] as? String {
            return value
        }
        throw NSError(domain: "No <\(property.rawValue)> setting has been found", code: 100_012, userInfo: nil)
    }

    func getAppKey() -> String {
        return EnvironmentProperty.apiKey.stringValue
    }
    
    func getBaseUrl() -> String {
        return EnvironmentProperty.baseURL.stringValue
    }

    func iconUrl(id: String) -> String? {
        return "\(EnvironmentProperty.iconUrl.stringValue)\(id)@2x.png"
    }
    
    func checkIsDev() -> Bool {
        return activeConfiguration == .debug
    }
}

// MARK: - PlistFiles

internal enum PlistFiles {
    private static let _document = PlistDocument(path: "EnvironmentVariables.plist")
}

private func arrayFromPlist<T>(at path: String) -> [T] {
    let bundle = Bundle(for: BundleToken.self)
    guard let url = bundle.url(forResource: path, withExtension: nil),
          let data = NSArray(contentsOf: url) as? [T]
    else {
        fatalError("Unable to load PLIST at path: \(path)")
    }
    return data
}

// MARK: - PlistDocument

private struct PlistDocument {
    let data: [String: Any]

    init(path: String) {
        let bundle = Bundle(for: BundleToken.self)
        guard let url = bundle.url(forResource: path, withExtension: nil),
              let data = NSDictionary(contentsOf: url) as? [String: Any]
        else {
            fatalError("Unable to load PLIST at path: \(path)")
        }
        self.data = data
    }

    subscript<T>(key: String) -> T {
        guard let result = data[key] as? T else {
            fatalError("Property '\(key)' is not of type \(T.self)")
        }
        return result
    }
}

// MARK: - BundleToken

private final class BundleToken {}
