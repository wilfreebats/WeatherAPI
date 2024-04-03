//
//  SearchViewModel.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/3/24.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var countryModel : CountryModel?
    @Published var searchText = ""
    
    @Published var cityModel: [CitiesModel] = [
        CitiesModel(city: "Cebu City", isFavorite: false),
        CitiesModel(city: "Mandaue", isFavorite: true),
        CitiesModel(city: "Danao", isFavorite: true),
        CitiesModel(city: "Compostela", isFavorite: false),
        CitiesModel(city: "Bais", isFavorite: true),
        CitiesModel(city: "Bayawan", isFavorite: false),
        CitiesModel(city: "Bogo", isFavorite: false),
        CitiesModel(city: "Canlaon", isFavorite: true),
        CitiesModel(city: "Carcar", isFavorite: false),
        CitiesModel(city: "Dumaguete", isFavorite: true),
        CitiesModel(city: "Lapu-Lapu City", isFavorite: true),
    ]
    
    let api = "https://countriesnow.space/api/v0.1/countries"
    

    var filteredCities: [CitiesModel] {
        return searchText == "" ? cityModel : cityModel.filter {
            $0.city.lowercased().contains(searchText.lowercased())
        }
    }
    

    
    func fetchCountries() {
        
        var request = URLRequest(url: URL(string: "https://countriesnow.space/api/v0.1/countries")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let decoded = try JSONDecoder().decode(CountryModel.self, from: data)
                DispatchQueue.main.async {
                    self.countryModel = decoded
                }
                
            } catch {
                print(error.localizedDescription)
            }
          //print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
 
    
}
