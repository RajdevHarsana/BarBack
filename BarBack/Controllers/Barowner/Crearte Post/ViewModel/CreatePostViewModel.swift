//
//  CreatePostViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 13/10/22.
//

import Foundation

class CreatePostViewModel {
    
    var controller: CreatePostView?
    var titleName = String()
    var hourlyRate = String()
    var deadline = String()
    var jobTime = String()
    var description = String()
    var isComeFromEdit = Bool()
    var postId = String()
    
    func updateJobPostAPi(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["title":self.controller!.titleTxtField.text!,"description":self.controller!.descriptionTxtView.text!,"hourly_rate":self.controller!.hourlyRateTxtField.text!,"deadline":deadline,"job_time":self.controller!.jobTimeTxtField.text!,"id":postId] as [String : Any]
        
        APIManager.shared.updatePostJobApi(baseUrl: Config().API_URL + "/api/job-post", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["status"] as! Int == 200 {
                self.controller?.view.makeToast(message: message)
                self.controller?.navigationController?.popViewController(animated: true)
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    
    func updateView(){
        self.controller?.titleTxtField.setLeftPaddingPoints(25)
        self.controller?.titleTxtField.delegate = self.controller
        self.controller?.hourlyRateTxtField.setLeftPaddingPoints(25)
        self.controller?.hourlyRateTxtField.delegate = self.controller
        self.controller?.deadlineTxtField.setLeftPaddingPoints(25)
        self.controller?.deadlineTxtField.delegate = self.controller
        self.controller?.jobTimeTxtField.setLeftPaddingPoints(25)
        self.controller?.jobTimeTxtField.delegate = self.controller
        self.controller?.descriptionTxtView.delegate = self.controller
        self.controller?.descriptionTxtView.leftSpace(25)
        
        self.controller?.titleTxtField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
        self.controller?.titleTxtField.layer.borderWidth = 1.0
        self.controller?.titleTxtField.layer.cornerRadius = (self.controller?.titleTxtField.frame.height)!/2
        self.controller?.hourlyRateTxtField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
        self.controller?.hourlyRateTxtField.layer.borderWidth = 1.0
        self.controller?.hourlyRateTxtField.layer.cornerRadius = (self.controller?.hourlyRateTxtField.frame.height)!/2
        self.controller?.deadlineTxtField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
        self.controller?.deadlineTxtField.layer.borderWidth = 1.0
        self.controller?.deadlineTxtField.layer.cornerRadius = (self.controller?.deadlineTxtField.frame.height)!/2
        self.controller?.jobTimeTxtField.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
        self.controller?.jobTimeTxtField.layer.borderWidth = 1.0
        self.controller?.jobTimeTxtField.layer.cornerRadius = (self.controller?.jobTimeTxtField.frame.height)!/2
        self.controller?.descriptionTxtView.layer.borderColor = #colorLiteral(red: 0.137254902, green: 0.1215686275, blue: 0.1254901961, alpha: 1)
        self.controller?.descriptionTxtView.layer.borderWidth = 1.0
        self.controller?.descriptionTxtView.layer.cornerRadius = 23
        
        self.controller?.postBtn.layer.cornerRadius = 15
        
        if isComeFromEdit{
            self.controller?.titleTxtField.text = titleName
            self.controller?.hourlyRateTxtField.text = hourlyRate
            self.controller?.deadlineTxtField.text = dateFormate(value: self.deadline)
            self.controller?.jobTimeTxtField.text = jobTime
            self.controller?.descriptionTxtView.text = description
            self.controller?.descriptionLbl.isHidden = true
        }else{
            self.controller?.titleTxtField.text = ""
            self.controller?.hourlyRateTxtField.text = ""
            self.controller?.deadlineTxtField.text = ""
            self.controller?.jobTimeTxtField.text = ""
            self.controller?.descriptionTxtView.text = ""
            self.controller?.descriptionLbl.isHidden = false
        }
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
