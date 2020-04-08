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
        self.tVSaisieText.delegate = self
        self.lbSourceLanguage.text = ""
        tVSaisieText.inputAccessoryView = addToolBarInKeyboard(methodeName: "actionDone")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text != nil {
            self.translation.text = textView.text!
        }
    }
    
    @objc func actionDone() {
        view.endEditing(true)
        if !tVSaisieText.text.isEmpty {
            translation.text = tVSaisieText.text
            self.presentAlertWait()
            translation.getTranslation { [weak self] (success, translationResponse) in
                DispatchQueue.main.async {
                    self?.dismiss(animated: true, completion: nil)
                    if success {
                        self?.lbSourceLanguage.text = translationResponse?.data.translations[0].detectedSourceLanguage.uppercased()
                        self?.tVTranslation.text = translationResponse?.data.translations[0].translatedText
                    }
                }
            }
        } else {
            presentAlertError(message: "Saisissez un texte a traduire")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
