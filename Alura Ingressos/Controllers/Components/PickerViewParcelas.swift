//
//  PickerViewParcelas.swift
//  Alura Ingressos
//
//  Created by Thonatas Borges on 03/01/21.
//  Copyright © 2021 Filomeno. All rights reserved.
//

import UIKit

protocol PickerViewParcelaSelecionada {
    func parcelaSelecionada(parcela: String)
}

class PickerViewParcelas: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: PickerViewParcelaSelecionada?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)x "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.parcelaSelecionada(parcela: "\(row + 1)")
        }
    }

}

