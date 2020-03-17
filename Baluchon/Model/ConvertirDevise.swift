//
//  ConvertirDevise.swift
//  Baluchon
//
//  Created by DELCROS Jean-baptiste on 04/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import Foundation

class ConvertirDevise {
    var deviseSource: Devise
    var deviseTarget: Devise
    
    init(deviseSource: Devise, deviseTarget: Devise) {
        self.deviseSource = deviseSource
        self.deviseTarget = deviseTarget
    }
    
    func switchDevise() {
        let deviseSourceSave = deviseSource
        self.deviseSource = deviseTarget
        self.deviseTarget = deviseSourceSave
    }
    
    func convertirMontant(montant: Float) {
        let taux = DeviseService.getTaux(deviseSourceCode: self.deviseSource.code, deviseTargetCode: self.deviseTarget.code)
    }
    
}
