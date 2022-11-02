//
//  IntroVC.swift
//  BarBack
//
//  Created by Mac on 09/09/22.
//

import UIKit

class IntroVC: UIViewController {
    
    @IBOutlet weak var btn_start: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        btn_start.layer.cornerRadius = 10
        btn_start.layer.masksToBounds = true
    }
    
    
    // MARK: - button for Signup
    @IBAction func btn_GetStart(_ sender: UIButton){
        Config().AppUserDefaults.set(true, forKey: "hasSeenIntro")
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    
}
