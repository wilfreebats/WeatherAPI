//
//  SearchView.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/3/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var searchViewModel = SearchViewModel()
    @StateObject private var apiCall = APICalls()
    
    @State private var selectionTab = TabSection.all
    
    @Binding var weather: WeatherModel?
    
    enum TabSection {
          case all, favorites
        }
    
    @State private var showFavoritesOnly = false
    
    var filter: [CitiesModel] {
        searchViewModel.cityModel.filter { city in
            (city.isFavorite)
        }
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Tab Date", selection: $selectionTab) {
                    Text("All Cities").tag(TabSection.all)
                    Text("Favorites").tag(TabSection.favorites)
                }
                .pickerStyle(.segmented)
                
//                Toggle(isOn: $showFavoritesOnly, label: {
//                    Text("Favorites Only")
//                })
                
               
                switch selectionTab {
                case .all:
                    ForEach(searchViewModel.filteredCities) { city in
                        HStack {
                            Text(city.city)
                            Spacer()
                            
                            if city.isFavorite {
                                Image(systemName: "suit.heart.fill")
                                    .foregroundStyle(.red)
                                
                            } else {
                                Image(systemName: "suit.heart")
                                    .foregroundStyle(.red)

                            }
                        }
                        .onTapGesture {
                            Task {
                                do {
                                    weather = try await apiCall.fetchWeatherFromCityName(cityName: city.city)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            dismiss()
                        }
                    }
                case .favorites:
                    ForEach(filter) { city in
                        HStack {
                            Text(city.city)
                            Spacer()
                            
                            if city.isFavorite {
                                Image(systemName: "suit.heart.fill")
                                    .foregroundStyle(.red)
                                
                            } else {
                                Image(systemName: "suit.heart")
                                    .foregroundStyle(.red)

                            }
                        }
                        .onTapGesture {
                            Task {
                                do {
                                    weather = try await apiCall.fetchWeatherFromCityName(cityName: city.city)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            dismiss()
                        }
                    }
                }
                
            }

            
            .navigationTitle("Search City")
            .searchable(text: $searchViewModel.searchText)

            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("", systemImage: "xmark.circle.fill")
                    }

                }
            }
        }
    }
}
//
//#Preview {
//    SearchView()
//}
