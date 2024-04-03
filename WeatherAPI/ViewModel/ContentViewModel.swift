//
//  ViewModel.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/1/24.
//

import Foundation
import CoreLocation

class ContentViewModel: ObservableObject {
    
    func getUVCondition(uvValue: Int) -> String {
        switch uvValue {
            case 0...2:
                return "Low"
            case 3...5:
                return "Mod"
            case 6...7:
                return "High"
            case 8...10:
                return "Max"
            case 11...100:
                return "Extrm"
            default:
                return "No Data"
        }
    }
     
}
