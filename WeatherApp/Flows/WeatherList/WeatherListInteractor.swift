//
//  WeatherListInteractor.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Alamofire
import CoreLocation
import Foundation
import RealmSwift

// MARK: - WeatherListInteractorProtocol

protocol WeatherListInteractorProtocol {
    func fetchWeather(_ action: ( () -> Void)?)
    func fetchWeather(city: String)
    func getLocalWeather(city: String, action: @escaping (_ localData: [WeatherModel]?) -> Void)
    func saveLocalWeather(list: [WeatherModel]) throws
}

// MARK: - WeatherListInteractor

class WeatherListInteractor {
    private let apiManager: ApiManagerProtocol
    private var data: Data?
    private let decoder = JSONDecoder()
    private let presenter: WeatherListPresenterProtocol
    private let databaseService: DatabaseProtocol!
    init(apiManager: ApiManagerProtocol, presenter: WeatherListPresenterProtocol) {
        self.apiManager = apiManager
        self.presenter = presenter
        databaseService = WeatherDatabaseService()
        fetchWeather()
    }
}

extension WeatherListInteractor {
    func locateCity(action: @escaping (_ city: String?) -> Void) {
        let geoCoder = CLGeocoder()
        let locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!

        switch locManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            currentLocation = locManager.location
        default:
            currentLocation = CLLocation(latitude: 37.3230, longitude: -122.0322)
        }

        geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { placemarks, _ -> Void in

            placemarks?.forEach { placemark in

                if let city = placemark.locality {
                    action(city)
                    return
                }
            }
        })
    }
}

// MARK: WeatherListInteractorProtocol

extension WeatherListInteractor: WeatherListInteractorProtocol {
    
    func fetchWeather(_ action: (() -> Void)? = nil) {
        locateCity { city in
            var wrappedCity = ""
            var stringCity = ""
            if let city = city {
                stringCity = city
                wrappedCity = city.replacingOccurrences(of: " ", with: "%20")
            } else {
                stringCity = "cupertino"
                wrappedCity = "cupertino"
            }

            self.getLocalWeather(city: wrappedCity) { localData in
                self.presenter.gotLocalDataSuccessfully(localData: localData)

                let request = FetchWeatherRequest(city: wrappedCity)
                self.callWeatherRequest(stringCity: stringCity, request: request)
            }
        }
    }

    func fetchWeather(city: String) {
        var wrappedCity = ""
        wrappedCity = city.replacingOccurrences(of: " ", with: "%20")
        let request = FetchWeatherRequest(city: wrappedCity)
        callWeatherRequest(stringCity: city, request: request)
    }

    func callWeatherRequest(stringCity: String, request: FetchWeatherRequest) {
        apiManager.apiRequest(request, withSuccess: { (response: FetchWeatherResponse?, _, _) in
            if let weatherBaseModel = response?.weatherList {
                // notify presenter
                DispatchQueue.main.async {
                    self.presenter.WeatherListSuccessed(city: stringCity, model: weatherBaseModel)
                }
                // save data locally

                self.saveLocalWeather(list: weatherBaseModel)
            }
        }) { (error: Error) in
            DispatchQueue.main.async {
                #warning("add custom error enum")
                self.presenter.WeatherListFaild(error: error.localizedDescription)
            }
        }
    }

    func getLocalWeather(city: String, action: @escaping (_ localData: [WeatherModel]?) -> Void) {
        let localData: [WeatherModel] = databaseService.fetch()
        let filteredData = localData.filter { item in
            item.city?.name == city
        }
        action(filteredData)
    }

    func saveLocalWeather(list: [WeatherModel]) {
        databaseService.deleteType(model: WeatherModel.self)
        databaseService.save(list)
    }
}
