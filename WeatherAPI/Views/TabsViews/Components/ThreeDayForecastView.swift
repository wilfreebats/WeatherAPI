//
//  ThreeDayForecastView.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 3/28/24.
//

import SwiftUI

struct ThreeDayForecastView: View {
    
    var ForecastDay: String = ""
    var temp: String = ""
    var windDirection: String = ""
    var windSpeed: String = ""
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text(ForecastDay)
                .bold()
                .font(.system(size: 18))
                .padding(.bottom, 3)
                .foregroundStyle(.secondary)
                .padding(.bottom, 15)
            
            Label("", systemImage: "sun.max")
                .foregroundStyle(.blue)
                .font(.system(size: 30))
                .padding(.bottom, 5)
            
            Text(temp)
                .fontWeight(.medium)
                .font(.system(size: 17))
                .foregroundStyle(.secondary)
                .padding(.bottom, 5)
            
            Image(systemName: "location.north.fill")
                .font(.system(size: 25))
                .foregroundStyle(.blue)
                .rotationEffect(.init(degrees: Double(windDirection)!))
                .padding(.bottom, 5)
            
            Text(windSpeed)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .font(.system(size: 17))
        }
        .padding(.leading, 20)
        .padding(.trailing, 20)
    }
}

#Preview {
    ThreeDayForecastView(ForecastDay: "Tomorrow", temp: "23°-32°C", windDirection: "45", windSpeed: "23 km/h")
}
