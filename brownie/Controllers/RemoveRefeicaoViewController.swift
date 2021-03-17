//
//  RemoveRefeicaoViewController.swift
//  brownie
//
//  Created by ArjMaster on 14/03/21.
//  Copyright © 2021 ArjMaster. All rights reserved.
//

import UIKit

class RemoverRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void){
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let btnCancel = UIAlertAction(title: "cancelar", style: .cancel)
        alerta.addAction(btnCancel)
        let btnRemover = UIAlertAction(title: "remover", style: .destructive, handler: handler)
        alerta.addAction(btnRemover)
        controller.present(alerta, animated: true, completion: nil)
    }
}
