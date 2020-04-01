//
//  DeviseFakeResponseData.swift
//  BaluchonTests
//
//  Created by loc_delcros on 26/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class DeviseFakeResponseData {
    // MARK: - Data
    static var deviseCorrectData: Data? {
        let bundle = Bundle(for: DeviseFakeResponseData.self)
        let url = bundle.url(forResource: "Devise", withExtension: "json")// appel json
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let deviseIncorrectData = "erreur".data(using: .utf8)!
    // MARK: - Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.com/")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    // MARK: - Error
    class DeviseError:Error {}
    static let error = DeviseError()
}
