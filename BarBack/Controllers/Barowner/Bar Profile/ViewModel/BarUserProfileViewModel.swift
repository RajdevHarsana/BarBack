//
//  BarUserProfileViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 20/10/22.
//

import Foundation
import UIKit
import Kingfisher

class BarUserProfileViewModel {
    
    var controller : BarUserProfileView?
    var model = [BarUserProfileModel]()
    
    func getProfileAPI(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.getBarOwnerProfileApi(baseUrl: Config().API_URL + "/api/profile-detail", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! BarUserProfileModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                self.model.removeAll()
                self.model.append(response as! BarUserProfileModel)
                self.updateUI()
                self.controller?.workingDaysCollection.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
//    func userDetailAPI(userId:Int){
//        Loader.start()
//        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
//        let paramDict = ["user_id":userId] as [String : Any]
//
//        APIManager.shared.barShiftDetailApi(baseUrl: Config().API_URL + "/api/user-detail", parameter: paramDict, token: authToken) { response in
//            print(response)
//
//            let data = response as! BarProfileModel
//            let message = data.message ?? ""
//            if data.success ?? false == true {
//                self.model.removeAll()
//                self.model.append(response as! BarProfileModel)
//                self.updateUI()
//                self.controller?.workExpTbl.reloadData()
//                self.controller?.skillsCollection.reloadData()
//                self.controller?.languageCollection.reloadData()
//            }else {
//                self.controller?.view.makeToast(message: message)
//            }
//            Loader.stop()
//        }
//    }
    
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
        self.controller?.locationName.text = "\(self.model[0].data?.userAddress?.address1 ?? "")" + "," + "\(self.model[0].data?.userAddress?.address2 ?? "")" + "," + "\(self.model[0].data?.userAddress?.city ?? "")" + "," + "\(self.model[0].data?.userAddress?.state ?? "")" + "," + "\(self.model[0].data?.userAddress?.country ?? "")"
            
            if self.model[0].data?.userLanguage?.count ?? 0 > 0 {
                if self.model[0].data?.userLanguage?.count ?? 0 > 3 {
                    self.controller?.wokingDayCollectionViewHeightConstrant.constant = 116
                }else{
                    self.controller?.wokingDayCollectionViewHeightConstrant.constant = 50
                }
            }else{
                self.controller?.wokingDayCollectionViewHeightConstrant.constant = 30
            }
    }
    
    func updateView(){
        
        self.controller?.profileImage.layer.cornerRadius = (self.controller?.profileImage.frame.height)! / 2
        
        self.controller?.aboutUserView.layer.cornerRadius = 10
        self.controller?.aboutUserView.layer.masksToBounds = true;
        
        self.controller?.aboutUserView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.aboutUserView.layer.shadowOpacity = 0.6
        self.controller?.aboutUserView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.aboutUserView.layer.shadowRadius = 2.0
        self.controller?.aboutUserView.layer.masksToBounds = false
        
        self.controller?.locationView.layer.cornerRadius = 10
        self.controller?.locationView.layer.masksToBounds = true;
        
        self.controller?.locationView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.locationView.layer.shadowOpacity = 0.6
        self.controller?.locationView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.locationView.layer.shadowRadius = 2.0
        self.controller?.locationView.layer.masksToBounds = false
                
        self.controller?.wokingDaysView.layer.cornerRadius = 10
        self.controller?.wokingDaysView.layer.masksToBounds = true;
        
        self.controller?.wokingDaysView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.wokingDaysView.layer.shadowOpacity = 0.6
        self.controller?.wokingDaysView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.wokingDaysView.layer.shadowRadius = 2.0
        self.controller?.wokingDaysView.layer.masksToBounds = false
    }
    
}
