//
//  PostDetailViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 13/10/22.
//

import Foundation
import UIKit

class PostDetailViewModel {
    
    var controller: PostDetailView?
    var model = [PostDetailModel]()
    var listDataModel = [JobRequest]()
    var jobId = Int()
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    
    func postDetailRequestAPI(){
        Loader.start()
        let paramDict = ["job_id":jobId] as [String : Any]
        
        APIManager.shared.postDetailDataApi(baseUrl: Config().API_URL + "/api/my-job-detail", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! PostDetailModel
            let message = data.message ?? ""
            if (data.status != nil) == true {
                self.model.append(response as! PostDetailModel)
                self.listDataModel.append(contentsOf: data.data?.jobRequest ?? [])
                self.controller?.backView.isHidden = false
                self.updateUI()
                self.controller?.listTblView.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func requestJobAPI(id:Int,action:String){
        Loader.start()
        let paramDict = ["job_request_id":id,"action":action] as [String : Any]
        
        APIManager.shared.acceptDeclineJobRequestApi(baseUrl: Config().API_URL + "/api/request-action", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["success"] as? Bool ?? false == true {
                self.postDetailRequestAPI()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateUI(){
        
        let profileImgURL = URL(string: self.model[0].data?.user?.profileImage ?? "")
        self.controller?.jobImg.kf.indicatorType = .activity
        self.controller?.jobImg.kf.setImage(with: profileImgURL)
        self.controller?.jobTitle.text = self.model[0].data?.title ?? ""
//        self.controller?.jobPostDate.text = createDate
        self.controller?.jobPostDate.isHidden = true
        self.controller?.jobBarName.text = self.model[0].data?.user?.fullname ?? ""
        self.controller?.jobRate.text = "$" + "\(self.model[0].data?.hourlyRate ?? 0)"
        self.controller?.jobLocation.text = "\(self.model[0].data?.user?.userAddress?.city ?? "")" + ", " + "\(self.model[0].data?.user?.userAddress?.state ?? "")"
        self.controller?.jobJoinDate.text = dateFormate(value: self.model[0].data?.deadline ?? "")
        self.controller?.jobTimeing.text = self.model[0].data?.jobTime ?? ""
        self.controller?.jobDiscription.text = self.model[0].data?.dataDescription ?? ""
        
        if self.model[0].data?.jobRequest?.count ?? 0 > 0 {
            self.controller?.applicationsLbl.isHidden = false
        }else{
            self.controller?.applicationsLbl.isHidden = true
        }
        
    }
    
    func updateView(){
        
        self.controller?.applicationsLbl.isHidden = true
        
        self.controller?.jobImg.layer.cornerRadius = (self.controller?.jobImg.frame.height)!/2
        self.controller?.jobImg.layer.borderWidth = 2
        self.controller?.jobImg.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        
        self.controller?.backView.layer.cornerRadius = 25
        self.controller?.backView.layer.masksToBounds = true
        
        self.controller?.editBtn.layer.cornerRadius = 10
        self.controller?.editBtn.layer.masksToBounds = true
        
        self.controller?.backView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.backView.layer.shadowOpacity = 0.6
        self.controller?.backView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.backView.layer.shadowRadius = 2.0
        self.controller?.backView.layer.masksToBounds = false
        
        
    }
    
    func dateFormate(value:String) -> String{
        let isoDate = value
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //
        var finalDate = String()
        if let date = dateFormatter.date(from: isoDate) {
            dateFormatter.dateFormat = "MM/dd/YYYY"
            //Output: 12:16 PM on January 01, 2000
            finalDate = dateFormatter.string(from: date)
            print(dateFormatter.string(from: date))
            print(date)
            return finalDate
        }else{
            return ""
        }
    }
    
}
