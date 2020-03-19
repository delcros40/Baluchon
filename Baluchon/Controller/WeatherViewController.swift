//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 03/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherFirstCity: WeatherForecast?
    var weatherSecondCity: WeatherForecast?
    
    @IBOutlet weak var lbCityName1: UILabel!
    @IBOutlet weak var lbWeatherDesc1: UILabel!
    @IBOutlet weak var lbWeatherTemp1: UILabel!
    @IBOutlet weak var IVWeatherIcon1: UIImageView!
    @IBOutlet weak var lbCityName2: UILabel!
    @IBOutlet weak var lbWeatherDesc2: UILabel!
    @IBOutlet weak var lbWeatherTemp2: UILabel!
    @IBOutlet weak var IVWeatherIcon2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherFirstCity = WeatherForecast(cityName: WeatherForecast.MONTDEMARSAN) { (success) in
            if success {
                self.updateFirstCity(weatherForecast: self.weatherFirstCity!)
            } else {
                self.presentAlertError(message: "Erreur lors du chargement des données")
            }
        }
        weatherSecondCity = WeatherForecast(cityName: WeatherForecast.NEWYORK, completionHandle: { (success) in
            if success {
                self.updateSecondCity(weatherForecast: self.weatherSecondCity!)
            } else {
                self.presentAlertError(message: "Erreur lors du chargement des données")
            }
        })
    }
    
    private func updateFirstCity( weatherForecast: WeatherForecast) {
        self.lbCityName1.text = weatherForecast.city
        self.lbWeatherDesc1.text = weatherForecast.state
        self.lbWeatherTemp1.text = "\(Int(weatherForecast.temp!))°"
        loadImage(imageName: weatherForecast.icon!, imageView: self.IVWeatherIcon1)
    }
    
    private func updateSecondCity( weatherForecast: WeatherForecast) {
       self.lbCityName2.text = weatherForecast.city
        self.lbWeatherDesc2.text = weatherForecast.state
        self.lbWeatherTemp2.text = String(weatherForecast.temp!)
        loadImage(imageName: weatherForecast.icon!, imageView: self.IVWeatherIcon2)
    }
    
    
    private func loadImage(imageName: String, imageView: UIImageView) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: "http://openweathermap.org/img/wn/\(imageName)@2x.png")!) {
                if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageView.image = img
                    }
                }
            }
        }
    }

}
