//
//  FetchWeatherRequestMock.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Alamofire
import Foundation

// MARK: - FetchWeatherRequestMock

struct FetchWeatherRequestMock: FetchWeatherRequestProtocol {
    let city: String

    init(city: String) {
        self.city = city
    }
}

// MARK: APIRequestProtocol

extension FetchWeatherRequestMock: APIRequestProtocol {
    var endpoint: String { return "weather_14" }
    var parameters: [String: Any] { return ["keyword": city] }
    var method: HTTPMethod { return .get }
}
