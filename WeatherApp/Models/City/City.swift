//
//  City.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Foundation
import RealmSwift

// MARK: - Weather

final class City: Object {
    @Persisted var id: Int?
    @Persisted var name: String?
}
