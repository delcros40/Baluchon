//
//  UIView+addToolBarInKeyboard.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 15/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

/// extension of the UIViewController  class allowing to add a view above the keybord
extension UIViewController {
    func addToolBarInKeyboard(methodeName: String) -> UIToolbar {
        let toolBar = UIToolbar(frame:CGRect(x:0, y:0, width:100, height:100))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selector(("\(methodeName)")))
        toolBar.items = [flexibleSpace,doneButton]
        toolBar.sizeToFit()
        return toolBar
    }
}
