//
//  ViewController.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 29/02/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class DeviseViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var montantTf: UITextField!
    @IBOutlet weak var imgDeviseSource: UIImageView!
    @IBOutlet weak var lbDeviseSource: UILabel!
    @IBOutlet weak var imgDeviseTarget: UIImageView!
    @IBOutlet weak var lbDeviseTarget: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    
    var devise: Devise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        devise = Devise(name: "USD", euroToDollar: true)
        montantTf.inputAccessoryView = addToolBarInKeyboard(methodeName: "actionDone")
    }
    @objc func actionDone() {
        view.endEditing(true)
        self.devise?.convertirDevise(montant: Double(self.montantTf.text!)! , completionHandle: { (success, result) in
            if success {
                self.lbResult.text = String(format: "%.02f", result!)
            }
            
        })
    }
    
    @IBAction func actionBtnSwitchDevise(_ sender: UIButton) {
        self.devise?.euroToDollar = !self.devise!.euroToDollar
        let textMontant = self.montantTf.text
        let textSourceDevise = lbDeviseSource.text
        let imgSourceDevise = imgDeviseSource.image
        self.imgDeviseSource.image = self.imgDeviseTarget.image
        self.lbDeviseSource.text = self.lbDeviseTarget.text
        self.imgDeviseTarget.image = imgSourceDevise
        self.lbDeviseTarget.text = textSourceDevise
        self.montantTf.text = self.lbResult.text
        self.lbResult.text = textMontant
        
    }
    


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                let dotString = "."

                if let text = textField.text {
                    let isDeleteKey = string.isEmpty

                    if !isDeleteKey {
                        if text.contains(dotString) {
                            if text.components(separatedBy: dotString)[1].count == 2 {

                                        return false

                            }

                        }

                    }
                }
                return true
             }


}

