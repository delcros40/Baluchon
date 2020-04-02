//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 03/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherForcast = WeatherForecast()
    
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
        self.presentAlertWait()
        weatherForcast.getWeather(currentCityId: CityId.MONTDEMARSAN.rawValue) { [weak self] (success, weatherResponse) in
            if success {
                guard let weatherResponse = weatherResponse else { return }
                self?.initialisationComposant(weatherResponse: weatherResponse)
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }
    
    private func initialisationComposant(weatherResponse: WeatherResponse) {
        let weatherNY = weatherResponse.list[1]
        let weatherCurrent = weatherResponse.list[0]
        self.lbCityName1.text = weatherCurrent.name
        self.lbWeatherDesc1.text = weatherCurrent.weather[0].weatherDescription
        self.lbWeatherTemp1.text = "\(Int(weatherCurrent.main.temp))°"
        loadImage(imageName: weatherCurrent.weather[0].icon, imageView: self.IVWeatherIcon1)
        self.lbCityName2.text = weatherNY.name
        self.lbWeatherDesc2.text = weatherNY.weather[0].weatherDescription
        self.lbWeatherTemp2.text = "\(Int(weatherNY.main.temp))°"
        loadImage(imageName: weatherNY.weather[0].icon, imageView: self.IVWeatherIcon2)
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
