//
//  BarDetailViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 20/09/22.
//

import Foundation
import UIKit
import Kingfisher

class BarDetailViewModel {
    
    var controller: BarJobDetailView? = nil
    var model = [BarDetailModel]()
    var userID = Int()
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    
    func barDetailRequestAPI( ){
        Loader.start()
        let paramDict = ["user_id":userID] as [String : Any]
        
        APIManager.shared.barDetailDataApi(baseUrl: Config().API_URL + "/api/bar-detail", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! BarDetailModel
            let message = data.message ?? ""
            if (data.status != nil) == true {
                self.model.append(response as! BarDetailModel)
                self.updateUI()
                self.controller?.listTblView.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        self.controller?.barAboutView.layer.cornerRadius = 10
        self.controller?.barAboutView.layer.masksToBounds = true;
        
        self.controller?.barAboutView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.barAboutView.layer.shadowOpacity = 0.6
        self.controller?.barAboutView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.barAboutView.layer.shadowRadius = 2.0
        self.controller?.barAboutView.layer.masksToBounds = false
        
        self.controller?.barDetailView.layer.cornerRadius = 10
        self.controller?.barDetailView.layer.masksToBounds = true;
        
        self.controller?.barDetailView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.barDetailView.layer.shadowOpacity = 0.6
        self.controller?.barDetailView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.barDetailView.layer.shadowRadius = 2.0
        self.controller?.barDetailView.layer.masksToBounds = false
    }
    
    func updateUI(){
        self.controller?.barName.text = self.model[0].data?.fullname ?? ""
        let profileImgURL = URL(string: self.model[0].data?.profileImage ?? "")
        self.controller?.barImage.kf.indicatorType = .activity
        self.controller?.barImage.kf.setImage(with: profileImgURL)
        let coverImgURL = URL(string: self.model[0].data?.coverImage ?? "")
        self.controller?.barCoverImg.kf.indicatorType = .activity
        self.controller?.barCoverImg.kf.setImage(with: coverImgURL)
        self.controller?.barAbout.text = self.model[0].data?.aboutMe ?? ""
        self.controller?.barLocation.text = "\(self.model[0].data?.userAddress?.city ?? "")" + ", " + "\(self.model[0].data?.userAddress?.state ?? "")"
        let count = self.model[0].data?.workingdays?.count ?? 0
        if count != 0 {
            self.controller?.barWorkingHours.text = "\(count)" + " day " + "\(self.model[0].data?.startWorkingTime ?? "")" + " to " + "\(self.model[0].data?.endWorkingTime ?? "")"
            var dayArray = [String]()
            for i in 0..<(self.model[0].data?.workingdays?.count ?? 0)!{
                let day = self.model[0].data?.workingdays?[i].title ?? ""
                dayArray.append(day)
            }
            let stringRepresentation = dayArray.joined(separator: ",")
            self.controller?.barWorkingDays.text = stringRepresentation
        }else{
            self.controller?.barWorkingHours.text = "\(self.model[0].data?.startWorkingTime ?? "")" + " to " + "\(self.model[0].data?.endWorkingTime ?? "")"
            self.controller?.barWorkingDays.text = "Not Specified "
        }
        
        
    }
    
    func calculateDays(_ days: String) -> String? {
            switch days {
            case "0":
                return "Monday"
            case "1":
                return "Tuesday"
            case "3":
                return "Wednesday"
            case "4":
                return "Thrusday"
            case "5":
                return "Friday"
            case "6":
                return "Saturday"
            case "7":
                return "Sunday"
            default:
                return ""
            }
    }
    
    
}
