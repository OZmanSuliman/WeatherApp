//
//  FetchWeatherResponse.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import ObjectMapper

protocol FetchWeatherResponseProtocol: APIResponseProtocol  {
    var weatherList: [WeatherModel] { get }
}

public class FetchWeatherResponse: FetchWeatherResponseProtocol {
    var weatherList: [WeatherModel] = []

    public required init(with json: Any) {
        guard let json = json as? [String: Any],
              let jsonArray = json["list"] as? [[String: Any]]
        else { return }

        weatherList = Mapper<WeatherModel>().mapArray(JSONArray: jsonArray)
        if let cityJson = json["city"] as? [String: Any],
            let city = Mapper<City>().map(JSON: cityJson)
        {
            weatherList.forEach { item in
                item.city = city
            }
        }
    }
}
