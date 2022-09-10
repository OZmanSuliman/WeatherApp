//
//  Weather.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI


// MARK: - WeatherListScreen

struct WeatherListScreen: View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    let interactor: WeatherListInteractorProtocol
    let presenter: WeatherListPresenterProtocol
    
    init(interactor: WeatherListInteractorProtocol, presenter: WeatherListPresenterProtocol) {
        self.interactor = interactor
        self.presenter = presenter
    }
    
    var body: some View {
        NavigationView {
            switch store.state {
            case let .loaded(weatherList):
                WeatherListContentView(interactor: interactor, defaultCity: presenter.getCity(), weatherList: weatherList)
                    .background(Color.white)
                    .navigationBarHidden(true)
            case let .failed(error):
                WeatherListErrorView(error: error)
                    .navigationBarHidden(true)
                    .background(Color.white)
            case .loading:
                WeatherListLoadingView()
                    .navigationBarHidden(true)
                    .background(Color.white)
            case .idle:
                WeatherListErrorView(error: "NA")
                    .navigationBarHidden(true)
                    .background(Color.white)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#if DEBUG
    struct WeatherList_Previews: PreviewProvider {
        static var previews: some View {
            WeatherListScreen(interactor:  WeatherListInteractor(apiManager: ApiManagerMock(), presenter: WeatherListPresenter()), presenter: WeatherListPresenter())
        }
    }
#endif
