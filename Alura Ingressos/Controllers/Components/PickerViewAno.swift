//
//  PickerViewAno.swift
//  Alura Ingressos
//
//  Created by Thonatas Borges on 03/01/21.
//  Copyright © 2021 Filomeno. All rights reserved.
//

import UIKit

protocol PickerViewAnoSelecionado {
    func anoSelecionado(ano: String)
}

class PickerViewAno: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let listaDeAnos = ["2021", "2022", "2023", "2024", "2025"]

    var delegate: PickerViewAnoSelecionado?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaDeAnos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let anoListado = listaDeAnos[row]
        return anoListado
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if delegate != nil {
            delegate?.anoSelecionado(ano: "\(listaDeAnos[row])")
        }
    }
    
}
