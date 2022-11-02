//
//  AddExperienceswift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import Foundation
import UIKit

class AddExperienceViewModel {
    
    var controller: AddExperienceView?
    var positionName = String()
    var barName = String()
    var startDate = String()
    var endDate = String()
    var totalExp = String()
    var isCheck = Int()
    var isComeFromAdd = Bool()
    var expId = Int()
    
    func updateAddExrerienceAPi(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["title":self.controller!.positionNameTxt.text!,"description":self.controller!.barNameTxt.text!,"start_date":startDate,"end_date":endDate,"years":totalExp,"present":isCheck,"id":expId] as [String : Any]
        
        APIManager.shared.updateExperienceApi(baseUrl: Config().API_URL + "/api/updateUserExperience", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["status"] as! Int == 200 {
                if self.controller?.delegate != nil {
                    self.controller?.navigationController?.popViewController(animated: true)
                    self.controller?.delegate?.experienceData(update: self.controller?.delegate != nil)
                }else{
                    self.controller?.navigationController?.popViewController(animated: true)
                }
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        
        self.controller?.endDateTxt.isUserInteractionEnabled = true
        
        self.controller?.positionNameTxt.setLeftPaddingPoints(15)
        self.controller?.positionNameTxt.delegate = self.controller
        self.controller?.barNameTxt.setLeftPaddingPoints(15)
        self.controller?.barNameTxt.delegate = self.controller
        self.controller?.startDateTxt.setLeftPaddingPoints(15)
        self.controller?.startDateTxt.delegate = self.controller
        self.controller?.endDateTxt.setLeftPaddingPoints(15)
        self.controller?.endDateTxt.delegate = self.controller
        
        self.controller?.positionNameTxt.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.positionNameTxt.layer.borderWidth = 1.0
        self.controller?.positionNameTxt.layer.cornerRadius = 10
        self.controller?.barNameTxt.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.barNameTxt.layer.borderWidth = 1.0
        self.controller?.barNameTxt.layer.cornerRadius = 10
        self.controller?.startDateTxt.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.startDateTxt.layer.borderWidth = 1.0
        self.controller?.startDateTxt.layer.cornerRadius = 10
        self.controller?.endDateTxt.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.endDateTxt.layer.borderWidth = 1.0
        self.controller?.endDateTxt.layer.cornerRadius = 10
        if isComeFromAdd{
            self.controller?.checkBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.controller?.endDateTxt.isUserInteractionEnabled = false
            self.isCheck = 1
        }else{
            if self.isCheck == 1 {
                self.controller?.checkBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
                self.controller?.endDateTxt.isUserInteractionEnabled = false
                self.controller?.endDateTxt.text = ""
            }else{
                self.controller?.checkBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
                self.controller?.endDateTxt.isUserInteractionEnabled = true
                self.controller?.endDateTxt.text = dateFormate(value: self.endDate)
            }
            
            self.controller?.positionNameTxt.text = positionName
            self.controller?.barNameTxt.text = barName
            self.controller?.startDateTxt.text = dateFormate(value: self.startDate)
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
    
    func changeDateFormate(item:String) -> String{
        if item.contains("year") && item.contains("month"){
            var newitem = item.replacingOccurrences(of: "years", with: "Year(s)")
            newitem = newitem.replacingOccurrences(of: "year", with: "Year(s)")
            newitem = newitem.replacingOccurrences(of: "months", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "month", with: "Month(s)")
            return newitem
        }else if item.contains("month") && item.contains("week"){
            var newitem = item.replacingOccurrences(of: "months", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "month", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "weeks", with: "Week(s)")
            newitem = newitem.replacingOccurrences(of: "week", with: "Week(s)")
            return newitem
        }else if item.contains("week") && item.contains("day"){
            return "Less then month"
        }else if item.contains("year"){
            var newitem = item.replacingOccurrences(of: "years", with: "Year(s)")
            newitem = newitem.replacingOccurrences(of: "year", with: "Year(s)")
            return newitem
        }else if item.contains("month"){
            var newitem = item.replacingOccurrences(of: "months", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "month", with: "Month(s)")
            return newitem
        }else if item.contains("week"){
            return "Less then month"
        }else if item.contains("day"){
            return "Less then month"
        }else{
            return item
        }
    }
    
}
