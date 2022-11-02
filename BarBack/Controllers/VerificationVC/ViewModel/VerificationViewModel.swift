//
//  VerificationViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 17/09/22.
//

import Foundation
import UIKit

class VerificationViewModel {
    
    // MARK: - IB Objects
    // var UserId = UserDefaults.standard.string(forKey: "UserId")
    var language = UserDefaults.standard.string(forKey: "language")
    var Device_id = UIDevice.current.identifierForVendor!.uuidString
    var Device_Token = UserDefaults.standard.string(forKey: "post_token")
    var Otp_Condition = String()
    var UserId = String()
    var Email = String()
    var Check_Type = String()
    var controller: VerificationVC?
    var otp = String()
    var email = String()
    var model = [VerificationModel]()
    
    func verifyOTPApiRequest(){
        Loader.start()
        let paramDict = ["email":email,"otp":otp] as [String : Any]
        
        APIManager.shared.verifyOTPApi(baseUrl: Config().API_URL + "/api/verify-otp", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as! VerificationModel
            let message = data.message
            if data.status == 200 {
                self.model.append(response as! VerificationModel)
                let navigate = self.controller?.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                navigate.viewModel.otp = self.otp
                navigate.viewModel.email = self.email
                self.controller?.navigationController?.pushViewController(navigate, animated: true)
                
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func resendOTPApiRequest(){
        Loader.start()
        let paramDict = ["email":email] as [String : Any]
        
        APIManager.shared.resendOtpApi(baseUrl: Config().API_URL + "/api/send-otp", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if ((data?["status"]) != nil) == true {
                self.controller?.view.makeToast(message: message)
//                let otpCode = data?["otp"] as? Int ?? 0
//                self.otp = String(otpCode)
//                let digits = self.otp.compactMap{ $0.wholeNumberValue }
//                self.controller?.txt_otp1.text = String(digits[0])
//                self.controller?.txt_otp2.text = String(digits[1])
//                self.controller?.txt_otp3.text = String(digits[2])
//                self.controller?.txt_otp4.text = String(digits[3])
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        controller?.txt_otp1.delegate = self.controller
        controller?.txt_otp2.delegate = self.controller
        controller?.txt_otp3.delegate = self.controller
        controller?.txt_otp4.delegate = self.controller
        
        controller?.txt_otp1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        controller?.txt_otp2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        controller?.txt_otp3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        controller?.txt_otp4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
        controller?.btn_verify.layer.cornerRadius = 10
        controller?.btn_verify.layer.masksToBounds = true
        
        controller?.txt_otp1.addShadowToTextField(cornerRadius: 8)
        controller?.txt_otp2.addShadowToTextField(cornerRadius: 8)
        controller?.txt_otp3.addShadowToTextField(cornerRadius: 8)
        controller?.txt_otp4.addShadowToTextField(cornerRadius: 8)
        
        controller?.lbl_email.text =  "We’ve sent you a code to " + "\(email)"
        
//        let digits = otp.compactMap{ $0.wholeNumberValue }
//
//        controller?.txt_otp1.text = String(digits[0])
//        controller?.txt_otp2.text = String(digits[1])
//        controller?.txt_otp3.text = String(digits[2])
//        controller?.txt_otp4.text = String(digits[3])
        
    }
    
    // MARK: - text field did change deligates
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case controller?.txt_otp1:
                controller?.txt_otp2.becomeFirstResponder()
            case controller?.txt_otp2:
                controller?.txt_otp3.becomeFirstResponder()
            case controller?.txt_otp3:
                controller?.txt_otp4.becomeFirstResponder()
            case controller?.txt_otp4:
                controller?.txt_otp4.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case controller?.txt_otp1:
                controller?.txt_otp1.becomeFirstResponder()
            case controller?.txt_otp2:
                controller?.txt_otp1.becomeFirstResponder()
            case controller?.txt_otp3:
                controller?.txt_otp2.becomeFirstResponder()
            case controller?.txt_otp4:
                controller?.txt_otp3.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    
}

extension UITextField {
    
    func addShadowToTextField(cornerRadius: CGFloat) {
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true;
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
    }
}
