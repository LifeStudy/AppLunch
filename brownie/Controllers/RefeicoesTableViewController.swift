//
//  RefeicoesTableViewController.swift
//  brownie
//
//  Created by ArjMaster on 12/03/21.
//  Copyright © 2021 ArjMaster. All rights reserved.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionarRefeicoesDelegate {
    var refeicoes: [Refeicao] = []
    
    override func viewDidLoad() {
        refeicoes = RefeicaoDao().recupera()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
        RefeicaoDao().save(refeicoes)
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else {return}
            let refeicao = refeicoes[indexPath.row]
            
            RemoverRefeicaoViewController(controller: self).exibe(refeicao, handler: { alert in
                self.removeRefeicao(index: indexPath.row)
            })
        }
    }
    
    func removeRefeicao(index: Int){
        refeicoes.remove(at: index)
        RefeicaoDao().save(refeicoes)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            }
        }
    }
}
