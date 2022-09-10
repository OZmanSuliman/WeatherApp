//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

// MARK: - WeatherAppApp

@main
struct WeatherAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            setInteractor()
        }
    }

    func setInteractor() -> WeatherListScreen {
        if EnvironmentManager.shared.checkIsDev() {
            let apiManager = ApiManagerMock()
            let presenter: WeatherListPresenterProtocol = WeatherListPresenter()
            let interactor: WeatherListInteractorProtocol = WeatherListInteractorMock(apiManager: apiManager, presenter: presenter)
            return WeatherListScreen(interactor: interactor, presenter: presenter)
        } else {
            let apiManager = ApiManager()
            let presenter: WeatherListPresenterProtocol = WeatherListPresenter()
            let interactor: WeatherListInteractorProtocol = WeatherListInteractor(apiManager: apiManager, presenter: presenter)
            return WeatherListScreen(interactor: interactor, presenter: presenter)
        }
    }
}
