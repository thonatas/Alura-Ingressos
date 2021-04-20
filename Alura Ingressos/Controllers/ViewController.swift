//
//  ViewController.swift
//  Alura Ingressos
//
//

import UIKit

class ViewController: UIViewController, PickerViewMesSelecionado, PickerViewAnoSelecionado, PickerViewParcelaSelecionada {
    
    // MARK: - Atributos
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    var pickerViewParcela = PickerViewParcelas()
    var valorDoIngresso = 199
    
    // MARK: - Outlets
    @IBOutlet weak var imagemBanner: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollViewPrincipal: UIScrollView!
    @IBOutlet weak var labelValorDasParcelas: UILabel!
    
    // MARK: - Actions UIButton
    @IBAction func buttonComprar(_ sender: UIButton) {
        let textFieldsEstaoPreenchidos = ValidaFormulario().verificaTextFieldsPreenchidos(textFields: textFields)
        let textFieldsEstaoValidos = ValidaFormulario().verificaTextFieldsValidos(listaDeTextFields: textFields)
        
        if textFieldsEstaoPreenchidos && textFieldsEstaoValidos {
            let alerta = ValidaFormulario().exibeAlertaPreenchimentoTextFields(titulo: "Parabéns", mensagem: "Compra realizada com sucesso")
            present(alerta, animated: true, completion: nil)
        } else {
            let alerta = ValidaFormulario().exibeAlertaPreenchimentoTextFields(titulo: "Atenção", mensagem: "Preencha com atenção todos os campos!!")
            present(alerta, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions UITextField
    @IBAction func textFieldCepAlterouValor(_ sender: UITextField) {
        guard let cep = sender.text else { return }

        LocalizacaoConsultaAPI().consultaCepApi(cep: cep, sucesso: { (localizacao) in
            self.buscaTextField(tipoDeTextField: .endereco, completion: { (textFieldEndereco) in
                textFieldEndereco.text = localizacao.logradouro
            })
            
            self.buscaTextField(tipoDeTextField: .bairro, completion: { (textFieldBairro) in
                textFieldBairro.text = localizacao.bairro
            })
            
        }, falha: { (error) in
            print(error)
            
        })
    }
    
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldParcelaEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewParcela
        pickerView.dataSource = pickerViewParcela
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldCodSeguranca(_ sender: UITextField) {
        guard let texto = sender.text else { return }
        
        if texto.count > 3 {
            let codigo = texto.suffix(3)
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca, completion: { (textFieldCodSeguranca) in
                textFieldCodSeguranca.text = String(codigo)
            })
        } else {
            self.buscaTextField(tipoDeTextField: .codigoDeSeguranca, completion: { (textFieldCodSeguranca) in
                textFieldCodSeguranca.text = texto
            })
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagemBanner.layer.cornerRadius = 10
        self.imagemBanner.layer.masksToBounds = true
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
        pickerViewParcela.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(aumentaScrollView(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    // MARK: - Métodos
    
    @objc func aumentaScrollView(notification: Notification) {
        self.scrollViewPrincipal.contentSize = CGSize(width: self.scrollViewPrincipal.frame.width, height: 1250)
    }
    
    func buscaTextField(tipoDeTextField: TipoDeTextFields, completion: (_ textFieldSolicitado: UITextField) -> Void) {
        for textField in textFields {
            if let textFieldAtual = TipoDeTextFields(rawValue: textField.tag) {
                if textFieldAtual == tipoDeTextField {
                    completion(textField)
                }
            }
        }
    }
    
    // MARK: - PickerViewDelegate
    
    func mesSelecionado(mes: String) {
        self.buscaTextField(tipoDeTextField: .mesDeVencimento, completion: { (textFieldMesVencimento) in
            textFieldMesVencimento.text = mes
        })
    }
    
    func anoSelecionado(ano: String) {
        self.buscaTextField(tipoDeTextField: .anoDeVencimento, completion: { (textFieldAnoVencimento) in
            textFieldAnoVencimento.text = ano
        })
    }
    
    func parcelaSelecionada(parcela: String) {
        self.buscaTextField(tipoDeTextField: .quantidadeDeParcelas, completion: { (textFieldQuantidadeParcelas) in
            textFieldQuantidadeParcelas.text = "\(parcela)x"
            let calculoDaParcela = "\(valorDoIngresso/Int(parcela)!)"
            self.labelValorDasParcelas.text = String(format: "%@x %@ (ou R$ 199,00 à vista)", parcela, calculoDaParcela)
            
        })
    }
    
}

