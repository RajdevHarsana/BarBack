//
//  ShiftDetailView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 13/09/22.
//

import UIKit

class ShiftDetailView: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var jobImg : UIImageView!
    @IBOutlet weak var jobTitle : UILabel!
    @IBOutlet weak var jobBarName : UILabel!
    @IBOutlet weak var jobPostDate : UILabel!
    @IBOutlet weak var jobRate : UILabel!
    @IBOutlet weak var jobLocation : UILabel!
    @IBOutlet weak var jobJoinDate : UILabel!
    @IBOutlet weak var jobTimeing : UILabel!
    @IBOutlet weak var jobDiscription : UILabel!
    @IBOutlet weak var applyBtn : UIButton!
    @IBOutlet weak var hourlyRateTxt: UITextField!
    @IBOutlet weak var applyBtnWidthContrants: NSLayoutConstraint!
    
    var viewModel = ShiftDetailViewModel()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.isHidden = true
        self.viewModel.controller = self
        self.viewBackground.roundCorners([.topLeft, .topRight], radius: 16)
        self.viewModel.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.shiftDetailRequestAPI()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton){
        if self.viewModel.delegate != nil{
            self.navigationController?.popViewController(animated: true)
            self.viewModel.delegate?.jobApply(isApplied: self.viewModel.isApplied, Index: viewModel.selectedIndex)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func selectedAction(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BarJobDetailView") as! BarJobDetailView
        controller.viewModel.userID = self.viewModel.model[0].data?.userID ?? 0
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func applyBtnAction(_ sender: UIButton){
        if self.viewModel.isApplied != true{
            if self.hourlyRateTxt.text == "" {
                self.view.makeToast(message: "Please enter your hourly rate.")
            }else if self.hourlyRateTxt.text == "0" {
                self.view.makeToast(message: "Hourly rate could't be zero.")
            }else{
                self.viewModel.requestJobAPI()
            }
        }else{
            
        }
        
    }
    
    // MARK: - button for search on map
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }

}

extension ShiftDetailView: SideMenuDelegates {
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
