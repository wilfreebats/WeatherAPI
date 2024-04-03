//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/1/24.
//

import Foundation

struct WeatherModel: Codable {
    let coord: Coord
    let wind: Wind
    let weather: [Weather]
    let main: Main
    let name: String
    
    //static var sampleData = WeatherModel(coord: Coord(lon: 0, lat: 0), wind: Wind(speed: 0, deg: 0, gust: 0), weather: [Weather], main: Main(temp_min: 0, temp_max: 0), name: "--")
}

struct Coord: Codable {
    let lon, lat: Double
    
    static var sampleDataCoord = Coord(lon: 123, lat: 123)
}

struct Main: Codable {
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
    
    static var sampleData = Main(temp_min: 0, temp_max: 0, humidity: 0)
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct UVModel: Codable {
    let result: Result
}

struct Result: Codable {
    let uv: Double
}
