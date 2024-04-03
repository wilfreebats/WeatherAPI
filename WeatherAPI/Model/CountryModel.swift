//
//  CityModel.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/3/24.
//

import Foundation

struct CountryModel: Codable {
    let msg: String
    let data: [Datum]
}
struct Datum: Codable, Hashable {
    let iso2, iso3, country: String
    let cities: [String]
}


