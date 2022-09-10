//
//  BlurBG.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI

struct BlurBG: UIViewRepresentable {
    func makeUIView(context _: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        return view
    }

    func updateUIView(_: UIVisualEffectView, context _: Context) {}
}
