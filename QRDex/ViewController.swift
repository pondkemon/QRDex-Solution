//
//  ViewController.swift
//  QRDex
//
//  Created by Wittawas Mukdaprasert on 8/5/2567 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func routeToMenu() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Menu")
    }
}

