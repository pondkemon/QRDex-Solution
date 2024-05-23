//
//  MenuViewController.swift
//  QRDex
//
//  Created by Wittawas Mukdaprasert on 20/5/2567 BE.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        views.forEach({
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = false
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOffset = CGSize.zero
            $0.layer.shadowOpacity = 0.1
            $0.layer.shadowRadius = 4.0
        })
    }
    
    @IBAction func qrWasPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "QrDisplay", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            return
        }
        present(vc, animated: true)
    }
    
    @IBAction func inputWasPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InputQr", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func restAPIWasPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PokemonList", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
