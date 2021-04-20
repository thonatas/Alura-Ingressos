//
//  Localizacao.swift
//  Alura Ingressos
//
//  Created by Thonatas Borges on 03/01/21.
//  Copyright © 2021 Filomeno. All rights reserved.
//

import UIKit

class Localizacao: NSObject {
    
    var logradouro = ""
    var bairro = ""
    var cidade = ""
    var uf = ""
    
    init(_ dicionario: Dictionary<String, String>) {
        logradouro = dicionario["logradouro"] ?? ""
        bairro = dicionario["bairro"] ?? ""
        cidade = dicionario["localidade"] ?? ""
        uf = dicionario["uf"] ?? ""
    }

}
