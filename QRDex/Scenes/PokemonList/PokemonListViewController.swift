//
//  PokemonListViewController.swift
//  QRDex
//
//  Created by Wittawas Mukdaprasert on 20/5/2567 BE.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var list: PokemonListData?
    
    override func viewDidLoad() {
        callAPI()
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func callAPI() {
        APIClient.share.request(url: "https://pokeapi.co/api/v2/pokemon/?limit=20", method: .get) { [weak self] data in
            self?.list = data
            self?.tableView.reloadData()
        } onError: { error in
            print(error)
        }

    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonListItemCell,
              let pokemon = list?.results[indexPath.row] else {
            return UITableViewCell()
        }
        cell.apply(pokemon: pokemon)
        return cell
    }
    
    
}
