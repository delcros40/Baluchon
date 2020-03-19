//
//  UIViewController+Alert.swift
//  Baluchon
//
//  Created by loc_delcros on 17/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlertError(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
