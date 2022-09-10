//
//  CityMappable.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Foundation
import ObjectMapper

extension City: Mappable {
    convenience init?(map _: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
