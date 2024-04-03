//
//  WeatherNowViewModel.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/3/24.
//

import Foundation

class WeatherNowViewModel: ObservableObject {
    
    func getCondition(conditionId: Int) -> String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.rain.fill"
        case 500...504:
            return "cloud.sun.rain.fill"
        case 511:
            return "snowflake"
        case 520...531:
            return "cloud.snow.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.drizzle.fill"
        case 800:
            return "sun.max.fill"
        case 801:
            return "cloud.sun.fill"
        case 802:
            return "cloud.fill"
        case 803:
            return "smoke.fill"
        case 804:
            return "smoke.fill"
        default:
            return "cloud"
        }
    }
}
