//
//  BarSettingView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import UIKit

class BarSettingsCell:UITableViewCell
{
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var view_tblCell: UIView!
    @IBOutlet weak var view_tblCelTop: NSLayoutConstraint!
    @IBOutlet weak var view_tblCelBottom: NSLayoutConstraint!
    @IBOutlet weak var view_tblCelHeight: NSLayoutConstraint!
}

class BarSettingView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tblSettingList: UITableView!
    @IBOutlet weak var deleteBtn : UIButton!
    
    // MARK: - IB Objects
    var arr_setting = ["General Settings","Privacy Settings","Terms & Conditions","Privacy Policy","Rate us","About Us","Help","Contact us","Logout","Delete Account"]
    
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    var profileModel = [ProfileModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        deleteBtn.layer.cornerRadius = 10
        self.getProfileAPI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getProfileAPI()
    }
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    // MARK: - button for side menu
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
    
    func getProfileAPI(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.getProfileApi(baseUrl: Config().API_URL + "/api/profile-detail", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! ProfileModel
            //            let message = data.message ?? ""
            if data.success ?? false == true {
                self.profileModel.removeAll()
                self.profileModel.append(response as! ProfileModel)
            }
            Loader.stop()
        }
    }
    
    // MARK: - Table view deligates and datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arr_setting.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarSettingsCell
        
        cell.view_tblCell.layer.cornerRadius = 10
        cell.view_tblCell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        cell.lbl_Name.text = arr_setting[indexPath.row]
        
        if indexPath.row >= arr_setting.count - 1 {
            cell.view_tblCell.backgroundColor = #colorLiteral(red: 0.7058823529, green: 0.1921568627, blue: 0.2509803922, alpha: 1)
            cell.lbl_Name.textAlignment = .center
            cell.lbl_Name.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.view_tblCelTop.constant = 10
            cell.view_tblCelHeight.constant = 50
            cell.view_tblCelBottom.constant = 0
        }else{
            cell.view_tblCell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.lbl_Name.textAlignment = .left
            cell.view_tblCelTop.constant = 0
            cell.view_tblCelHeight.constant = 40
            //            cell.view_tblCelBottom.constant = 20
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BarGeneralSettingView") as? BarGeneralSettingView
            vc?.model.append(contentsOf: self.profileModel[0].data?.notificationPreference ?? [])
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BarPrivacySettingView") as? BarPrivacySettingView
            vc?.visibilityValue = self.profileModel[0].data?.visibilityPreference ?? 0
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 2 {
            if let url = URL(string: "https://bar-backapp.com/terms-of-service"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }else if indexPath.row == 3 {
            if let url = URL(string: "https://bar-backapp.com/privacy-policy"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }else if indexPath.row == 4 {
            
            
        }
        else if indexPath.row == 5 {
            if let url = URL(string: "https://bar-backapp.com/#about"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            
        }
        else if indexPath.row == 6 {
            if let url = URL(string: "https://bar-backapp.com/#faq"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        else if indexPath.row == 7 {
            if let url = URL(string: "https://bar-backapp.com/#contact"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }else if indexPath.row == 8 {
            let logoutAlert = UIAlertController(title: "Logout", message: "Are you sure want to logout?", preferredStyle: UIAlertController.Style.alert)
            
            logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.logOutAPi()
            }))
            
            logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(logoutAlert, animated: true, completion: nil)
            
        }else if indexPath.row == 9 {
            let logoutAlert = UIAlertController(title: "Delete Account", message: "Are you sure want to delete account?", preferredStyle: UIAlertController.Style.alert)
            
            logoutAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.deleteAccountApi()
            }))
            
            logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            self.present(logoutAlert, animated: true, completion: nil)
        }
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "DreamsBarVC") as? DreamsBarVC
        //        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    func logOutAPi(){
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.logOutApi(baseUrl: Config().API_URL + "/api/logout", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if ((data?["status"]) != nil) == true {
                Config().AppUserDefaults.removeObject(forKey: "UserId")
                Config().AppUserDefaults.removeObject(forKey: "UserToken")
                Config().AppUserDefaults.removeObject(forKey: "userLogin")
                Config().AppUserDefaults.removeObject(forKey: "userName")
                Config().AppUserDefaults.removeObject(forKey: "userEmail")
                Config().AppUserDefaults.removeObject(forKey: "userPhone")
                Config().AppUserDefaults.removeObject(forKey: "userProfileImage")
                let nav1 = UINavigationController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigate = storyboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
                nav1.viewControllers = [navigate]
                UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
            }else {
                self.view.makeToast(message: message)
            }
        }
    }
    
    func deleteAccountApi(){
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.deleteAccountApi(baseUrl: Config().API_URL + "/api/delete-account", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if ((data?["status"]) != nil) == true {
                Config().AppUserDefaults.removeObject(forKey: "UserId")
                Config().AppUserDefaults.removeObject(forKey: "UserToken")
                Config().AppUserDefaults.removeObject(forKey: "userLogin")
                Config().AppUserDefaults.removeObject(forKey: "userName")
                Config().AppUserDefaults.removeObject(forKey: "userEmail")
                Config().AppUserDefaults.removeObject(forKey: "userPhone")
                let nav1 = UINavigationController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigate = storyboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
                nav1.viewControllers = [navigate]
                UIApplication.shared.currentUIWindow()?.rootViewController = nav1
                UIApplication.shared.currentUIWindow()?.makeKeyAndVisible()
            }else {
                self.view.makeToast(message: message)
            }
            //            self.removeSpinner()
        }
    }
    
}

extension BarSettingView: RightMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
    
    func toggleRightMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RightMenuViewController") as! RightMenuViewController
        vc.delegate = self
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: false)
    }
}
