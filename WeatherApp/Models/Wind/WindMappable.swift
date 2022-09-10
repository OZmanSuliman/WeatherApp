//
//  WindMappable.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import ObjectMapper

extension Wind: Mappable {
    convenience init?(map _: Map) {
        self.init()
    }

    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
        gust <- map["gust"]
    }
}
