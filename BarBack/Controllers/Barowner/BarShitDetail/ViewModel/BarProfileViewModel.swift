//
//  BarProfileViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import Foundation
import UIKit
import Kingfisher

class BarProfileViewModel {
    
    var controller : BarShitDetailView?
    var model = [BarProfileModel]()
    
    func userDetailAPI(userId:Int){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["user_id":userId] as [String : Any]
        
        APIManager.shared.barShiftDetailApi(baseUrl: Config().API_URL + "/api/user-detail", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! BarProfileModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                self.model.removeAll()
                self.model.append(response as! BarProfileModel)
                self.updateUI()
                self.controller?.workExpTbl.reloadData()
                self.controller?.skillsCollection.reloadData()
                self.controller?.languageCollection.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
                self.controller?.expereincetblViewHeightConstrant.constant = 50
                self.controller?.skillCollectionViewHeightConstrant.constant = 30
                self.controller?.seeMoreBtn.isHidden = true
                self.controller?.seeMoreBottomConstrant.constant = 0
                self.controller?.languageViewHeightConstrant.constant = 30
            }
            Loader.stop()
        }
    }
    
    func updateUI(){
        self.controller?.userName.text = self.model[0].data?.fullname ?? ""
        let profileImgURL = URL(string: self.model[0].data?.profileImage ?? "")
        self.controller?.profileImage.kf.indicatorType = .activity
        self.controller?.profileImage.kf.setImage(with: profileImgURL)
        let image = self.model[0].data?.coverImage ?? ""
        let newImage = image.replacingOccurrences(of: " ", with: "")
        let coverImgURL = URL(string: newImage)
        self.controller?.coverImage.kf.indicatorType = .activity
        self.controller?.coverImage.kf.setImage(with: coverImgURL)
        self.controller?.aboutUser.text = self.model[0].data?.aboutMe ?? ""
        self.controller?.userAddress.text = "\(self.model[0].data?.userAddress?.city ?? "")" + "\(self.model[0].data?.userAddress?.country ?? "")"
        //
        if self.model[0].data?.userExperience?.count ?? 0 > 0 {
            
        }else{
            self.controller?.expereincetblViewHeightConstrant.constant = 50
        }
        //
        if self.model[0].data?.userSkill?.count ?? 0 > 0 {
            
            if self.model[0].data?.userSkill?.count ?? 0 > 5{
                self.controller?.skillCollectionViewHeightConstrant.constant = 100
                self.controller?.seeMoreBtn.isHidden = false
                self.controller?.seeMoreBottomConstrant.constant = 23
            }else{
                self.controller?.skillCollectionViewHeightConstrant.constant = 50
                self.controller?.seeMoreBtn.isHidden = true
                self.controller?.seeMoreBottomConstrant.constant = 0
            }
        }else{
            self.controller?.skillCollectionViewHeightConstrant.constant = 10
            self.controller?.seeMoreBtn.isHidden = true
            self.controller?.seeMoreBottomConstrant.constant = 0
        }
        
        if self.model[0].data?.userLanguage?.count ?? 0 > 0 {
            if self.model[0].data?.userLanguage?.count ?? 0 > 3 {
                self.controller?.languageViewHeightConstrant.constant = 116
            }else{
                self.controller?.languageViewHeightConstrant.constant = 50
            }
        }else{
            self.controller?.languageViewHeightConstrant.constant = 30
        }
        
        
    }
    
    func updateView(){
        
        self.controller?.profileImage.layer.cornerRadius = (self.controller?.profileImage.frame.height)! / 2
        
        self.controller?.contactBtn.layer.cornerRadius = 10
        self.controller?.contactBtn.layer.masksToBounds = true;
        
        self.controller?.aboutUserView.layer.cornerRadius = 10
        self.controller?.aboutUserView.layer.masksToBounds = true;
        
        self.controller?.aboutUserView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.aboutUserView.layer.shadowOpacity = 0.6
        self.controller?.aboutUserView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.aboutUserView.layer.shadowRadius = 2.0
        self.controller?.aboutUserView.layer.masksToBounds = false
        
        self.controller?.workExpView.layer.cornerRadius = 10
        self.controller?.workExpView.layer.masksToBounds = true;
        
        self.controller?.workExpView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.workExpView.layer.shadowOpacity = 0.6
        self.controller?.workExpView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.workExpView.layer.shadowRadius = 2.0
        self.controller?.workExpView.layer.masksToBounds = false
        
        self.controller?.skillsView.layer.cornerRadius = 10
        self.controller?.skillsView.layer.masksToBounds = true;
        
        self.controller?.skillsView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.skillsView.layer.shadowOpacity = 0.6
        self.controller?.skillsView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.skillsView.layer.shadowRadius = 2.0
        self.controller?.skillsView.layer.masksToBounds = false
        
        self.controller?.languageView.layer.cornerRadius = 10
        self.controller?.languageView.layer.masksToBounds = true;
        
        self.controller?.languageView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.languageView.layer.shadowOpacity = 0.6
        self.controller?.languageView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.languageView.layer.shadowRadius = 2.0
        self.controller?.languageView.layer.masksToBounds = false
    }
    
}
