//
//  ViewController.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 29/02/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class DeviseViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var montantTf: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        DeviseService.getTauxDollars()
//        print("ok")
//        WeatherService.getWeather(city: Weather.MONTDEMARSAN)
        montantTf.inputAccessoryView = addToolBarInKeyboard(methodeName: "actionDone")
//        DeviseService.getTaux(deviseSourceCode: "EUR", deviseTargetCode: "USD")
        var t = Translation(text: "Bonjour")
        t.getTranslation { (Bool, Translation) in
            if Bool {
                print(Translation.translatedText)
                print(Translation.sourceLanguage)
            }
        }
        img.load(url: URL(string: "http://openweathermap.org/img/wn/01d@2x.png")!)
             WeatherTest(cityName: WeatherTest.MONTDEMARSAN).getWeather()

        
    }
    @objc func actionDone() {
        view.endEditing(true)
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
