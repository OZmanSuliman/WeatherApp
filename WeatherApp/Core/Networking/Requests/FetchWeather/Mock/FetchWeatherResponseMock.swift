//
//  FetchWeatherResponseMock.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Foundation
import ObjectMapper

public class FetchWeatherResponseMock: FetchWeatherResponseProtocol {
    var weatherList: [WeatherModel] = []

    public required init(with json: Any) {
        guard let json = json as? [[String: Any]] else { return }

        weatherList = Mapper<WeatherModel>().mapArray(JSONArray: json)
    }
}
