//
//  Weather.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 03/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class WeatherForecast {
    
    var weatherSession: URLSession
    
    init(weatherSession:URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    func getWeather(currentCityId: Int, completionHandle: @escaping (Bool, WeatherResponse?) -> Void) {
        var weatherUrl = URLComponents(string: "http://api.openweathermap.org/data/2.5/group?")
        weatherUrl?.queryItems = [URLQueryItem(name: "id", value: "\(currentCityId),\(CityId.NEWYORK.rawValue)"), URLQueryItem(name: "APPID", value: ApiKey.openWeatherMap), URLQueryItem(name: "units", value: "metric"), URLQueryItem(name: "lang", value: "fr")]
        var request = URLRequest(url: (weatherUrl?.url!)!)
        request.httpMethod = "POST"
        let task = self.weatherSession.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completionHandle(false, nil)
                        return
                    }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandle(false, nil)
                        return
                    }
                guard let responseJSON = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                    completionHandle(false, nil)
                    return
                }
                completionHandle(true, responseJSON)
        }
        task.resume()
    }
    
}

enum CityId: Int {
    case MONTDEMARSAN = 2992771
    case NEWYORK = 5128581
}
