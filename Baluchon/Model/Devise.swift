//
//  Devise.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 04/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

class Devise {
    var name: String
    var rate: Double?
    var euroToDollar: Bool
    
    init(name: String, euroToDollar: Bool) {
        self.name = name
        self.euroToDollar = euroToDollar
    }
    
     func getTaux(completionHandle: @escaping (Bool) -> Void) {
        var deviseUrl = URLComponents(string: "http://data.fixer.io/api/latest?")
        deviseUrl?.queryItems = [URLQueryItem(name: "access_key", value: ApiKey.keyFixer), URLQueryItem(name: "symbols", value: self.name)]
        var request = URLRequest(url: (deviseUrl?.url)!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandle(false)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandle(false)
                    return
                }
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if (json["success"] as? Bool)! {
                            if let rate = json["rates"] as? Dictionary<String, Any> {
                                self.rate = rate[self.name] as? Double
                                completionHandle(true)
                            }
                        }
                        
                        
                    }
                }
                completionHandle(false)
            }
        }
        task.resume()
    }
    
    func convertirDevise(montant: Double,completionHandle: @escaping (Bool,Double?) -> Void) {
        self.getTaux { (success) in
            if success {
                if let rate = self.rate {
                    if self.euroToDollar {
                        completionHandle(success, montant * rate)
                    } else {
                        completionHandle(success, montant / rate)
                    }
                }
            }
            
        }
        completionHandle(false, nil)
        
    }
    
    
    
}


struct Fixer: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: Rates
}

// MARK: - Rates
struct Rates: Codable {
    let usd: Double

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}
