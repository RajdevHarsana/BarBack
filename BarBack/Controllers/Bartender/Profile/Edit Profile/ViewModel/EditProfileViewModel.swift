//
//  EditProfileViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import Foundation
import UIKit

class EditProfileViewModel {
    
    var controller: EditProfileView?
    var placeLat = Double()
    var placeLong = Double()
    var model = [UpdateProfileModel]()
    var name = String()
    var email = String()
    var address = String()
    var addressLine1 = String()
    var addressLine2 = String()
    var city = String()
    var state = String()
    var zipCode = String()
    var country = String()
    var countryCode = String()
    var about = String()
    var profileImage:UIImage!
    var coverImage:UIImage!
    
    
    func editProfileApi(fullName:String,email:String,about:String,address1:String,address2:String,city:String,state:String,zipCode:String,image: UIImage,coverImage:UIImage,hourlyRate:String,workingDays:String){
        Loader.start()
        let param = ["fullname":fullName,"email":email,"about_me":about,"address1":address1,"address2":address2,"city":city,"state":state,"country":self.country,"zip":zipCode,"country_code":self.countryCode,"latitude":placeLat,"longitude":placeLong,"hourly_rate":hourlyRate,"working_days":workingDays] as [String : Any]
        
        APIManager.shared.uploadImageDataWithToken(inputUrl: Config().API_URL + "/api/update-profile", parameters: param, imageName: "image", imageFile: image,coverimageName: "cover_image", coverimageFile: coverImage) { response in
            print(response)
            let data = response as! UpdateProfileModel
            let message = data.message ?? ""
            if data.status ?? 0 == 200 {
                self.model.append(response as! UpdateProfileModel)
                Config().AppUserDefaults.set(self.model[0].data?.profileImage, forKey: "userProfileImage")
                if self.controller?.delegate != nil {
                    self.controller?.navigationController?.popViewController(animated: true)
                    self.controller?.delegate?.editProfileData()
                }
            }else{
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateUI(){
        self.controller?.profileImg.image = profileImage
        self.controller?.coverImg.image = coverImage
        self.controller?.fullNameTxtField.text = name
        self.controller?.emailTxtField.text = email
        self.controller?.addressLine1TxtField.text = addressLine1
        self.controller?.addressLine2TxtField.text = addressLine2
        self.controller?.cityTxtField.text = city
        self.controller?.stateTxtField.text = state
        self.controller?.zipCodeTxtField.text = zipCode
        self.controller?.aboutTxtView.text = about
        self.controller?.aboutTxtView.textColor = UIColor.black
        if self.about != ""{
            self.controller?.aboutLbl.isHidden = true
        }else{
            self.controller?.aboutLbl.isHidden = false
        }
    }
    
    func updateView(){
        self.controller?.fullNameTxtField.setLeftPaddingPoints(15)
        self.controller?.fullNameTxtField.delegate = self.controller
        self.controller?.emailTxtField.setLeftPaddingPoints(15)
        self.controller?.emailTxtField.delegate = self.controller
        self.controller?.hourlyRateTxtField.setLeftPaddingPoints(15)
        self.controller?.hourlyRateTxtField.delegate = self.controller
        self.controller?.workingDaysTxtField.setLeftPaddingPoints(15)
        self.controller?.workingDaysTxtField.delegate = self.controller
        self.controller?.zipCodeTxtField.setLeftPaddingPoints(15)
        self.controller?.zipCodeTxtField.delegate = self.controller
        self.controller?.addressLine1TxtField.setLeftPaddingPoints(15)
        self.controller?.addressLine1TxtField.delegate = self.controller
        self.controller?.addressLine2TxtField.setLeftPaddingPoints(15)
        self.controller?.addressLine2TxtField.delegate = self.controller
        self.controller?.cityTxtField.setLeftPaddingPoints(15)
        self.controller?.cityTxtField.delegate = self.controller
        self.controller?.stateTxtField.setLeftPaddingPoints(15)
        self.controller?.stateTxtField.delegate = self.controller
        self.controller?.aboutTxtView.delegate = self.controller
        self.controller?.aboutTxtView.text = " About"
        self.controller?.aboutTxtView.leftSpace(10)
        self.controller?.aboutTxtView.textColor = UIColor.lightGray
        
        self.controller?.fullNameTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.fullNameTxtField.layer.borderWidth = 1.0
        self.controller?.fullNameTxtField.layer.cornerRadius = 10
        self.controller?.emailTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.emailTxtField.layer.borderWidth = 1.0
        self.controller?.emailTxtField.layer.cornerRadius = 10
        self.controller?.hourlyRateTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.hourlyRateTxtField.layer.borderWidth = 1.0
        self.controller?.hourlyRateTxtField.layer.cornerRadius = 10
        self.controller?.workingDaysTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.workingDaysTxtField.layer.borderWidth = 1.0
        self.controller?.workingDaysTxtField.layer.cornerRadius = 10
        self.controller?.zipCodeTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.zipCodeTxtField.layer.borderWidth = 1.0
        self.controller?.zipCodeTxtField.layer.cornerRadius = 10
        self.controller?.addressLine1TxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.addressLine1TxtField.layer.borderWidth = 1.0
        self.controller?.addressLine1TxtField.layer.cornerRadius = 10
        self.controller?.addressLine2TxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.addressLine2TxtField.layer.borderWidth = 1.0
        self.controller?.addressLine2TxtField.layer.cornerRadius = 10
        self.controller?.cityTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.cityTxtField.layer.borderWidth = 1.0
        self.controller?.cityTxtField.layer.cornerRadius = 10
        self.controller?.stateTxtField.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.stateTxtField.layer.borderWidth = 1.0
        self.controller?.stateTxtField.layer.cornerRadius = 10
        
        self.controller?.aboutTxtView.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.controller?.aboutTxtView.layer.borderWidth = 1.0
        self.controller?.aboutTxtView.layer.cornerRadius = 10
        
        self.controller?.selectBtn.layer.cornerRadius = 10
        
        self.controller?.profileImg.layer.cornerRadius = (self.controller?.profileImg.frame.height)! / 2
    }
    
}
