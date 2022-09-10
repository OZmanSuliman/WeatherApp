//
//  FetchWeatherRequest.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Alamofire
import Foundation

// MARK: - FetchWeatherRequestProtocol

protocol FetchWeatherRequestProtocol: APIRequestProtocol {
    var city: String { get }
}

// MARK: - FetchWeatherRequest

struct FetchWeatherRequest: FetchWeatherRequestProtocol {
    let city: String

    init(city: String) {
        self.city = city
    }
}

// MARK: APIRequestProtocol

extension FetchWeatherRequest: APIRequestProtocol {
    var endpoint: String { return APIEndpoints.forecast.fullPath(withParameters: city) }

    var method: HTTPMethod { return .get }
}
