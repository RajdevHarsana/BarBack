//
//  ForgotPsaawordVC.swift
//  BarBack
//
//  Created by Mac on 08/09/22.
//

import UIKit

class ForgotPsaawordVC: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var btn_submit: UIButton!
    @IBOutlet weak var view_email: UIView!
    
    // MARK: - IB Objects
    var Device_id = UIDevice.current.identifierForVendor!.uuidString
    var Device_Token = UserDefaults.standard.string(forKey: "post_token")
    var Device_Type = "ios"
    var User_ID = String()
    var email_register = String()
    var token = String()
    var is_privacy = String()
    var isLogin = "1"
    var viewModel = ForgotPasswordViewModel()
    
    
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
    
    // MARK: - button for send otp request
    @IBAction func btn_Submit(_ sender: UIButton){
        if ValidationClass().ValidateForgotPasswordForm(self){
            self.viewModel.sendOTPApiRequest(email: txt_email.text!)
        }
    }
}
