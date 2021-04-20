//
//  ValidaFormulario.swift
//  Alura Ingressos
//
//  Created by Thonatas Borges on 02/01/21.
//  Copyright © 2021 Filomeno. All rights reserved.
//

import UIKit

class ValidaFormulario: NSObject {

    func verificaTextFieldsPreenchidos(textFields: [UITextField]) -> Bool {
        
        for textField in textFields {
            if textField.text == "" {
                return false
            }
        }
        return true
    }
    
    func exibeAlertaPreenchimentoTextFields(titulo: String, mensagem: String) -> UIAlertController {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        return alerta
    }
}
