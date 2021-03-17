//
//  ViewController.swift
//  brownie
//
//  Created by ArjMaster on 10/03/21.
//  Copyright © 2021 ArjMaster. All rights reserved.
//

import UIKit

protocol AdicionarRefeicoesDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    //Mark: - IBOutlet
    @IBOutlet weak var itensTableView: UITableView?
    
    // MARK: - Atributos
    var delegate: AdicionarRefeicoesDelegate?
    var itens: [Item] = []
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var felicidadeTexField: UITextField!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItens))
        navigationItem.rightBarButtonItem = botaoAdicionaItem
        recuperaItens()
    }
    
    func recuperaItens() {
        itens = ItemDao().recupera()
    }
    
    @objc func adicionarItens() {
        let adicionarItensViewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        ItemDao().save(itens)
        if let tableView = itensTableView{
            tableView.reloadData()
        } else{
            Alerta(controller: self).exibe(mensagem: "Não foi possível atualizar a tabela.")
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)

        let linhaDaTabela = indexPath.row
        let item = itens[linhaDaTabela]

        celula.textLabel?.text = item.nome

        return celula
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }

        if celula.accessoryType ==  .none {
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        } else {
            celula.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let position = itensSelecionados.firstIndex(of: item) {
                itensSelecionados.remove(at: position)
            }
        }
    }
    
    //MARK: - Funcs
    func validarFormulario() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return nil
        }

        guard let felicidadeDaRefeicao = felicidadeTexField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
        }

        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        return refeicao
    }
    
    // MARK: - IBActions
    @IBAction func adicionar() {
        if let refeicao = validarFormulario(){
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)
        }else{
            Alerta(controller: self).exibe(mensagem: "Erro nos dados inseridos.")
        }
    }
}

