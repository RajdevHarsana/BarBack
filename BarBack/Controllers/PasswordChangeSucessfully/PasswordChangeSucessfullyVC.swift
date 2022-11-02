//
//  PasswordChangeSucessfullyVC.swift
//  BarBack
//
//  Created by Mac on 09/09/22.
//

import UIKit

class PasswordChangeSucessfullyVC: UIViewController {
    
    @IBOutlet weak var btn_continue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_continue.layer.cornerRadius = 10
        btn_continue.layer.masksToBounds = true
    }
    
    
    // MARK: - IB Actions
         // MARK: - button for back navigation
       @IBAction func btn_back(_ sender: UIButton){
           navigationController?.popViewController(animated: true)
         }
    
    // MARK: - button for Signup
    @IBAction func btn_Continue(_ sender: UIButton){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LoginVC.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
  

   

}
