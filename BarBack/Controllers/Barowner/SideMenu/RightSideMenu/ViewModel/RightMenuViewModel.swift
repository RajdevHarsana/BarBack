//
//  RightMenuViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import UIKit
import Foundation
import Kingfisher

class RightMenuViewModel {
    //MARK: - Variables
    var controller: RightMenuViewController?
    var menuItems = ["Search","Bar Profile","Messages","My job postings","Settings"]
    var email = String()
    var phoneNum = String()
    var userName = Config().AppUserDefaults.string(forKey: "userName") ?? ""
    var profileImage = Config().AppUserDefaults.string(forKey: "userProfileImage") ?? ""
    
    func updateView(){
        self.controller?.menuView.layer.cornerRadius = 20
        self.controller?.menuView.clipsToBounds = true
        self.controller?.ProfileImgView.layer.borderColor = UIColor.white.cgColor
        self.controller?.ProfileImgView.layer.borderWidth = 1
        self.controller?.ProfileImgView.layer.cornerRadius = (self.controller?.ProfileImgView.frame.height)! / 2
        let profileImgURL = URL(string: profileImage)
        self.controller?.ProfileImgView.kf.indicatorType = .activity
        self.controller?.ProfileImgView.kf.setImage(with: profileImgURL)
        self.controller?.UserNameLbl.text = userName
    }
}

