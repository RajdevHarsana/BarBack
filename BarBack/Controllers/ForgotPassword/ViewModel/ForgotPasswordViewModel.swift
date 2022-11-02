//
//  ForgotPasswordViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 15/09/22.
//

import Foundation
import UIKit

class ForgotPasswordViewModel {
    
    var controller : ForgotPsaawordVC?
    var model = [ForgotPasswordModel]()
    
    func sendOTPApiRequest(email:String){
        Loader.start()
        let paramDict = ["email":email] as [String : Any]
        
        APIManager.shared.sendOTPApi(baseUrl: Config().API_URL + "/api/send-otp", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as! ForgotPasswordModel
            let message = data.message
            if data.status == 200 {
                self.model.append(response as! ForgotPasswordModel)
                let navigate = self.controller?.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                navigate.viewModel.otp = String(self.model[0].otp)
                navigate.viewModel.email = (self.controller?.txt_email.text!)!
                self.controller?.navigationController?.pushViewController(navigate, animated: true)
                
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        
        self.controller?.view_email.layer.cornerRadius = 25
        self.controller?.view_email.layer.masksToBounds = true;
                
        self.controller?.view_email.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.controller?.view_email.layer.shadowOpacity = 0.8
        self.controller?.view_email.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.controller?.view_email.layer.shadowRadius = 2.0
        self.controller?.view_email.layer.masksToBounds = false
        
        self.controller?.btn_submit.layer.cornerRadius = 10
        self.controller?.btn_submit.layer.masksToBounds = true
        
    }
    
    
}
