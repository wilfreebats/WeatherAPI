//
//  CityModel.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/5/24.
//

import Foundation

struct CitiesModel: Codable, Identifiable {
    var id = UUID()
    let city: String
    let isFavorite: Bool
}

