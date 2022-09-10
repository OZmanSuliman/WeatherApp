//
//  MainDetails.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import RealmSwift

// MARK: - MainDetails

final class MainDetails: Object {
    @Persisted var temp: Int?
    @Persisted var feelsLike: Double?
    @Persisted var tempMin: Double?
    @Persisted var tempMax: Double?
    @Persisted var pressure: Int?
    @Persisted var seaLevel: Int?
    @Persisted var grndLevel: Int?
    @Persisted var humidity: Int?
    @Persisted var tempKf: Double?
}
