//
//  InputQrViewController.swift
//  QRDex
//
//  Created by Wittawas Mukdaprasert on 20/5/2567 BE.
//

import UIKit

class InputQrViewController: UIViewController {
    
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var amtTextField: UITextField!
    @IBOutlet weak var genQRBtn: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        genQRBtn.layer.cornerRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerNotificationsKeyboard()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeNotificationsKeyboard()
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func genQR(_ sender: UIButton) {
        guard let tel = telTextField.text, !tel.isEmpty,
              let amt = amtTextField.text, !amt.isEmpty else {
            return
        }
        let storyboard = UIStoryboard(name: "QrDisplay", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? QrDisplayViewController else {
            return
        }
        vc.tel = tel
        vc.amount = Double(amt)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func registerNotificationsKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeNotificationsKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotification(_ notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let bottomSafeArea = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
            let h = keyboardFrame.height - bottomSafeArea + 8
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? h : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
