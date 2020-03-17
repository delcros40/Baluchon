//
//  DeviseService.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 29/02/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation


class DeviseService {
    private static var devisePath = "http://data.fixer.io/api/latest"
    
    static func getTaux(deviseSourceCode: String, deviseTargetCode: String) {
        devisePath += "?access_key=\(ApiKey.keyFixer)&base=\(deviseSourceCode)&symbols=\(deviseTargetCode)"
        var request = URLRequest(url: URL(string: devisePath)!)
        request.httpMethod = "POST"
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return
                }
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        print(json["success"])
                        if let rate = json["rates"] as? Dictionary<String, Any> {
                            print(rate)
                            print(rate[deviseTargetCode])
                        }
                        
                    }
                }
                
                
    
            
            }
        }
        task.resume()
    }
}
