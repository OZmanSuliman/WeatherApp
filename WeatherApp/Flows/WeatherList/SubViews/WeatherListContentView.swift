//
//  WeatherListContentView.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import CoreLocation
import SwiftUI

// MARK: - WeatherListContentView

struct WeatherListContentView: View {
    @StateObject var store = AppState.shared
    @ObservedObject var location = LocationManager.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State private var appBarHeight: CGFloat = 3.5
    @State private var orientation = UIDeviceOrientation.unknown
    @State var city: String
    let weatherList: [WeatherModel]
    var presenter: WeatherRowPresenterProtocol
    var animatedTopView: AnimatedTopView?
    let interactor: WeatherListInteractorProtocol

    init(interactor: WeatherListInteractorProtocol, defaultCity: String, weatherList: [WeatherModel], presenter: WeatherRowPresenterProtocol = WeatherRowPresenterPresenter()) {
        self.interactor = interactor
        _city = State(initialValue: defaultCity)
        self.weatherList = weatherList
        self.presenter = presenter
        location.delegate = self
        location.startUpdating()
        animatedTopView = AnimatedTopView(headView: setHead(), bodyView: setBody())

        if UIDevice.current.orientation.isLandscape {
            appBarHeight = 2.0
        }
    }

    var body: some View {
        animatedTopView
            .onReceive(animatedTopView!.city) { searchedCity in
                city = searchedCity
                interactor.fetchWeather(city: city)
            }
    }
}

extension WeatherListContentView {
    func setHead() -> AnyView {
        return AnyView(
            VStack {
                Text(city)
                    .font(.system(size: 35))
                    .fontWeight(.semibold)
                    .padding(0.0)
                    .foregroundColor(.black)
                if let desc = weatherList.first?.weather.first?.weatherDescription {
                    Text(desc)
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                        .fontWeight(.regular)
                        .padding(.bottom)
                } else {
                    Spacer()
                }
                if let temp = weatherList.first?.main?.temp {
                    Text(presenter.temp(temp: "\(temp)"))
                        .font(.system(size: 45))
                        .fontWeight(.thin)
                        .foregroundColor(.black)
                } else {
                    Spacer()
                }
            }
        )
    }

    func setBody() -> AnyView {
        AnyView(
            VStack {
                HStack {
                    Text("Coming Days")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer()
                }
                if !weatherList.isEmpty {
                    VStack(spacing: 20) {
                        ForEach(weatherList) { item in
                            NavigationLink(destination: DetailsScreen(model: item)) {
                                WeatherRow(weatherVM: item)
                            }
                            .overlay(Divider(), alignment: .bottom)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }.padding(.top)
                } else {
                    Spacer()
                    Text("No Data Available About the Weather\nFor Your Beautiful City 😢")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.top, 50)
                    Spacer()
                }
            }
            .padding()
        )
    }
}

// MARK: LocationManagerProtocol

extension WeatherListContentView: LocationManagerProtocol {
    func permissionChanged() {
        interactor.fetchWeather(nil)
    }
}
