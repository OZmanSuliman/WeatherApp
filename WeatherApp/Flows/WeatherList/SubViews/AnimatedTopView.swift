//
//  AnimatedTopView.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Combine
import SwiftUI

// MARK: - AnimatedTopView

struct AnimatedTopView: View {
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var appBarHeight: CGFloat = 3.5
    @State var show = false
    @State private var orientation = UIDeviceOrientation.unknown
    var headView: AnyView
    var bodyView: AnyView
    var searchScreen = SearchScreen()
    var city = PassthroughSubject<String, Never>()

    init(headView: AnyView, bodyView: AnyView) {
        self.headView = headView
        self.bodyView = bodyView
        if UIDevice.current.orientation.isLandscape {
            appBarHeight = 2.0
        }
    }

    var body: some View {
        ZStack(alignment: .top, content: {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .center) {
                    GeometryReader { g in
                        ZStack {
                            Image("cloud")
                                .resizable()
                            VStack {
                                HStack {
                                    NavigationLink(destination: SettingsScreen()
                                        .background(Color.white)) {
                                            Image(systemName: "gear")
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(.black)
                                                .frame(width: 40.0, height: 40.0)
                                                .padding(.top, 40.0)
                                                .padding(.leading, 20.0)
                                    }
                                    Spacer()
                                    NavigationLink(destination: searchScreen
                                        .background(Color.white))
                                    { Image(systemName: "magnifyingglass")
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.black)
                                        .frame(width: 40.0, height: 40.0)
                                        .padding(.top, 40.0)
                                        .padding(.trailing, 20.0)
                                    }
                                }
                                // head content
                                headView
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / appBarHeight + g.frame(in: .global).minY : UIScreen.main.bounds.height / appBarHeight)
                        .onReceive(self.time) { _ in
                            // its not a timer...
                            // for tracking the image is scrolled out or not...
                            let y = g.frame(in: .global).minY
                            if -y > (UIScreen.main.bounds.height / appBarHeight) - 50 {
                                withAnimation {
                                    self.show = true
                                }
                            } else {
                                withAnimation {
                                    self.show = false
                                }
                            }
                        }
                    }
                    // fixing default height...
                    .frame(height: UIScreen.main.bounds.height / appBarHeight + 0.2)
                    // body content
                    bodyView
                }
            })
            if self.show {
                TopView()
            }
        })
            .foregroundColor(.white)
            .ignoresSafeArea(edges: .top)
            .onRotate { newOrientation in
                orientation = newOrientation
                switch newOrientation {
                case .landscapeLeft, .landscapeRight:
                    appBarHeight = 2.0
                case .unknown, .portrait, .portraitUpsideDown, .faceUp, .faceDown:
                    appBarHeight = 3.5
                @unknown default:
                    appBarHeight = 3.5
                }
            }
            .onReceive(searchScreen.city) { city in
                self.city.send(city)
            }
    }
}

// MARK: - AnimatedTopView_Previews

struct AnimatedTopView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTopView(headView: AnyView(Text("")), bodyView: AnyView(Text("")))
    }
}
