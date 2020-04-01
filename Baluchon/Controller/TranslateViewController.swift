//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 03/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var tVSaisieText: UITextView!
    @IBOutlet weak var tVTranslation: UITextView!
    @IBOutlet weak var lbSourceLanguage: UILabel!
    var translation = Translation()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbSourceLanguage.text = ""
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        tVSaisieText.inputAccessoryView = addToolBarInKeyboard(methodeName: "actionDone")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != nil {
            self.translation.text = textView.text!
        }
    }

    @objc func actionDone() {
        view.endEditing(true)
        if tVSaisieText.text.count > 0 {
            translation.text = tVSaisieText.text
            self.presentAlertWait()
            translation.getTranslation { (success, translationResponse) in
                self.dismiss(animated: true, completion: nil)
                if success {
                    self.lbSourceLanguage.text = translationResponse?.data.translations[0].detectedSourceLanguage.uppercased()
                    self.tVTranslation.text = translationResponse?.data.translations[0].translatedText
                }
            }
        } else {
            presentAlertError(message: "Saisissez un texte a traduire")
        }
        
        
    }

}
