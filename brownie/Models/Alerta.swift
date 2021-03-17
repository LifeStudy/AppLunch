//
//  Alerta.swift
//  brownie
//
//  Created by ArjMaster on 14/03/21.
//  Copyright © 2021 ArjMaster. All rights reserved.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func exibe(titulo: String = "Alerta", mensagem: String){
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alerta.addAction(ok)
        controller.present(alerta, animated: false, completion: nil)
    }
}
