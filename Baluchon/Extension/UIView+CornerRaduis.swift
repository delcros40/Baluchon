//
//  UIView+CornerRaduis.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 03/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

@IBInspectable
var cornerRadius: CGFloat {
  get {
    return layer.cornerRadius
  }
  set {
    layer.cornerRadius = newValue
  }
}
}
