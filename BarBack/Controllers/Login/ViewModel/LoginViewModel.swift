//
//  LoginViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 15/09/22.
//

import Foundation
import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import AuthenticationServices
import GoogleSignIn

class LoginViewModel {
    
    var Device_id = UIDevice.current.identifierForVendor!.uuidString
    var Device_Token = UserDefaults.standard.string(forKey: "post_token")
    var Device_Type = "ios"
    var User_ID = String()
    var email_register = String()
    var token = String()
    var is_privacy = String()
    var isLogin = "1"
    var controller : LoginVC?
    var model = [LoginModel]()
    var name = ""
    var lastName = ""
    var imgurll = ""
    var facebookId = ""
    var googleId = ""
    var emaill = ""
    var userType = "bartender"
    
    func loginApi(userEmail:String,password:String){
//        self.controller?.showSpinner(onView: (controller?.view)!)
        let paramDict = ["email":userEmail,"password":password] as [String : Any]
        
        APIManager.shared.loginRequestApi(baseUrl: Config().API_URL + "/api/login", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as! LoginModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                self.model.append(response as! LoginModel)
                let login = "Login"
                Config().AppUserDefaults.set(self.model[0].data?.id, forKey: "UserId")
                Config().AppUserDefaults.set(self.model[0].data?.accessToken, forKey: "UserToken")
                Config().AppUserDefaults.set(login, forKey: "userLogin")
                Config().AppUserDefaults.set(self.model[0].data?.username, forKey: "userName")
                Config().AppUserDefaults.set(self.model[0].data?.email, forKey: "userEmail")
                Config().AppUserDefaults.set(self.model[0].data?.mobile, forKey: "userPhone")
                Config().AppUserDefaults.set(self.model[0].data?.profileImage, forKey: "userProfileImage")
                Config().AppUserDefaults.set(self.model[0].data?.userType, forKey: "userType")
                if self.model[0].data?.userType ?? "" == "bartender"{
                    let nav1 = UINavigationController()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigate = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
                    nav1.viewControllers = [navigate]
                    UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                    UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
                }else{
                    let nav1 = UINavigationController()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let navigate = storyboard.instantiateViewController(withIdentifier: "BarSearchView") as! BarSearchView
                    nav1.viewControllers = [navigate]
                    UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                    UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
                }
                
            }else {
                self.controller?.view.makeToast(message: message)
            }
//            self.removeSpinner()
        }
    }
    
    func updateView(){
        
        self.controller?.view_email.layer.cornerRadius = 25
        self.controller?.view_email.layer.masksToBounds = true;
        
        self.controller?.view_email.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.view_email.layer.shadowOpacity = 0.6
        self.controller?.view_email.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.view_email.layer.shadowRadius = 2.0
        self.controller?.view_email.layer.masksToBounds = false
        
        self.controller?.view_password.layer.cornerRadius = 25
        self.controller?.view_password.layer.masksToBounds = true;
        
        self.controller?.view_password.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.view_password.layer.shadowOpacity = 0.6
        self.controller?.view_password.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.view_password.layer.shadowRadius = 2.0
        self.controller?.view_password.layer.masksToBounds = false
        
        self.controller?.btn_signin.layer.cornerRadius = 10
        self.controller?.btn_signin.layer.masksToBounds = true
    }
    //    MARK: - Facebook login
    func faceBookLogin(){
        let login:LoginManager = LoginManager()
        login.logIn(permissions: ["public_profile","email"], from: self.controller) { (result, error) -> Void in
            if(error != nil){
                LoginManager().logOut()
            }else if(result!.isCancelled){
                LoginManager().logOut()
            }else{
                self.fetchUserData()
            }
        }
    }
    
