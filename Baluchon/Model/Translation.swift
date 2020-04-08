//
//  Translation.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 09/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class Translation {
    /// Entities
    var text: String
    var targetLanguage: String = ""
    var translationSession: URLSession
    
    /// Initializer
    init(text: String = "", targetLanguage: String = "en", translationSession:URLSession = URLSession(configuration: .default)) {
        self.text = text
        self.targetLanguage = targetLanguage
        self.translationSession = translationSession
    }
     /// request to API google translate for get a translation of a text
    func getTranslation(completionHandle: @escaping (Bool, TranslationResponse?) -> Void) {
        var translationUrl = URLComponents(string: "https://translation.googleapis.com/language/translate/v2?")
        translationUrl?.queryItems = [URLQueryItem(name: "key", value: ApiKey.googleTranslate), URLQueryItem(name: "q", value: self.text), URLQueryItem(name: "target", value: self.targetLanguage)]
        var request = URLRequest(url: (translationUrl?.url!)!)
        request.httpMethod = "GET"
        let task = translationSession.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    completionHandle(false,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandle(false,nil)
                    return
                }
                guard let translationResponse = try? JSONDecoder().decode(TranslationResponse.self, from: data) else {
                    completionHandle(false,nil)
                    return
                }
                completionHandle(true, translationResponse)
        }
        task.resume()
    }
}
