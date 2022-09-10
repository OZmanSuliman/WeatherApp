//
//  WeatherRowPresenter.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Foundation
import RealmSwift

// MARK: - WeatherRowPresenterProtocol

protocol WeatherRowPresenterProtocol {
    func temp(temp: String) -> String
}

// MARK: - WeatherRowPresenterPresenter

class WeatherRowPresenterPresenter: WeatherRowPresenterProtocol {
    private let store = AppState.shared

    func temp(temp: String) -> String {
        if store.unit == 0 {
            return "\(temp) Cº"
        } else {
            return "\(temp)".changeCentigradeToFahrenheit() + " Fº"
        }
    }
}
