//
//  Devise.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 04/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class ConvertionDevise {
    
    /// Entites
    var deviseBase: Devise
    var deviseTarget: Devise = .dollarsUS
    var rate: Double?
    var montant: Double = Double(0)
    var resultat: Double?
    var deviseSession: URLSession
    
    // Initializer
    init(deviseBase: Devise, deviseSession:URLSession = URLSession(configuration: .default)) {
        self.deviseBase = deviseBase
        self.deviseSession = deviseSession
        self.getTaux { (success, deviseResponse) in
            self.rate = deviseResponse?.rates[self.deviseTarget.rawValue]
        }
    }
    
    /// request to API Fixer for get currency exchange rate
     func getTaux(completionHandle: @escaping (Bool, DeviseResponse?) -> Void) {
        var deviseUrl = URLComponents(string: "http://data.fixer.io/api/latest?")
        deviseUrl?.queryItems = [URLQueryItem(name: "access_key", value: ApiKey.keyFixer), URLQueryItem(name: "base", value: self.deviseBase.rawValue), URLQueryItem(name: "symbols", value: self.deviseTarget.rawValue)]
        var request = URLRequest(url: (deviseUrl?.url)!)
        request.httpMethod = "GET"
        let task = deviseSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandle(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandle(false, nil)
                    return
                }
                guard let deviseResponse = try? JSONDecoder().decode(DeviseResponse.self, from: data) else {
                    completionHandle(false, nil)
                    return
                }
                completionHandle(true, deviseResponse)
            }
        }
        task.resume()
    }
    
    func switchDevise() {
        let saveDevise = self.deviseBase
        self.deviseBase = self.deviseTarget
        self.deviseTarget = saveDevise
    }
    
    /// allows you to convert a sum of euros or dollars
    func convertirDevise() {
        if let rate = self.rate {
            if self.deviseBase == Devise.euro {
                self.resultat = self.montant * rate
            } else {
                self.resultat = self.montant / rate
            }
             
        } else {
            self.resultat = 0
        }
        
       
    }
    
}

enum Devise: String {
    case euro = "EUR"
    case dollarsUS = "USD"
    
    var description: String {
        return "\(self.rawValue) - \(self)"
    }
}
