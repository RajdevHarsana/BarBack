//
//  LoginVC.swift
//  BarBack
//
//  Created by Mac on 08/09/22.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    
    // MARK: - IB Outlets
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_Password: UITextField!
    @IBOutlet weak var btn_signin: UIButton!
    @IBOutlet weak var view_email: UIView!
    @IBOutlet weak var view_password: UIView!
    @IBOutlet weak var btn_forgotPassword: UIButton!
    
    // MARK: - IB Objects
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
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
    
    // MARK: - button for user login
    @IBAction func btn_SignIn(_ sender: UIButton){
        if txt_email.text?.isEmpty == true{
            self.showMessageToUser(title: "Alert!", msg: "The email field is required.")
        }else if txt_email.text?.isValidateEmail() == false{
            self.showMessageToUser(title: "Alert!", msg: "The email must be a valid email address")
        }else if txt_Password.text?.isEmpty == true{
            self.showMessageToUser(title: "Alert!", msg: "The password field is required")
        }else{
            self.viewModel.loginApi(userEmail: txt_email.text!, password: txt_Password.text!)
        }
    }
    
    
    // MARK: - button for forgot password
    @IBAction func btn_forgotPassword(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPsaawordVC") as? ForgotPsaawordVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    // MARK: - button for Signup
    @IBAction func btn_signup(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: - button for facebbok login
    
    @IBAction func btnFacebookLogin(_ sender: UIButton){
        self.viewModel.faceBookLogin()
    }
    
    // MARK: - button for google login
    
    @IBAction func btnGoogleLogin(_ sender: UIButton){
        self.fetchGoogleData()
    }
    
    //MARK: - Apple Button Action
    @IBAction func loginWithAppleBtnAction(_ sender: UIButton) {
        _ = ASAuthorizationAppleIDButton()
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    //    MARK: - Google login data
    func fetchGoogleData(){
        
        GIDSignIn.sharedInstance.signIn(with: appDelegate!.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            
            let fullName = user?.profile?.name
            print(fullName ?? "")
            self.viewModel.name = user?.profile?.givenName ?? ""
            self.viewModel.lastName = user?.profile?.familyName ?? ""
            self.viewModel.emaill = user?.profile?.email ?? ""
            
            self.viewModel.googleId = user?.userID ?? ""
            let email_id = user?.profile?.email ?? ""
            let first_name = user?.profile?.givenName ?? ""
            let last_name = user?.profile?.familyName ?? ""
            
            guard let emailv = user?.profile?.email else { return }
            guard let imageUrl = user?.profile?.imageURL(withDimension: 400) else { return }
            print(imageUrl)
            //emailIdTxtFld.text = emailv
            
            var socialInfo : [String:String] = [:]
            socialInfo["email"] = emailv
            socialInfo["social_id"] = user?.userID
            socialInfo["social_type"] = "google"
            socialInfo["first_name"] = user?.profile?.givenName
            socialInfo["last_name"] = user?.profile?.familyName
            socialInfo["mobile_number"] = ""
            socialInfo["image"] = imageUrl.path
            print(imageUrl.path)
            
            Config().AppUserDefaults.set(imageUrl, forKey: "social_profile_image")
            Config().AppUserDefaults.set(self.viewModel.googleId, forKey: "social_id")
            Config().AppUserDefaults.set(email_id, forKey: "social_email_id")
            Config().AppUserDefaults.set(first_name, forKey: "social_first_name")
            Config().AppUserDefaults.set(last_name, forKey: "social_last_name")
            
            
            Config().AppUserDefaults.set(email_id, forKey: "emailId")
            Config().AppUserDefaults.set(first_name, forKey: "first")
            Config().AppUserDefaults.set(last_name, forKey: "last")
            Config().AppUserDefaults.set(self.viewModel.googleId, forKey: "googleid")
            
            self.viewModel.googleLogin(firstname: user?.profile?.givenName ?? "", username: user?.profile?.givenName ?? "", facbookID: user?.userID ?? "", email: emailv, type: 2)
        }
    }
}

extension LoginVC : ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    //MARK: - Apple Login Authorization Delegate
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
        
    }
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let appleId = appleIDCredential.user
            print(appleId)
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            print(appleUserFirstName ?? "")
            let appleUsernme = appleIDCredential.fullName?.familyName
            print(appleUsernme ?? "")
            let appleUserEmail = appleIDCredential.email
            print(appleUserEmail ?? "")
            
            if appleUserEmail == nil {
                Config().AppUserDefaults.setValue(appleUserEmail, forKey: "AppleUserEmail")
                print(appleUserEmail as Any)
            }else{
                Config().AppUserDefaults.setValue(appleUserEmail, forKey: "AppleUserEmail")
            }
            if  appleUserFirstName == nil  {
                Config().AppUserDefaults.setValue(appleUserFirstName, forKey: "AppleUserFirstName")
                print(appleUserFirstName as Any)
            }else{
                Config().AppUserDefaults.setValue(appleUserFirstName, forKey: "AppleUserFirstName")
            }
            if appleUsernme == nil  {
                Config().AppUserDefaults.setValue(appleUsernme, forKey: "AppleUserLastName")
                print(appleUsernme as Any)
            }else{
                Config().AppUserDefaults.setValue(appleUsernme, forKey: "AppleUserLastName")
            }
            //api calling
            self.viewModel.appleLoginApi(firstname: appleUserFirstName!, username: appleUsernme!, facbookID: appleId, email: appleUserEmail!, type: 3)
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            
            let appleUsername = passwordCredential.user
            print(appleUsername as Any)
            let applePassword = passwordCredential.password
            print(applePassword as Any)
            //Write your code
        }
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }    
}
