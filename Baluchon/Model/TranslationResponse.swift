//
//  TranslationResponse.swift
//  Baluchon
//
//  Created by loc_delcros on 26/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

// struct for decode json of the response of api
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
