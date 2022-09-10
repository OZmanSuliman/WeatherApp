//
//  Weather.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

struct WeatherRow: View {
    var weatherVM: WeatherModel
    var presenter: WeatherRowPresenterProtocol

    init(weatherVM: WeatherModel, presenter: WeatherRowPresenterProtocol = WeatherRowPresenterPresenter()) {
        self.presenter = presenter
        self.weatherVM = weatherVM
    }

    var body: some View {
        HStack(alignment: .top) {
            Text(self.weatherVM.date ?? "")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding([.top, .leading])
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width * 0.45, alignment: .leading)
            
            Spacer()
            ImageView(id: self.weatherVM.weather.first?.icon ?? "")
                .frame(width: UIScreen.main.bounds.width * 0.15, height: 60, alignment: .center)
            
            Spacer()
            Text(presenter.temp(temp: "\(self.weatherVM.main?.temp ?? 0)"))
                .font(.system(size: 17))
                .foregroundColor(.gray)
                .padding([.top, .trailing])
                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .center)
                
        }
    }
}
