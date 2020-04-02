import Foundation
import UIKit

class DeviseViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var myview: UIView!
    @IBOutlet weak var montantTf: UITextField!
    @IBOutlet weak var lbDeviseSource: UILabel!
    @IBOutlet weak var imgDeviseSource: UIImageView!
    @IBOutlet weak var imgDeviseTarget: UIImageView!
    @IBOutlet weak var lbDeviseTarget: UILabel!
    @IBOutlet weak var lbResult: UILabel!
    
    var convertirDevise = ConvertionDevise(deviseBase: .euro)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        montantTf.inputAccessoryView = addToolBarInKeyboard(methodeName: "actionDone")
        self.montantTf.delegate = self
        self.initialisationDeviseBase(deviseBase: convertirDevise.deviseBase)
        self.initialisationDeviseTarget(deviseTarget: convertirDevise.deviseTarget)
    }

    
    @objc func actionDone() {
        if let montant = Double(self.montantTf.text!) {
            self.convertirDevise.montant = montant
            self.convertirDevise.convertirDevise()
            self.lbResult.text = String(format: "%.02f", self.convertirDevise.resultat!)
        } else {
            self.presentAlertError(message: "Entrez un montant")
        }
        view.endEditing(true)
        
    }
    
    @IBAction func actionBtnSwitchDevise(_ sender: UIButton) {
        self.presentAlertWait()
        self.convertirDevise.switchDevise()
        self.initialisationDeviseBase(deviseBase: convertirDevise.deviseBase)
        self.initialisationDeviseTarget(deviseTarget: convertirDevise.deviseTarget)
        if let resultat = self.convertirDevise.resultat {
            self.convertirDevise.montant = resultat
            self.montantTf.text = String(format: "%.02f", resultat)
            self.convertirDevise.convertirDevise()
            self.lbResult.text = String(format: "%.02f", self.convertirDevise.resultat!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    private func initialisationDeviseBase(deviseBase: Devise) {
        self.lbDeviseSource.text = deviseBase.description
        self.imgDeviseSource.image = UIImage(named: deviseBase.rawValue)
    }

    private func initialisationDeviseTarget(deviseTarget: Devise) {
        self.lbDeviseTarget.text = deviseTarget.description
        self.imgDeviseTarget.image = UIImage(named: deviseTarget.rawValue)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}

