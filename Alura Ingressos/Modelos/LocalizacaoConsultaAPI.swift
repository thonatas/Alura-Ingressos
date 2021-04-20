//
//  LocalizacaoConsultaAPI.swift
//  Alura Ingressos
//
//  Created by Thonatas Borges on 03/01/21.
//  Copyright © 2021 Filomeno. All rights reserved.
//

import UIKit
import Alamofire

class LocalizacaoConsultaAPI: NSObject {

    func consultaCepApi(cep: String, sucesso: @escaping(_ localizacao: Localizacao) -> Void, falha: @escaping(_ error: Error) -> Void) {
        Alamofire.request("https://viacep.com.br/ws/\(cep)/json/", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let resultado = response.result.value as? Dictionary<String, String> {
                    let localizacao = Localizacao(resultado)
                    sucesso(localizacao)
                }
                break
            case .failure:
                falha(response.result.error!)
                break
            }
        }
    }
}
