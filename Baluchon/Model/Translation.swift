//
//  Translation.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 09/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class Translation {
    
    var text: String = ""
    var sourceLanguage: String?
    var targetLanguage: String = ""
    var translatedText: String?
    
    init(text: String = "", targetLanguage: String = "en") {
        self.text = text
        self.targetLanguage = targetLanguage
    }
    
    func getTranslation(completionHandle: @escaping (Bool) -> Void) {
        var translationUrl = URLComponents(string: "https://translation.googleapis.com/language/translate/v2?")
        translationUrl?.queryItems = [URLQueryItem(name: "key", value: ApiKey.googleTranslate), URLQueryItem(name: "q", value: self.text), URLQueryItem(name: "target", value: self.targetLanguage)]
        var request = URLRequest(url: (translationUrl?.url!)!)
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
                    let translateResponse = try? JSONDecoder().decode(TranslationResponse.self, from: data)
                    self.sourceLanguage = translateResponse?.data.translations[0].detectedSourceLanguage
                    self.translatedText = translateResponse?.data.translations[0].translatedText
                    completionHandle(true)
                }
            }
            
        }
        task.resume()
    }
}


// MARK: - TranslationResponse
struct TranslationResponse: Codable {
    let data: DataTranslate
}

// MARK: - DataTranslate
struct DataTranslate: Codable {
    let translations: [Translate]
}

// MARK: - Translation
struct Translate: Codable {
    let translatedText, detectedSourceLanguage: String
}
