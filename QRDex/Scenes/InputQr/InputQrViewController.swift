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
    @IBOutlet weak var telErrorLabel: UILabel!
    @IBOutlet weak var amtErrorLabel: UILabel!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    private let mobilePhoneFormat: String = "###-###-####"
    private let replaceMobilePhoneFormat: Character = "#"
    
    override func viewDidLoad() {
        genQRBtn.layer.cornerRadius = 8
        telTextField.addTarget(self, action: #selector(self.mobileTextFieldDidChange(_:)), for: .editingChanged)
        amtTextField.addTarget(self, action: #selector(self.amtTextFieldDidChange(_:)), for: .editingChanged)
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
        
        let telError = validTelFormat(tel: tel)
        let amtError = validAmount(amt: amt)
        
        if telError != nil || amtError != nil {
            self.telErrorLabel.text = telError?.title
            self.telErrorLabel.isHidden = telError == nil
            
            self.amtErrorLabel.text = amtError?.title
            self.amtErrorLabel.isHidden = amtError == nil
            return
        }
        
        let amtDouble: Double = Double(amt) ?? 0
        routeToQRDisplayVC(tel: tel, amt: amtDouble)
    }
    
    func routeToQRDisplayVC(tel: String, amt: Double) {
        let storyboard = UIStoryboard(name: "QrDisplay", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? QrDisplayViewController else {
            return
        }
        vc.tel = tel
        vc.amount = amt
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
    
    func validAmount(amt amountString: String) -> InputAmtQrError? {
        let countOfDecimal = amountString.filter { $0 == "." }.count
        guard countOfDecimal <= 1 else {
            return .IncorrectFormat
        }
        
        guard let decimalNumber = Decimal(string: amountString) else {
            return .IncorrectFormat
        }
        
        guard decimalNumber.significantFractionalDecimalDigits <= 2 else {
            return .FloatMore2Digit
        }
        
        return nil
    }
    
    func validTelFormat(tel telString: String) -> InputTelQrError? {
        let clearTelText = telString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        guard clearTelText.first == "0" else {
            return .FirstCharactorIsNotZero
        }
        
        guard clearTelText.count == 10 else {
            return .Not10Digit
        }
        
        guard !isOrderingNumber(telString: clearTelText) else {
            return .OrderingNumber
        }
        
        guard !isAllSingleNumber(telString: clearTelText) else {
            return .AllSingleNumber
        }
        
        return nil
    }
    
    private func isOrderingNumber(telString: String) -> Bool {
        var orderingNumber: Int = 0
        let numbers = telString.map { String($0) }
        for number in numbers {
            if let number = Int(number), orderingNumber != number {
                return false
            } else {
                orderingNumber += 1
            }
        }
        return true
    }
    
    private func isAllSingleNumber(telString: String) -> Bool {
        let numbers = telString.map { Int(String($0)) ?? 0 }
        var numberSecondIndex: Int = 0
        for (index, number) in numbers.enumerated() {
            if index == 1 {
                numberSecondIndex = number
            } else if index != 0 {
                if numberSecondIndex != number {
                    return false
                }
            }
        }
        return true
    }
}

extension InputQrViewController {
    @objc func mobileTextFieldDidChange(_ textField: UITextField) {
        let newText = textField.text?.applyPatternOnNumbers(pattern: mobilePhoneFormat, replacmentCharacter: replaceMobilePhoneFormat) ?? ""
        telTextField.text = newText
    }
    
    @objc func amtTextFieldDidChange(_ textField: UITextField) {
        let newAmount = textField.text?.applyAmountFormat()
        amtTextField.text = newAmount
    }
}


extension String {
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    func applyAmountFormat() -> String {
        let amountText: String = self
        
        // "." more than 1 charactor
        let countOfDot = amountText.filter { $0 == "." }.count
        if amountText.last == "." && countOfDot > 1 {
            return String(amountText.dropLast())
        }
        
        return amountText
    }
}

extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
