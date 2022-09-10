//
//  API.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation

enum APIEndpoints: String {

case forecast = "data/2.5/forecast?q=%@&mode=json&units=metric"

    
    
    /** Contains the full path to the endpoint */
    func fullPath(withParameters parameters: CVarArg...) -> String {
        var endpoint = self.rawValue

        if parameters.count > 0 {
            endpoint = String(format: endpoint, arguments: parameters)
        }

        return "\(EnvironmentManager.shared.getBaseUrl())\(endpoint)&appid=\(EnvironmentManager.shared.getAppKey())"
    }
}
