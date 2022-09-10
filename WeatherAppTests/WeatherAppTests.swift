//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Osman Ahmed on 07/09/2022.
//

import RealmSwift
@testable import WeatherApp
import XCTest

class WeatherAppTests: XCTestCase {
    var apiManager: ApiManager!
    var environmentManager: EnvironmentManager!
    var weatherListPresenter: WeatherListPresenterProtocol!
    var weatherListInteractor: WeatherListInteractor!
    var settingPresenter: SettingPresenterProtocol!
    var settingInteractor: SettingsInteractorProtocol!
    var detailScreenPresenter: DetailScreenPresenterProtocol!
    var detailsInteractor: DetailsInteractorProtocol!
    var store: AppState!

    override func setUpWithError() throws {
        weatherListPresenter = WeatherListPresenter()
        settingInteractor = SettingsInteractor()
        settingPresenter = SettingPresenter()
        detailScreenPresenter = DetailScreenPresenter()
        detailsInteractor = DetailsInteractor()
        apiManager = ApiManager()
        store = AppState.shared
    }

    override func tearDownWithError() throws {
        environmentManager = nil
        apiManager = nil
        weatherListInteractor = nil
        weatherListPresenter = nil
        settingInteractor = nil
        settingPresenter = nil
        detailScreenPresenter = nil
        detailsInteractor = nil
        store = AppState()
    }

    func test_interactor() {
        let expectation = self.expectation(description: "interactor")
        XCTAssertNotNil(store.state)
        weatherListInteractor.fetchWeather {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 9, handler: nil)
        XCTAssertNotEqual(store.state, WeatherStateEnum.loading)
    }

    func test_Presenter_faild() {
        store.state = .idle
        weatherListPresenter.WeatherListFaild(error: "error")
        XCTAssertEqual(store.state, WeatherStateEnum.failed("error"))
    }

    func test_temp() {
        store.unit = 0
        XCTAssertNotNil(weatherListPresenter.temp(temp: "21"))
        store.unit = 1
        XCTAssertNotNil(weatherListPresenter.temp(temp: "21"))
    }
}
