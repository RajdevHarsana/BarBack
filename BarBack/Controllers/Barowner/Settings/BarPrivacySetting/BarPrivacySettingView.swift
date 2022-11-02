//
//  BarPrivacySettingView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 14/10/22.
//

import UIKit

class BarPrivacySettingView: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var publicBtn: UIButton!
    @IBOutlet weak var onlyMeBtn: UIButton!
    
    var visibilityValue = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.roundCorners([.topLeft,.topRight], radius: 16)
        
        if visibilityValue == 1 {
            self.publicBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.onlyMeBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
        }else if visibilityValue == 2 {
            self.publicBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.onlyMeBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
        }else{
            self.publicBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.onlyMeBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            visibilityValue = 1
        }
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
    // MARK: - button for perefernce
    @IBAction func btnPublic(_ sender: UIButton){
        if self.publicBtn.currentImage != UIImage(named: "checkFilled") {
            self.publicBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.onlyMeBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.profileVisibilityApi(preference: 1)
        }else{
            
        }
    }
    // MARK: - button for perefernce
    @IBAction func btnOnlyMe(_ sender: UIButton){
        if self.onlyMeBtn.currentImage != UIImage(named: "checkFilled"){
            self.publicBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.onlyMeBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.profileVisibilityApi(preference: 2)
        }else{
            
        }
    }
    
    func profileVisibilityApi(preference:Int){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["visibility_preference":preference] as [String : Any]
        
        APIManager.shared.profileVisibilityApi(baseUrl: Config().API_URL + "/api/profile-visibility-preference", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if ((data?["success"]) != nil) == true {
                self.view.makeToast(message: "Saved Successfully")
            }else {
                self.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
}

extension BarPrivacySettingView: RightMenuDelegates {
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
