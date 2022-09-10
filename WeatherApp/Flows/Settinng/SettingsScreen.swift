//
//  Settings.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var store = AppState.shared
    private var interactor: SettingsInteractorProtocol

    init(interactor: SettingsInteractorProtocol = SettingsInteractor()) {
        self.interactor = interactor
    }

    var body: some View {
        List {
            Section {
                UnitRow()
                    .buttonStyle(BorderlessButtonStyle())
                Toggle("Local Notifications", isOn: $store.isNotificationsOn)
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .onChange(of: $store.isNotificationsOn.wrappedValue, perform: { value in
                        #warning("move code below to indicator")
                        store.saveIsNotificationsOn()
                        if value == true {
                            LocalNotificationManager().switchNotification(title: "title", subtitle: "subtitle")
                        }
                    })
            }
        }

        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("Settings")
        .navigationBarItems(leading: CustomBackButton(presentationMode: presentationMode))
    }
}
