//
//  ResetPasswordVC.swift
//  BarBack
//
//  Created by Mac on 08/09/22.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    // MARK: - IB Outlets
  @IBOutlet weak var txt_Password: UITextField!
  @IBOutlet weak var txt_repeatPassword: UITextField!
  @IBOutlet weak var btn_submit: UIButton!
  @IBOutlet weak var view_password: UIView!
  @IBOutlet weak var view_repeatPassword: UIView!
    
    var viewModel = ResetPasswordViewModel()

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
    // MARK: - button for show password
    @IBAction func showPasswordBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            txt_Password.isSecureTextEntry = false
        }else{
            txt_Password.isSecureTextEntry = true
        }
    }
    // MARK: - button for show password
    @IBAction func showConfirmPasswordBtnAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            txt_repeatPassword.isSecureTextEntry = false
        }else{
            txt_repeatPassword.isSecureTextEntry = true
        }
    }
    
         // MARK: - button for submit
       @IBAction func btn_submit(_ sender: UIButton){
           if ValidationClass().validateReSetPasswordForm(self){
               self.viewModel.setNewPasswordAPI(password: txt_repeatPassword.text!)
           }
        }
}
