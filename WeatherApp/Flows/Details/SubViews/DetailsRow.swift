//
//  DetailsRow.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

struct SettingRow: View {
    var title: String
    var value: String

    init(title: String, value: String) {
        self.title = title
        self.value = value
    }

    var body: some View {
        HStack {
            Text("\(title)")
            Spacer()
            Text("\(value)")
        }
    }
}
