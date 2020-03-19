//
//  UIView+addToolBarInKeyboard.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 15/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func addToolBarInKeyboard(methodeName: String) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: Selector(("\(methodeName)")))
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolBar
    }
}
