//
//  ResetPasswordViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 15/09/22.
//

import Foundation
import UIKit

class ResetPasswordViewModel {
    
    var otp = String()
    var email = String()
    var controller : ResetPasswordVC?
    var model = [ResetPasswordtModel]()
    
    func setNewPasswordAPI(password:String){
        Loader.start()
        let paramDict = ["email":email,"password":password,"otp":otp] as [String : Any]
        
        APIManager.shared.resetPasswordApi(baseUrl: Config().API_URL + "/api/reset-password", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as! ResetPasswordtModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                let vc = self.controller?.storyboard?.instantiateViewController(withIdentifier: "PasswordChangeSucessfullyVC") as? PasswordChangeSucessfullyVC
                self.controller?.navigationController?.pushViewController(vc!, animated: true)
            }else{
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        self.controller?.view_repeatPassword.layer.cornerRadius = 25
        self.controller?.view_repeatPassword.layer.masksToBounds = true;
        
        self.controller?.view_repeatPassword.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.view_repeatPassword.layer.shadowOpacity = 0.6
        self.controller?.view_repeatPassword.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.view_repeatPassword.layer.shadowRadius = 2.0
        self.controller?.view_repeatPassword.layer.masksToBounds = false
        
        self.controller?.view_password.layer.cornerRadius = 25
        self.controller?.view_password.layer.masksToBounds = true;
        
        self.controller?.view_password.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.view_password.layer.shadowOpacity = 0.6
        self.controller?.view_password.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.view_password.layer.shadowRadius = 2.0
        self.controller?.view_password.layer.masksToBounds = false
        
        self.controller?.btn_submit.layer.cornerRadius = 10
        self.controller?.btn_submit.layer.masksToBounds = true
    }
}
