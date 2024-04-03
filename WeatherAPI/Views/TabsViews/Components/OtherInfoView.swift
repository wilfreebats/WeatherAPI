//
//  OtherInfoView.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 4/2/24.
//

import SwiftUI

struct OtherInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("Other info:")
                .bold().padding(.bottom)
            
            HStack {
                Image(systemName: "wind.circle.fill")
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, content: {
                    Text("Wind speed")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    
                    //Text("\(String(format: "%.1f", vm.weather?.wind.speed ?? 0))km/h")
                    Text("24 km/h")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                })
                
                Spacer()
                
                Image(systemName: "eye.fill")
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, content: {
                    Text("Visibility")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    
                    //Text("\(vm.visibilityFormatter(data: vm.weather?.visibility ?? 0)) km")
                    Text("10km")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                })
            }
            
            HStack {
                Image(systemName: "humidity.fill")
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, content: {
                    Text("Humidity")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    
                    //Text("\(vm.weather?.main.humidity ?? 0)%")
                    Text("79%")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                })
                
                Spacer()
                
                Image(systemName: "thermometer.low")
                    .font(.system(size: 30))
                
                VStack(alignment: .leading, content: {
                    Text("Min temp")
                        .font(.system(size: 15))
                        .fontWeight(.light)
                    
                    //Text("\(String(format: "%.1f", vm.weather?.main.tempMin ?? 0))°C")
                    Text("35°C")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                })
            }
        })
        .frame(maxWidth: 310, alignment: .leading)
        .padding()
        .padding(.bottom, 20)
        .background(Color(uiColor: .secondarySystemBackground))
        .cornerRadius(20)
    }
}

#Preview {
    OtherInfoView()
}
