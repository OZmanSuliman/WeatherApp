//
//  Weather.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import RealmSwift

// MARK: - Weather

final class Weather: Object {
    @Persisted var id: Int?
    @Persisted var main: String?
    @Persisted var weatherDescription: String?
    @Persisted var icon: String?

}
