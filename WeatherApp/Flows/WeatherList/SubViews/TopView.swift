//
//  TopView.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    Image("mountains")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Weather App")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                }
                Text("One Month free, then $4.99/month.")
                    .font(.caption)
                    .foregroundColor(.black)
                    .foregroundColor(.gray)
            }
            Spacer(minLength: 0)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top == 0 ? 15 : (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 5)
        .padding([.leading, .bottom])
        .background(BlurBG())
    }
}

