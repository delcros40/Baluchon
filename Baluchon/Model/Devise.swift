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
    var code: String
    var icon: UIImage
    
    init(name: String, code: String, icon: UIImage) {
        self.name = name
        self.code = code
        self.icon = icon
    }
}
