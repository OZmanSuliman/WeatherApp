//
//  DetailsScreen.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

struct DetailsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var store = AppState.shared
    var model: WeatherModel
    
    var body: some View {
        List {
            #warning("move condition to presenter")
            Section(header: Text("Temperature")) {
                if store.unit == 0 {
                    SettingRow(title: "temp", value: "\(self.model.main?.temp ?? 0) Cº")
                    SettingRow(title: "temp Min", value: "\(self.model.main?.tempMin ?? 0) Cº")
                    SettingRow(title: "temp Max", value: "\(self.model.main?.tempMax ?? 0) Cº")
                } else {
                    Text("\(self.model.main?.temp ?? 0)".changeCentigradeToFahrenheit() + " Fº")
                    
                    SettingRow(title: "temp", value: "\(self.model.main?.temp ?? 0)".changeCentigradeToFahrenheit() + " Fº")
                    SettingRow(title: "temp Min", value: "\(self.model.main?.tempMin ?? 0)".changeCentigradeToFahrenheit() + " Fº")
                    SettingRow(title: "temp Max", value: "\(self.model.main?.tempMax ?? 0)".changeCentigradeToFahrenheit() + " Fº")
                }
            }
            Section(header: Text("Wind")) {
                SettingRow(title: "wind Speed", value: "\(model.wind?.speed ?? 0)")
                SettingRow(title: "wind Deg", value: "\(model.wind?.deg ?? 0)")
            }
            Section(header: Text("Others")) {
                SettingRow(title: "pressure", value: "\(model.main?.pressure ?? 0)")
                SettingRow(title: "how It Feel", value: model.weather.first?.main ?? "")
                SettingRow(title: "Description", value: model.weather.first?.weatherDescription ?? "")
            }
        }
        .navigationBarTitle("Details")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(presentationMode: presentationMode))
    }
}
