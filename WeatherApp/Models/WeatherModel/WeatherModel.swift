//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import RealmSwift

// MARK: - WeatherListModel

final class WeatherModel: Object, Identifiable {
    var dt: Int?
    var time: Int?
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var city: City?
    @Persisted var date: String?
    @Persisted var main: MainDetails?
    @Persisted var weather = List<Weather>()
    @Persisted var visibility: Int?
    @Persisted var pop: Double?
    @Persisted var wind: Wind?
}
