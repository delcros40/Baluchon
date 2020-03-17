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
    
     func getTranslation(completionHandle: @escaping (Bool, Translation) -> Void) {
        let translationPath = "https://translation.googleapis.com/language/translate/v2?key=\(ApiKey.googleTranslate)&q=\(self.text)&target=\(self.targetLanguage)"
        var request = URLRequest(url: URL(string: translationPath)!)
        request.httpMethod = "POST"
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandle(false, self)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandle(false, self)
                    return
                }
                do {
                  let translateResponse = try? JSONDecoder().decode(TranslationResponse.self, from: data)
                    self.sourceLanguage = translateResponse?.data.translations[0].detectedSourceLanguage
                    self.translatedText = translateResponse?.data.translations[0].translatedText
                    completionHandle(true, self)
                }
            }
            
        }
        task.resume()
    }
}


// MARK: - Welcome
struct TranslationResponse: Codable {
    let data: DataTranslate
}

// MARK: - DataClass
struct DataTranslate: Codable {
    let translations: [Translate]
}

// MARK: - Translation
struct Translate: Codable {
    let translatedText, detectedSourceLanguage: String
}
