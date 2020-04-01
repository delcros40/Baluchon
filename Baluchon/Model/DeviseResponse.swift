//
//  DeviseResponse.swift
//  Baluchon
//
//  Created by loc_delcros on 30/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

// MARK: - DeviseResponse
struct DeviseResponse: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

