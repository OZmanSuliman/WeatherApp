//
//  WeatherListLoadingView.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Shimmer
import SwiftUI

// MARK: - WeatherListLoadingView

struct WeatherListLoadingView: View {
    @StateObject var store = AppState.shared
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var appBarHeight: CGFloat = 3.5

    var body: some View {
        AnimatedTopView(headView: setHead(), bodyView: setBody())
    }
}

extension WeatherListLoadingView {
    func setHead() -> AnyView {
        return AnyView(
            VStack {
                Text("")
                    .frame(width: 180, height: 30)
                    .background(Color.gray)
                    .shimmering()
                Text("")
                    .frame(width: 150, height: 20)
                    .background(Color.gray)
                    .padding(5)
                    .shimmering()
                Text("")
                    .frame(width: 60, height: 30)
                    .background(Color.gray)
                    .shimmering()
                    .padding()
            }
        )
    }

    func setBody() -> AnyView {
        AnyView(
            VStack {
                Spacer(minLength: 100)
                #warning("make the three view as view refrences")
                HStack(alignment: .top) {
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 180, height: 20)
                        .background(Color.gray)
                    Spacer(minLength: 0)
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 20, height: 20)
                        .background(Color.gray)
                    Spacer(minLength: 0)
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 80, height: 20)
                        .background(Color.gray)
                }
                .padding()
                .shimmering()

                HStack(alignment: .top) {
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 180, height: 20)
                        .background(Color.gray)
                    Spacer(minLength: 0)
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 20, height: 20)
                        .background(Color.gray)
                    Spacer(minLength: 0)
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 80, height: 20)
                        .background(Color.gray)
                }
                .padding()
                .shimmering()

                HStack(alignment: .top) {
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 180, height: 20)
                        .background(Color.gray)
                    Spacer(minLength: 0)
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 20, height: 20)
                        .background(Color.gray)
                    Spacer(minLength: 0)
                    Text("")
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                        .frame(width: 80, height: 20)
                        .background(Color.gray)
                }
                .padding()
                .shimmering()
            }
            .padding()
        )
    }
}

#if DEBUG
    struct WeatherListLoadingView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherListLoadingView()
        }
    }
#endif
