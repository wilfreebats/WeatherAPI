//
//  Helpers.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/3/24.
//

import Foundation
import CoreLocation

class APICalls: ObservableObject {
    @Published var weatherData : WeatherModel?
    @Published var uvIndexData : UVModel?
    
    
    func fetchWeatherFromCityName(cityName: String) async throws -> WeatherModel {
        print(cityName)
        let apiKeyWithCity = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=8a4245a424bb6abd962f453726ee8172&units=metric"
        let url = URL(string: apiKeyWithCity)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(WeatherModel.self, from: data)
        
        print("Fetching data ...")
        print(decoded)
        
        return decoded
    }
    
    
    func fetchWeatherFromAPIWithCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherModel {
        let apiKeyWithCoordinates = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=9df97b468123ae26cc85e3d2c9b12e35&units=metric"
        
        print(latitude)
        print(longitude)
        
        let url = URL(string: apiKeyWithCoordinates)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(WeatherModel.self, from: data)
        
        print("Fetching data ...")
        print(decoded)
        
        return decoded
    }
    
    
    func fetchUVAPI(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        var request = URLRequest(url: URL(string: "https://api.openuv.io/api/v1/uv?lat=\(latitude)&lng=\(longitude)")!,timeoutInterval: Double.infinity)
        request.addValue("openuv-1usprls498mjc-io", forHTTPHeaderField: "x-access-token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let decodedData = try JSONDecoder().decode(UVModel.self, from: data)
                DispatchQueue.main.async {
                    print(decodedData)
                    self.uvIndexData = decodedData
                }
            } catch {
                print(error.localizedDescription)
            }
        
          //print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
}
