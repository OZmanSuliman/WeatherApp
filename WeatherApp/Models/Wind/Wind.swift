//
//  Wind.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 08/09/2022.
//

import Foundation
import RealmSwift

// MARK: - Wind

final class Wind: Object {
    @Persisted var speed: Double?
    @Persisted var deg: Int?
    @Persisted var gust: Double?
}
