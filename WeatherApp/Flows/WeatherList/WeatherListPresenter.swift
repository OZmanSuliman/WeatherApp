//
//  WeatherListPresenter.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Foundation
import RealmSwift

// MARK: - WeatherListPresenterProtocol

protocol WeatherListPresenterProtocol {
    func WeatherListSuccessed(city: String, model: [WeatherModel])
    func WeatherListFaild(error: String)
    func gotLocalDataSuccessfully(localData: [WeatherModel]?)
    func temp(temp: String) -> String
    func getCity() -> String
}

// MARK: - WeatherListPresenter

class WeatherListPresenter {
    private let store = AppState.shared
    private var city = ""
    
    init() {
        store.state = .loading
    }
}

extension WeatherListPresenter {
    func temp(temp: String) -> String {
        if store.unit == 0 {
            return "\(temp) Cº"
        } else {
            return "\(temp)".changeCentigradeToFahrenheit() + " Fº"
        }
    }
}

// MARK: WeatherListPresenterProtocol

extension WeatherListPresenter: WeatherListPresenterProtocol {
    func getCity() -> String {
        return city
    }
    
    func WeatherListFaild(error: String) {
        switch store.state {
        case .loading, .idle:
            store.state = .failed(error)
        default:
            break
        }
    }

    func WeatherListSuccessed(city: String, model: [WeatherModel]) {
        self.city = city
        store.state = .loaded(model)
    }

    func gotLocalDataSuccessfully(localData: [WeatherModel]?) {
        if let localData = localData,
           localData.count > 0 {
            store.state = .loaded(localData)
        } else {
            store.state = .loading
        }
    }
}
