//
//  ContentView.swift
//  WeatherAPI
//
//  Created by Wilfredo Batucan on 2/1/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var apiCall = APICalls()
    @State private var weather: WeatherModel?
    @State private var uvIndex: UVModel?
    
    @State private var isSearchViewPresented = false
    
    var body: some View {
        NavigationStack {
            if let weather = weather {
                WeatherNowView(weather: weather)
                
                HStack(alignment: .center) {
                    VStack {
                        HStack {
                            Image(systemName: "humidity.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(.blue)
                            
                            Text("\(weather.main.humidity)%")
                                .fontWeight(.medium)
                                .font(.system(size: 25))
                            
                        }
                        
                        Divider()
                        Text("HUMIDITY")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 13))
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "location.north.fill")
                                .font(.system(size: 25))
                                .foregroundStyle(.blue)
                                .rotationEffect(.init(degrees: Double(weather.wind.deg)))
                            
                            Text("\(String(format: "%.0f", weather.wind.speed))")
                                .fontWeight(.medium)
                                .font(.system(size: 25))
                            
                        }
                        
                        Divider()
                        Text("WIND m/s")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 13))

                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "sun.max.circle")
                                .font(.system(size: 25))
                                .foregroundStyle(.yellow)
                            
                            if let uvIndexData = apiCall.uvIndexData {
                                Text("\(String(format: "%.0f", uvIndexData.result.uv)) \(vm.getUVCondition(uvValue: Int(uvIndexData.result.uv)))")
                                    .fontWeight(.medium)
                                    .font(.system(size: 25))
                            } else {
                                Text("7 High")
                                    .fontWeight(.medium)
                                    .font(.system(size: 25))
                            }
                            
                            
                        }
                        
                        Divider()
                        Text("UV INDEX")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 13))

                    }
                    
                }
                .padding()
                
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            

            VStack {
                Text("TIDE - (Need Subscription)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                Divider()
            }
            .padding()
            
            HStack {
                HStack {
                    Image(systemName: "water.waves.and.arrow.up")
                        .font(.system(size: 22))
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("8:00 AM")
                            .foregroundStyle(.primary)
                            .font(.system(size: 12))
                        Text("1.7m")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18))
                    }
                }
                
                HStack {
                    Image(systemName: "water.waves.and.arrow.down")
                        .font(.system(size: 22))
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("2:00 PM")
                            .foregroundStyle(.primary)
                            .font(.system(size: 12))
                        Text("0.8m")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18))
                    }
                }
                
                HStack {
                    Image(systemName: "water.waves.and.arrow.up")
                        .font(.system(size: 22))
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("7:50 PM")
                            .foregroundStyle(.primary)
                            .font(.system(size: 12))
                        Text("0.7m")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18))
                    }
                }
                
                HStack {
                    Image(systemName: "water.waves.and.arrow.down")
                        .font(.system(size: 22))
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("3:00 AM")
                            .foregroundStyle(.primary)
                            .font(.system(size: 12))
                        Text("0.3m")
                            .foregroundStyle(.secondary)
                            .font(.system(size: 18))
                    }
                }
            }
            
            VStack(alignment: .leading) {
                Divider()
                
                Text("NEXT 3 DAYS - (Need Subscription)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
                    .padding(.top, 10)
            }
            .padding()
            
            HStack {
                ThreeDayForecastView(ForecastDay: "Tomorrow", temp: "23°-32°C", windDirection: "45", windSpeed: "23 km/h")
                ThreeDayForecastView(ForecastDay: "Friday", temp: "24°-30°C", windDirection: "30", windSpeed: "14 km/h")
                ThreeDayForecastView(ForecastDay: "Saturday", temp: "23°-28°C", windDirection: "55", windSpeed: "7 km/h")
                
            }

            
            .onAppear() {
                locationManager.requestLocation()
            }
            .onReceive(locationManager.$location) { location in
                guard let location = location else { return }
                Task {
                    do {
                        let data = try await apiCall.fetchWeatherFromAPIWithCoordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        //let data = try await vm.fetchWeatherFromAPI()
                        weather = data
                        print(data)
                        
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                apiCall.fetchUVAPI(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            
            
            Spacer()
            
            
            
            .padding()
            .navigationTitle("Weather Now")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        locationManager.requestLocation()
                        let lat = locationManager.location?.coordinate.latitude
                        let lon = locationManager.location?.coordinate.longitude
                        if lat != nil && lon != nil {
                            Task {
                                do {
                                    let data = try await apiCall.fetchWeatherFromAPIWithCoordinates(latitude: lat!, longitude: lon!)
                                    weather = data
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                        
                    }, label: {
                        Label("", systemImage: "location.fill")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSearchViewPresented.toggle()
                        
                    } label: {
                        Label("", systemImage: "location.magnifyingglass")
                    }
                }
            }
            .sheet(isPresented: $isSearchViewPresented, content: {
                SearchView(weather: $weather)
            })
            
        }
    }
    
   
}

#Preview {
    ContentView()
}
