//
//  QrDexViewController.swift
//  QRDex
//
//  Created by Wittawas Mukdaprasert on 20/5/2567 BE.
//

import UIKit

class QrDisplayViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var backToMenuBtn: UIButton!
    
    // QR View
    @IBOutlet weak var titleQRView: UIView!
    @IBOutlet weak var bodyQRView: UIView!
    @IBOutlet weak var qrImgView: UIImageView!
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var telLable: UILabel!
    @IBOutlet weak var amountLable: UILabel!
    
    //parameter
    var amount: Double?
    var tel: String?
    
    override func viewDidLoad() {
        backBtn.isHidden = navigationController == nil
        closeBtn.isHidden = navigationController != nil
        backToMenuBtn.isHidden = navigationController == nil
        backToMenuBtn.layer.cornerRadius = 8
        
        titleQRView.layer.cornerRadius = 8
        titleQRView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bodyQRView.layer.cornerRadius = 8
        bodyQRView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        bodyQRView.layer.borderWidth = 1
        bodyQRView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        generateQR()
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backToMenu(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func generateQR() {
        let service = QrGenaraterService()
        var qr: String = ""
        telLable.text = ""
        amountLable.text = ""
        
        if let tel = self.tel, !tel.isEmpty,
           let amount = self.amount, amount > 0 {
            detailStackView.isHidden = false
            telLable.text = "เบอร์โทรศัพท์: \(tel)"
            let format = NumberFormatter()
            format.positiveFormat = "#,###.##"
            let numStr: String = String(format.string(from: NSNumber(value: amount)) ?? "")
            amountLable.text = "จำนวนเงิน: \(numStr) บาท"
            qr = service.getQRSting(tel: tel, amount: amount)
        } else {
            detailStackView.isHidden = true
            qr = service.getQRSting(tel: "858466739")
        }
        qrImgView.image = service.textToImage(text: qr)
        
        
    }
}
