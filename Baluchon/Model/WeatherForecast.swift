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
    
    static let MONTDEMARSAN = "Mont-de-Marsan"
    static let NEWYORK = "Paris"
    
    var city: String
    var state: String?
    var temp: Double?
    var icon: String?
    
    init(cityName: String, completionHandle: @escaping (Bool) -> Void) {
        self.city = cityName
        getWeather(completionHandle: completionHandle)
    }
    
    func getWeather(completionHandle: @escaping (Bool) -> Void)  {
        var weatherUrl = URLComponents(string: "http://api.openweathermap.org/data/2.5/forecast?")
        weatherUrl?.queryItems = [URLQueryItem(name: "q", value: self.city), URLQueryItem(name: "APPID", value: ApiKey.openWeatherMap), URLQueryItem(name: "units", value: "metric"), URLQueryItem(name: "lang", value: "fr")]
        var request = URLRequest(url: (weatherUrl?.url!)!)
        request.httpMethod = "POST"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                print(String(data: data!, encoding: .utf8))
                guard let data = data, error == nil else {
                    completionHandle(false)
                        return
                    }
                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandle(false)
                        return
                    }
                do {
                    let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    let weather = weatherResponse.list[0].weather[0]
                    self.state = weather.weatherDescription
                    self.icon = weather.icon
                    self.temp = weatherResponse.list[0].main.temp
                    print(self.icon)
                    completionHandle(true)
                } catch  {
                   print(error)
                    completionHandle(false)
                }
                
            }
        }
        
        
        task.resume()
    }
    
    
    
}
// MARK: - OpenWeather
struct WeatherResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat: Double
    let lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}
