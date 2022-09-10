//
//  SearchScreen.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Combine
import MapKit
import SwiftUI

// MARK: - SearchScreen

struct SearchScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var mapSearch = MapSearch()
    var city = PassthroughSubject<String, Never>()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        TextField("Address", text: $mapSearch.searchTerm)
                        Button(action: {
                            self.endSearch(result: mapSearch.searchTerm)
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }) {
                            Text("Done")
                        }
                    }
                }
                Section {
                    ForEach(mapSearch.locationResults, id: \.self) { location in
                        VStack(alignment: .leading) {
                            Text(location.title)
                            Text(location.subtitle)
                                .font(.system(.caption))
                        }
                        .onTapGesture {
                            var city = location.title
                            if let dotRange = city.range(of: ",") {
                                city.removeSubrange(dotRange.lowerBound..<city.endIndex)
                            }
                            
                            self.endSearch(result: city)
                        }
                    }
                }
            }.navigationTitle(Text("Address search"))
        }
    }
}

extension SearchScreen {
    func endSearch(result: String) {
        city.send(result)
        presentationMode.wrappedValue.dismiss()
    }
}
