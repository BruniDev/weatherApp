//
//  ContentView.swift
//  WeatherApp
//
//  Created by 정현 on 3/12/24.
//

import SwiftUI
import Combine
import WeatherKit


struct ContentView: View {
   @StateObject private var viewModel = ContentViewViewModel()
    let weatherUtils = WeatherUtils()
    var body : some View {
        VStack{
            if let weather = viewModel.weatherManager.weather {
                ScrollView {
                    VStack {
                        Spacer(minLength: 80)
                        HStack{
                            CurrentLocationView(weather: weather, viewModel: viewModel)
                                .padding(.leading,20)
                            Spacer()
                        }
                        Spacer(minLength: 50)
                        HStack{
                            Spacer()
                            CurrentWeatherInfoView(weather: weather, viewModel: viewModel)
                                .padding(.trailing,30)
                          
                        }
                        
                        Spacer(minLength: 400)
                        CurrentWeatherHourlyView(weather: weather , viewModel: viewModel,weatherUtils: WeatherUtils())
                        WeeklyWeatherView(weather: weather,weatherUtils: WeatherUtils())
                    }
                }
                .ignoresSafeArea(.all)
                .background {
                    WeatherUtils.getWeatherBackground(condition: weather.currentWeather.condition.description)
                        .resizable()
                        .ignoresSafeArea()
                }
            } else {
                VStack {
                    Spacer()
                    Text("새로고침중....")
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(width : 40)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .task {
            await viewModel.weatherManager.requestWeatherForCurrentLocation()
        }
    }
}

//#Preview {
//    ContentView()
//}
//
