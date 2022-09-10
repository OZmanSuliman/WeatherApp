//
//  WeatherMappable.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import ObjectMapper

extension Weather: Mappable{
  
    convenience init?(map: Map) {
       self.init()
   }
   
   func mapping(map: Map) {
       id <- map["id"]
       main <- map["main"]
       weatherDescription <- map["description"]
       icon <- map["icon"]
   }
}

