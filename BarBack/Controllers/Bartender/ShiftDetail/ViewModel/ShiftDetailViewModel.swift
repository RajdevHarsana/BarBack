//
//  ShiftDetailViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 18/09/22.
//

import Foundation
import UIKit
import Kingfisher

protocol ApplyJobProtocol {
    func jobApply(isApplied:Bool,Index:Int)
}

class ShiftDetailViewModel {
    
    var controller: ShiftDetailView?
    var jobId = Int()
    var model = [ShiftDetiailModel]()
    var createDate = String()
    var isApplied = Bool()
    var delegate : ApplyJobProtocol? = nil
    var selectedIndex = Int()
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    
    func shiftDetailRequestAPI(){
        Loader.start()
        let paramDict = ["job_id":jobId] as [String : Any]
        
        APIManager.shared.shiftDetailDataApi(baseUrl: Config().API_URL + "/api/job-detail", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! ShiftDetiailModel
            let message = data.message ?? ""
            if (data.status != nil) == true {
                self.model.append(response as! ShiftDetiailModel)
                self.controller?.backView.isHidden = false
                self.updateUI()
//                self.controller?.tbl_searchList.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func requestJobAPI(){
        Loader.start()
        let paramDict = ["job_id":jobId] as [String : Any]
        
        APIManager.shared.applyJobRequestApi(baseUrl: Config().API_URL + "/api/request-job", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if ((data?["success"]) != nil) == true {
                self.controller?.hourlyRateTxt.isUserInteractionEnabled = false
                self.controller?.hourlyRateTxt.isHidden = true
                self.controller?.applyBtnWidthContrants.constant = UIScreen.main.bounds.width
                self.controller?.applyBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                self.controller?.applyBtn.setTitle("Applied", for: .normal)
                self.isApplied = true
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateUI(){
        self.isApplied = self.model[0].data?.isApplied ?? false
        if self.isApplied != true {
            self.controller?.hourlyRateTxt.isUserInteractionEnabled = true
            self.controller?.hourlyRateTxt.isHidden = false
            self.controller?.applyBtnWidthContrants.constant = 150
            self.controller?.applyBtn.backgroundColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
            self.controller?.applyBtn.setTitle("Apply", for: .normal)
        }else{
            self.controller?.hourlyRateTxt.isUserInteractionEnabled = false
            self.controller?.hourlyRateTxt.isHidden = true
            self.controller?.applyBtnWidthContrants.constant = UIScreen.main.bounds.width
            self.controller?.applyBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.controller?.applyBtn.setTitle("Applied", for: .normal)
        }
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
    }
    
    func updateView(){
        self.controller?.jobImg.layer.cornerRadius = (self.controller?.jobImg.frame.height)!/2
        self.controller?.jobImg.layer.borderWidth = 2
        self.controller?.jobImg.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        
        self.controller?.backView.layer.cornerRadius = 25
        self.controller?.backView.layer.masksToBounds = true
        
        self.controller?.applyBtn.layer.cornerRadius = 10
        self.controller?.applyBtn.layer.masksToBounds = true
        self.controller?.hourlyRateTxt.layer.cornerRadius = 10
        self.controller?.hourlyRateTxt.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        self.controller?.hourlyRateTxt.layer.borderWidth = 1
        self.controller?.hourlyRateTxt.layer.masksToBounds = true
        self.controller?.hourlyRateTxt.setLeftPaddingPoints(15)
        
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

extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSxx"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}

extension Date {
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    func days(from date: Date) -> Int {
        Calendar.current.dateComponents([.day], from: date.noon, to: noon).day!
    }
    var daysFromToday: Int { days(from: Date()) }
}
