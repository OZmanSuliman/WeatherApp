//
//  MainDetailsMappable.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import ObjectMapper

extension MainDetails: Mappable {
    convenience init?(map _: Map) {
        self.init()
    }

    func mapping(map: Map) {
        var temperature = 0.0
        temperature <- map["temp"]
        temp = Int(temperature)
        feelsLike <- map["feels_like"]
        tempMin <- map["temp_min"]
        tempMax <- map["temp_max"]
        pressure <- map["pressure"]
        seaLevel <- map["sea_level"]
        grndLevel <- map["grnd_level"]
        humidity <- map["humidity"]
        tempKf <- map["temp_kf"]
    }
}