//    MARK: - Facebook login data
    private func fetchUserData() {
        Loader.start()
        let graphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id, email, name, first_name, last_name, picture.type(large)"])
        graphRequest.start { (connection, result, error) in
            if error != nil {
                print("Error",error!.localizedDescription)
            }else{
                print(result!)
                let field = result! as? [String:Any]
                self.name = field!["name"] as? String ?? ""
                print(self.name)
                self.lastName = field!["last_name"] as? String ?? ""
                print(self.lastName)
                if let imageURL = ((field!["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    print(imageURL)

                    self.imgurll = imageURL
                } else {
                    self.imgurll = ""
                }

                if let iddd = field!["id"] as? NSNumber {
                    self.facebookId = iddd.stringValue

                }else{
                    self.facebookId = field!["id"] as! String
                }
                if let email = field!["email"] {
                    self.emaill = email as! String
                }else {
                    self.emaill = ""
                }
                Loader.stop()
                self.facebookLogin(firstname: self.name, username: self.name, facbookID: self.facebookId, email: self.emaill, type: 1)
            }
        }
    }
    //    MARK: - Facebook login API
    func facebookLogin(firstname:String,username:String,facbookID:String,email:String,type:Int){

        Loader.start()
        let paramDict = ["fullname":firstname,"username":username,"email":email,"facebook_id":facbookID,"type":type,"user_type": self.userType] as [String : Any]

        APIManager.shared.socialLoginApi(baseUrl: Config().API_URL + "/api/social-login", parameter: paramDict, token: "") { response in
            print(response)

            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["success"] as? Bool ?? false == true {
                let login = "Login"
                let dict = data?["data"] as? [String:Any] ?? [:]
                let accessToken = dict["access_token"] as? String ?? ""
                Config().AppUserDefaults.set(accessToken, forKey: "UserToken")
                Config().AppUserDefaults.set(login, forKey: "userLogin")
                Config().AppUserDefaults.set(dict["id"] as? String ?? "", forKey: "UserId")
                Config().AppUserDefaults.set(dict["username"] as? String ?? "", forKey: "userName")
                Config().AppUserDefaults.set(dict["email"] as? String ?? "", forKey: "userEmail")
                Config().AppUserDefaults.set(dict["mobile"] as? String ?? "", forKey: "userPhone")
                Config().AppUserDefaults.set(dict["profile_image"] as? String ?? "", forKey: "userProfileImage")
                let nav1 = UINavigationController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigate = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
                navigate.viewModel.authToken = accessToken
                nav1.viewControllers = [navigate]
                UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()

            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }

    }
    //    MARK: - Apple login API
    func appleLoginApi(firstname:String,username:String,facbookID:String,email:String,type:Int){

        Loader.start()
        let paramDict = ["fullname":firstname,"username":username,"email":email,"apple_id":facbookID,"type":type,"user_type": self.userType] as [String : Any]

        APIManager.shared.socialLoginApi(baseUrl: Config().API_URL + "/api/social-login", parameter: paramDict, token: "") { response in
            print(response)

            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["success"] as? Bool ?? false == true {
                let login = "Login"
                let dict = data?["data"] as? [String:Any] ?? [:]
                let accessToken = dict["access_token"] as? String ?? ""
                Config().AppUserDefaults.set(accessToken, forKey: "UserToken")
                Config().AppUserDefaults.set(login, forKey: "userLogin")
                Config().AppUserDefaults.set(dict["id"] as? String ?? "", forKey: "UserId")
                Config().AppUserDefaults.set(dict["username"] as? String ?? "", forKey: "userName")
                Config().AppUserDefaults.set(dict["email"] as? String ?? "", forKey: "userEmail")
                Config().AppUserDefaults.set(dict["mobile"] as? String ?? "", forKey: "userPhone")
                Config().AppUserDefaults.set(dict["profile_image"] as? String ?? "", forKey: "userProfileImage")
                let nav1 = UINavigationController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigate = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
                navigate.viewModel.authToken = accessToken
                nav1.viewControllers = [navigate]
                UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()

            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }

    }
    //    MARK: - Google login API
    func googleLogin(firstname:String,username:String,facbookID:String,email:String,type:Int){

        Loader.start()
        let paramDict = ["fullname":firstname,"username":username,"email":email,"google_id":facbookID,"type":type,"user_type": self.userType] as [String : Any]

        APIManager.shared.socialLoginApi(baseUrl: Config().API_URL + "/api/social-login", parameter: paramDict, token: "") { response in
            print(response)

            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["success"] as? Bool ?? false == true {
                let login = "Login"
                let dict = data?["data"] as? [String:Any] ?? [:]
                let accessToken = dict["access_token"] as? String ?? ""
                Config().AppUserDefaults.set(accessToken, forKey: "UserToken")
                Config().AppUserDefaults.set(login, forKey: "userLogin")
                Config().AppUserDefaults.set(dict["id"] as? String ?? "", forKey: "UserId")
                Config().AppUserDefaults.set(dict["username"] as? String ?? "", forKey: "userName")
                Config().AppUserDefaults.set(dict["email"] as? String ?? "", forKey: "userEmail")
                Config().AppUserDefaults.set(dict["mobile"] as? String ?? "", forKey: "userPhone")
                Config().AppUserDefaults.set(dict["profile_image"] as? String ?? "", forKey: "userProfileImage")
                let nav1 = UINavigationController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigate = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
                navigate.viewModel.authToken = accessToken
                nav1.viewControllers = [navigate]
                UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()

            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }

    }
    
}
