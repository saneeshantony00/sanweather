//
//  ContentView.swift
//  sanweather
//
//  Created by saneesh antony on 2022-08-18.
//

import SwiftUI

struct ContentView: View {    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
 //   @State var weather: ResponceBody?
    @State var weather: ResponseBody?
    
    var body: some View {// var body opening
        VStack {
            if let location = locationManager.location { //1.if open
                if let weather = weather {
                    Text("weather data fetched")   //Text("your coordinates are : \(location.latitude),\(location.longitude)")
                    //modified
                }else{
                    LoadingView()
                        .task {
                            do{
                                try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude )
                            }catch{
                                print("error weather fetching data\(error)")
                            }
                        }
                }
    
            }else {
                if locationManager.isLoading {
                    LoadingView()
                }else{
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .background(Color(hue: 0.605, saturation: 0.533, brightness: 0.843))
        .preferredColorScheme(.dark)
    }//var body closing
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
