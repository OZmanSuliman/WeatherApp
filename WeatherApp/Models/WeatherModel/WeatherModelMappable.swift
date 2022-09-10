//
//  WeatherModelMappable.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import ObjectMapper

extension WeatherModel: Mappable {
    // MARK: - Mapping -

    convenience init?(map _: Map) {
        self.init()
    }

    func mapping(map: Map) {
        dt <- map["dt"]
        time <- map["time"]
        main <- map["main"]
        city <- map["city"]
        var weathers: [Weather] = []
        weathers <- map["weather"]
        weather.removeAll()
        weathers.forEach {
            weather.append($0)
        }

        visibility <- map["visibility"]
        pop <- map["pop"]
        if let dt = dt {
            let dtDouble = Double(dt)
            date = dtDouble.convertDate()
            id = "\(dt)-\(city ?? City())-\(weathers.first?.id ?? 0)"
        } else if let time = time {
            let timeDouble = Double(time)
            date = timeDouble.convertDate()
            id = "\(time)-\(city ?? City())-\(weathers.first?.id ?? 0)"
        }
    }
}
