//
//  GeneralSettingsView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 21/09/22.
//

import UIKit

class GeneralSettingsView: UIViewController {
    
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var newJobbtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var jobProposalBtn: UIButton!
    @IBOutlet weak var noneBtn: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var saveBtn: UIButton!
    
    var notiPreferenceArray = [String]()
    var notiPreferenceString = String()
    var model = [ProfileNotificationPreference]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.roundCorners([.topLeft,.topRight], radius: 16)
        self.saveBtn.layer.cornerRadius = 10
        self.notiPreferenceArray.removeAll()
        if self.model.count > 0{
            for i in 0..<(self.model.count) {
                let value = String(self.model[i].preference ?? 0)
                self.notiPreferenceArray.append(value)
                let notiValue = self.model[i].preference ?? 0
                if notiValue == 1 {
                    self.allBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                    self.newJobbtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                    self.chatBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                    self.jobProposalBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                    self.noneBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
                }else if notiValue == 2 {
                    self.newJobbtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                }else if notiValue == 3 {
                    self.jobProposalBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                }else if notiValue == 5 {
                    self.chatBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                }else{
                    self.noneBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                    self.allBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
                    self.newJobbtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
                    self.chatBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
                    self.jobProposalBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
                }
            }
        }else{
            self.allBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.newJobbtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.chatBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.jobProposalBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.noneBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let none = String(4)
            if self.notiPreferenceArray.contains(none){
                let noneID = self.notiPreferenceArray.firstIndex(of: none)!
                self.notiPreferenceArray.remove(at: noneID)
            }else{
                
            }
            let allJob = String(1)
            if self.notiPreferenceArray.contains(allJob){
                
            }else{
                self.notiPreferenceArray.append(allJob)
            }
            
            let newJobb = String(2)
            if self.notiPreferenceArray.contains(newJobb){
                
            }else{
                self.notiPreferenceArray.append(newJobb)
            }
            
            let jobProposal = String(3)
            if self.notiPreferenceArray.contains(jobProposal){
                
            }else{
                self.notiPreferenceArray.append(jobProposal)
            }
            
            let chat = String(5)
            if self.notiPreferenceArray.contains(chat){
                
            }else{
                self.notiPreferenceArray.append(chat)
            }
            print(self.notiPreferenceArray)
        }
        
        // Do any additional setup after loading the view.
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
    @IBAction func btnAll(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if self.allBtn.currentImage != UIImage(named: "checkFilled") {
            self.allBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.newJobbtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.chatBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.jobProposalBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.noneBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let none = String(4)
            if self.notiPreferenceArray.contains(none){
                let noneID = self.notiPreferenceArray.firstIndex(of: none)!
                self.notiPreferenceArray.remove(at: noneID)
            }else{
                
            }
            let allJob = String(1)
            if self.notiPreferenceArray.contains(allJob){
                
            }else{
                self.notiPreferenceArray.append(allJob)
            }
            
            let newJobb = String(2)
            if self.notiPreferenceArray.contains(newJobb){
                
            }else{
                self.notiPreferenceArray.append(newJobb)
            }
            
            let jobProposal = String(3)
            if self.notiPreferenceArray.contains(jobProposal){
                
            }else{
                self.notiPreferenceArray.append(jobProposal)
            }
            
            let chat = String(5)
            if self.notiPreferenceArray.contains(chat){
                
            }else{
                self.notiPreferenceArray.append(chat)
            }
            print(self.notiPreferenceArray)
        }else{
            
        }
    }
    // MARK: - button for perefernce
    @IBAction func btnNewJob(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if self.newJobbtn.currentImage != UIImage(named: "checkFilled") {
            self.noneBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let none = String(4)
            if self.notiPreferenceArray.contains(none){
                let noneID = self.notiPreferenceArray.firstIndex(of: none)!
                self.notiPreferenceArray.remove(at: noneID)
            }else{
                
            }
            self.newJobbtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            let newJob = String(2)
            self.notiPreferenceArray.append(newJob)
        }else{
            self.newJobbtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let newJob = String(2)
            let newJobID = self.notiPreferenceArray.firstIndex(of: newJob)!
            self.notiPreferenceArray.remove(at: newJobID)
            self.allBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let allNoti = String(1)
            if self.notiPreferenceArray.contains(allNoti){
                let allID = self.notiPreferenceArray.firstIndex(of: allNoti)!
                self.notiPreferenceArray.remove(at: allID)
            }else{
                
            }
            print(self.notiPreferenceArray)
        }
    }
    // MARK: - button for perefernce
    @IBAction func btnChat(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if self.chatBtn.currentImage != UIImage(named: "checkFilled") {
            self.noneBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let none = String(4)
            if self.notiPreferenceArray.contains(none){
                let noneID = self.notiPreferenceArray.firstIndex(of: none)!
                self.notiPreferenceArray.remove(at: noneID)
            }else{
                
            }
            self.chatBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            let chat = String(5)
            self.notiPreferenceArray.append(chat)
        }else{
            self.chatBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let chat = String(5)
            let chatID = self.notiPreferenceArray.firstIndex(of: chat)!
            self.notiPreferenceArray.remove(at: chatID)
            self.allBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let allNoti = String(1)
            if self.notiPreferenceArray.contains(allNoti){
                let allID = self.notiPreferenceArray.firstIndex(of: allNoti)!
                self.notiPreferenceArray.remove(at: allID)
            }else{
                
            }
            print(self.notiPreferenceArray)
        }
    }
    // MARK: - button for perefernce
    @IBAction func btnJobProposal(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if self.jobProposalBtn.currentImage != UIImage(named: "checkFilled") {
            self.noneBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let none = String(4)
            if self.notiPreferenceArray.contains(none){
                let noneID = self.notiPreferenceArray.firstIndex(of: none)!
                self.notiPreferenceArray.remove(at: noneID)
            }else{
                
            }
            self.jobProposalBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            let jobProposal = String(3)
            self.notiPreferenceArray.append(jobProposal)
        }else{
            self.jobProposalBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let jobProposal = String(3)
            let jobProposalID = self.notiPreferenceArray.firstIndex(of: jobProposal)!
            self.notiPreferenceArray.remove(at: jobProposalID)
            self.allBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let allNoti = String(1)
            if self.notiPreferenceArray.contains(allNoti){
                let allID = self.notiPreferenceArray.firstIndex(of: allNoti)!
                self.notiPreferenceArray.remove(at: allID)
            }else{
                
            }
            print(self.notiPreferenceArray)
        }
    }
    // MARK: - button for perefernce
    @IBAction func btnNone(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if self.noneBtn.currentImage != UIImage(named: "checkFilled") {
            self.notiPreferenceArray.removeAll()
            self.noneBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.allBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.newJobbtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.chatBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.jobProposalBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.notiPreferenceArray.removeAll()
            let none = String(4)
            self.notiPreferenceArray.append(none)
        }else{
            
        }
    }
    
    // MARK: - button for perefernce
    @IBAction func btnSave(_ sender: UIButton){
        if self.notiPreferenceArray.count > 0{
            let stringRepresentation = notiPreferenceArray.joined(separator: ",")
            self.notiPreferenceString = stringRepresentation
            self.notificationPreferenceApi()
        }else{
            self.view.makeToast(message: "Please select atlest one.")
        }
        
    }
    
    func notificationPreferenceApi(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["notification_preference":notiPreferenceString] as [String : Any]
        
        APIManager.shared.notificationPreferenceApi(baseUrl: Config().API_URL + "/api/update-notification-preference", parameter: paramDict, token: authToken) { response in
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

extension GeneralSettingsView: SideMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
    func toggleRightMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
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
