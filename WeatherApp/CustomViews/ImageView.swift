//
//  ImageView.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import SwiftUI
import URLImage

// MARK: - ImageView

struct ImageView: View {
    let imageURL: URL

    init(id: String) {
        #warning("move url to presenter")
        imageURL = URL(string: EnvironmentManager.shared.iconUrl(id: id) ?? "NA")!
    }

    var body: some View {
        URLImage(imageURL) {
            // This view is displayed before download starts
            ActivityIndicatorView()
        }
        inProgress: { _ in
            // Display progress
            ActivityIndicatorView()
        } failure: { _, _ in
            // Display error and retry button
            Image("mountains")
                .resizable()
                .frame(width: 25, height: 25)
        } content: { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

// MARK: - ImageView_Previews

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(id: "01n")
    }
}
