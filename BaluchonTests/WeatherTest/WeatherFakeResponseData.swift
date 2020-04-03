//
//  WeatherFakeResponseData.swift
//  BaluchonTests
//
//  Created by loc_delcros on 26/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class WeatherFakeResponseData {
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: WeatherFakeResponseData.self)
        let url = bundle.url(forResource: "Weather2", withExtension: "json")// appel json
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    // MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    // MARK: - Error
    class WeatherError:Error {}
    static let error = WeatherError()
}
