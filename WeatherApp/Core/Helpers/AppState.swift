//
//  AppState.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Combine
import SwiftUI

// MARK: - WeatherStateEnum

enum WeatherStateEnum: Equatable {
    case idle
    case loading
    case failed(String)
    case loaded([WeatherModel])
}

// MARK: - AppState

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var unit = 0
    @Published var isNotificationsOn = false
    @Published var state = WeatherStateEnum.idle
    @Published var result: Result<WeatherModel, Error>?
    @Published private(set) var time = Date().timeIntervalSince1970
    private var cancellable: AnyCancellable?

    init() {
        unit = UserDefaults.standard.integer(forKey: "unit")
        isNotificationsOn = UserDefaults.standard.bool(forKey: "isNotificationsOn")
    }

    func saveIsNotificationsOn() {
        UserDefaults.standard.set(isNotificationsOn, forKey: "isNotificationsOn")
    }

    func switchUnit(to unit: Int) {
        self.unit = unit
        UserDefaults.standard.set(self.unit, forKey: "unit")
    }
}

extension AppState {
    func start() {
        cancellable = Timer.publish(
            every: 1,
            on: .main,
            in: .default
        )
        .autoconnect()
        .sink { date in
            self.time = date.timeIntervalSince1970
        }
    }

    func stop() {
        cancellable = nil
    }
}
