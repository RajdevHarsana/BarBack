//
//  VerificationVC.swift
//  BarBack
//
//  Created by Mac on 08/09/22.
//

import UIKit

class VerificationVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var txt_otp1: UITextField!
    @IBOutlet weak var txt_otp2: UITextField!
    @IBOutlet weak var txt_otp3: UITextField!
    @IBOutlet weak var txt_otp4: UITextField!
    @IBOutlet weak var lbl_resend: UILabel!
    @IBOutlet weak var btn_verify: UIButton!
    @IBOutlet weak var lbl_email: UILabel!
    
    // MARK: - IB Objects
    var viewModel = VerificationViewModel()
    
    // MARK: - view did load method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
    }
    
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - button for forgot password
    @IBAction func btn_Verify(_ sender: UIButton){
        if txt_otp1.text?.isEmpty == true{
            self.showMessageToUser(title: "Alert!", msg: "Please enter OTP")
        }
        else if txt_otp2.text?.isEmpty == true{
            self.showMessageToUser(title: "Alert!", msg: "Please enter OTP")
        }
        else if txt_otp3.text?.isEmpty == true{
            self.showMessageToUser(title: "Alert!", msg: "Please enter OTP")
        }
        else if txt_otp4.text?.isEmpty == true{
            self.showMessageToUser(title: "Alert!", msg: "Please enter OTP")
        }
        else{
            self.viewModel.verifyOTPApiRequest()
        }
    }
    
    // MARK: - button for Resend OTP
    @IBAction func btn_ResendOTP(_ sender: UIButton){
        txt_otp1.text = ""
        txt_otp2.text = ""
        txt_otp3.text = ""
        txt_otp4.text = ""
        self.viewModel.resendOTPApiRequest()
    }
        
}

extension VerificationVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 1
    }
}


class TextField: UITextField {
    func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return false
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}


class TextFeild: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // write code here what ever you want to change property for textfeild.
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        // Default
        return super.canPerformAction(action, withSender: sender)
        
    }
}
