//
//  WeatherNowView.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/1/24.
//

import SwiftUI

struct WeatherNowView: View {
    @StateObject var weatherNowViewModel = WeatherNowViewModel()
    let weather : WeatherModel
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Label("", systemImage: weatherNowViewModel.getCondition(conditionId: weather.weather[0].id))
                        .foregroundStyle(.blue)
                        .font(.system(size: 50))
                    
                    Text("\(String(format: "%.0f", weather.main.temp_min))°- \(String(format: "%.0f", weather.main.temp_max))°C")
                        .fontWeight(.medium)
                        .font(.system(size: 28))
                }
                
                VStack(alignment: .leading) {
                    Text("\(weather.name)")
                        .bold()
                        .font(.system(size: 20))
                        .padding(.bottom, 3)
                    Text("\(String(format: "%.4f", weather.coord.lat))° \(String(format: "%.4f", weather.coord.lon))° ")
                        .foregroundStyle(.secondary)
                }
                .padding(.bottom, 30)
                .padding(.top, 15)
            }
        }
        .padding()
    }
    
}

//#Preview {
//    WeatherNowView(weather: WeatherModel.sampleData)
//}
