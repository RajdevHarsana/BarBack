//
//  ValidationClass.swift
//  Samksa
//
//  Created by Mac Mini on 17/12/14.
//  Copyright (c) 2014 Fullestop. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}

@available(iOS 13.0, *)
class ValidationClass: NSObject {
    
    func validateUrl (_ stringURL : String) -> Bool {
        
        let urlRegEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[urlRegEx])
        //let urlTest = NSPredicate.predicateWithSubstitutionVariables(predicate)
        
        return predicate.evaluate(with: stringURL)
    }
    
    func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?|http?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        if result == true{
            return false
        }else if url == ""{
            return false
        }else{
            return true
        }
        
    }
    
    func isBlank (_ textfield:UITextField) -> Bool {
        
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    func isTextViewBlank(_ textview:UITextView) -> Bool {
        
        let thetext = textview.text
        let trimmedString = thetext!.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    func isValidEmail(_ EmailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = EmailStr.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidMobile(_ MobileStr:String) -> Bool {
        
        let mobileRegEx = "[^0-9]"
        let range = MobileStr.range(of: mobileRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidDays(_ DaysStr:String) -> Bool {
        
        let mobileRegEx = "[1-7]"
        let range = DaysStr.range(of: mobileRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    
    func isValidPWD(_ PwdStr:String) -> Bool {
        
        let PwdRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,}"
        let range = PwdStr.range(of: PwdRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        return !result
    }
    func ValidateLoginForm(_ loginVCValidateObj:LoginVC) -> Bool {
        if isBlank(loginVCValidateObj.txt_email) {
            loginVCValidateObj.view.makeToast(message: "Please enter your email.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidEmail(loginVCValidateObj.txt_email.text!) {
            loginVCValidateObj.view.makeToast(message: "This is not correct email address")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPWD(loginVCValidateObj.txt_Password.text!) {
            loginVCValidateObj.view.makeToast(message: "Password should be numeric characters.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(loginVCValidateObj.txt_Password) {
            loginVCValidateObj.view.makeToast(message: "Please enter your password.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else if loginVCValidateObj.txt_Password.text!.count < 6 || loginVCValidateObj.txt_Password.text!.count > 16 {
            loginVCValidateObj.view.makeToast(message: "Password should be 6-16 characters.")
            loginVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    //
    func ValidateForgotPasswordForm(_ ForgotPsaawordVCValidateObj:ForgotPsaawordVC) -> Bool {
        if isBlank(ForgotPsaawordVCValidateObj.txt_email) {
            ForgotPsaawordVCValidateObj.view.makeToast(message: "Please enter your email.")
            ForgotPsaawordVCValidateObj.view.endEditing(true)
            return false
        }else if isValidEmail(ForgotPsaawordVCValidateObj.txt_email.text!) {
            ForgotPsaawordVCValidateObj.view.makeToast(message: "This is not correct email address")
            ForgotPsaawordVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    //
    //    func ValidateRecipientInfoForm(_ recipientValidateObj:RecipientInfo) -> Bool {
    //        if isBlank(recipientValidateObj.fullNameTxtField) {
    //            recipientValidateObj.view.makeToast(message: "Please enter name full name.")
    //            recipientValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(recipientValidateObj.mobileNumTxtField) {
    //            recipientValidateObj.view.makeToast(message: "Please enter Mobile number.")
    //            recipientValidateObj.view.endEditing(true)
    //            return false
    //        }else if recipientValidateObj.mobileNumTxtField.text!.count < 7 || recipientValidateObj.mobileNumTxtField.text!.count > 15 {
    //            recipientValidateObj.view.makeToast(message: "Mobile number should be 7-15 digits")
    //            recipientValidateObj.view.endEditing(true)
    //            return false
    //        }
    //        else if isBlank(recipientValidateObj.newAddressTxt) && isBlank(recipientValidateObj.fromMyAddressTxt){
    //            recipientValidateObj.view.makeToast(message: "Please select address.")
    //            recipientValidateObj.view.endEditing(true)
    //            return false
    //        }else if isTextViewBlank(recipientValidateObj.driverInstructionTxtView) {
    //            recipientValidateObj.view.makeToast(message: "Please enter driver instructions.")
    //            recipientValidateObj.view.endEditing(true)
    //            return false
    //        }
    //        else{
    //            return true
    //        }
    //    }
    //
    //    func ValidateCancelReasonForm(_ CancelReasonValidateObj:CancelPopUpView) -> Bool {
    //        if isBlank(CancelReasonValidateObj.selectCancelReasonTxt) {
    //            CancelReasonValidateObj.view.makeToast(message: "Please select cancel reason.")
    //            CancelReasonValidateObj.view.endEditing(true)
    //            return false
    //        }else if CancelReasonValidateObj.selectCancelReasonTxt.text == "Other Reason" {
    //            if isTextViewBlank(CancelReasonValidateObj.cancelDetailTxtView) {
    //                CancelReasonValidateObj.view.makeToast(message: "Please enter cancel reason.")
    //                CancelReasonValidateObj.view.endEditing(true)
    //                return false
    //            }
    //            else{
    //                return true
    //            }
    //        }else{
    //            return true
    //        }
    //    }
    //
    //    func ValidateSubmitReviewForm(_ SubmitReviewValidateObj:SubmitReviewView) -> Bool {
    //        if isTextViewBlank(SubmitReviewValidateObj.reviewTxtView) {
    //            SubmitReviewValidateObj.view.makeToast(message: "Please writw a review.")
    //            SubmitReviewValidateObj.view.endEditing(true)
    //            return false
    //        }else{
    //            return true
    //        }
    //    }
    //
    //    func ValidateDeliveryDetailsForm(_ deliveryValidateObj:DeliveryDetails) -> Bool {
    //        if isBlank(deliveryValidateObj.deliverDateTxtField) {
    //            deliveryValidateObj.view.makeToast(message: "Please select delivery date.")
    //            deliveryValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(deliveryValidateObj.DeliverTimeTxtField) {
    //            deliveryValidateObj.view.makeToast(message: "Please select delivet time.")
    //            deliveryValidateObj.view.endEditing(true)
    //            return false
    //        }
    //        else{
    //            return true
    //        }
    //    }
    //
    //    //    func ValidateContactUs(_ signUpVCValidateObj:ContactUsVC) -> Bool {
    //    //        if isBlank(signUpVCValidateObj.nameTxtFeild) {
    //    //            signUpVCValidateObj.view.makeToast(message: "Please enter your name.")
    //    //            signUpVCValidateObj.view.endEditing(true)
    //    //            return false
    //    //        }else if isBlank(signUpVCValidateObj.emailTxtFeild) {
    //    //            signUpVCValidateObj.view.makeToast(message: "Please enter email.")
    //    //            signUpVCValidateObj.view.endEditing(true)
    //    //            return false
    //    //        }else if isValidEmail(signUpVCValidateObj.emailTxtFeild.text!) {
    //    //            signUpVCValidateObj.view.makeToast(message: "This is not correct email address")
    //    //            signUpVCValidateObj.view.endEditing(true)
    //    //            return false
    //    //        }else if isTextViewBlank(signUpVCValidateObj.discriptionTxtView) {
    //    //            signUpVCValidateObj.view.makeToast(message: "Please enter your message.")
    //    //            signUpVCValidateObj.view.endEditing(true)
    //    //            return false
    //    //        }else{
    //    //            return true
    //    //        }
    //    //    }
    //
    //
    func ValidateUserSignUpForm(_ signUpVCValidateObj:SignupVC) -> Bool {
        if isBlank(signUpVCValidateObj.txt_name) {
            signUpVCValidateObj.view.makeToast(message: "Please enter your full name.")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else if signUpVCValidateObj.txt_name.text!.count < 3 || signUpVCValidateObj.txt_name.text!.count > 30 {
            signUpVCValidateObj.view.makeToast(message: "Full name should be 3-30 character")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(signUpVCValidateObj.txt_email) {
            signUpVCValidateObj.view.makeToast(message: "Please enter your email.")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else if isValidEmail(signUpVCValidateObj.txt_email.text!) {
            signUpVCValidateObj.view.makeToast(message: "This is not correct email address")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else if isValidPWD(signUpVCValidateObj.txt_Password.text!) {
            signUpVCValidateObj.view.makeToast(message: "Password should be numeric characters.")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(signUpVCValidateObj.txt_Password) {
            signUpVCValidateObj.view.makeToast(message: "Please enter your password.")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else if signUpVCValidateObj.txt_Password.text!.count < 6 || signUpVCValidateObj.txt_Password.text!.count > 16 {
            signUpVCValidateObj.view.makeToast(message: "Password should be 6-16 characters.")
            signUpVCValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    
    
    //    func ValidateUserRegisterBusiness(_ signUpVCValidateObj:RegisterBusinessVC) -> Bool {
    //        if isBlank(signUpVCValidateObj.nameTxtFeild) {
    //            signUpVCValidateObj.view.makeToast(message: "Please enter your business name.")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if signUpVCValidateObj.nameTxtFeild.text!.count < 3 || signUpVCValidateObj.nameTxtFeild.text!.count > 55 {
    //            signUpVCValidateObj.view.makeToast(message: "Business name should be 3-55 character")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(signUpVCValidateObj.emailTxtFeild) {
    //            signUpVCValidateObj.view.makeToast(message: "Please enter your email.")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isValidEmail(signUpVCValidateObj.emailTxtFeild.text!) {
    //            signUpVCValidateObj.view.makeToast(message: "This is not correct email address")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(signUpVCValidateObj.phoneTxtFeild) {
    //            signUpVCValidateObj.view.makeToast(message: "Please enter your phone number.")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if signUpVCValidateObj.phoneTxtFeild.text!.count < 7 || signUpVCValidateObj.phoneTxtFeild.text!.count > 15 {
    //            signUpVCValidateObj.view.makeToast(message: "Phone number should be 7-15 digits")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(signUpVCValidateObj.categaryTxtFeild){
    //            signUpVCValidateObj.view.makeToast(message: "Please enter your category.")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isBlank(signUpVCValidateObj.addressTxtFeild){
    //            signUpVCValidateObj.view.makeToast(message: "Please enter your address.")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isValidUrl(url: signUpVCValidateObj.webSiteTxtFeild.text!) {
    //            signUpVCValidateObj.view.makeToast(message: "This is not correct web address")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isValidUrl(url: signUpVCValidateObj.twitterProfileTxtFeild.text!) {
    //            signUpVCValidateObj.view.makeToast(message: "This is not correct twitter address")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isValidUrl(url: signUpVCValidateObj.fbProfileTxtFeild.text!) {
    //            signUpVCValidateObj.view.makeToast(message: "This is not correct facebook address")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isValidUrl(url: signUpVCValidateObj.instaProfileTxtFeild.text!) {
    //            signUpVCValidateObj.view.makeToast(message: "This is not correct instagram address")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else if isTextViewBlank(signUpVCValidateObj.discriptionTxtView){
    //            signUpVCValidateObj.view.makeToast(message: "Please enter your business discription.")
    //            signUpVCValidateObj.view.endEditing(true)
    //            return false
    //        }else{
    //            return true
    //        }
    //    }
    
    
    func validateReSetPasswordForm(_ ResetPasswordVCValidateObj:ResetPasswordVC) -> Bool {
        if isBlank(ResetPasswordVCValidateObj.txt_Password) {
            ResetPasswordVCValidateObj.view.makeToast(message: "Please enter your new password.")
            ResetPasswordVCValidateObj.view.endEditing(true)
            return false
        }
        //        else if isValidPWD(ResetPasswordVCValidateObj.txt_Password.text!) {
        //            ResetPasswordVCValidateObj.view.makeToast(message: "Password should be numeric characters.")
        //            ResetPasswordVCValidateObj.view.endEditing(true)
        //            return false
        //        }
        else if ResetPasswordVCValidateObj.txt_Password.text!.count < 6 || ResetPasswordVCValidateObj.txt_Password.text!.count > 16 {
            ResetPasswordVCValidateObj.view.makeToast(message: "New Password should be 6-16 character")
            ResetPasswordVCValidateObj.view.endEditing(true)
            return false
        }else if isBlank(ResetPasswordVCValidateObj.txt_repeatPassword) {
            ResetPasswordVCValidateObj.view.makeToast(message: "Please enter your confirm password.")
            ResetPasswordVCValidateObj.view.endEditing(true)
            return false
        }
        //        else if isValidPWD(ResetPasswordVCValidateObj.txt_repeatPassword.text!) {
        //            ResetPasswordVCValidateObj.view.makeToast(message: "Password should be numeric characters.")
        //            ResetPasswordVCValidateObj.view.endEditing(true)
        //            return false
        //        }
        else if ResetPasswordVCValidateObj.txt_repeatPassword.text!.count < 6 || ResetPasswordVCValidateObj.txt_repeatPassword.text!.count > 16 {
            ResetPasswordVCValidateObj.view.makeToast(message: "Confirm Pass should be 6-16 character")
            ResetPasswordVCValidateObj.view.endEditing(true)
            return false
        }else if ResetPasswordVCValidateObj.txt_Password.text! != ResetPasswordVCValidateObj.txt_repeatPassword.text!{
            ResetPasswordVCValidateObj.view.makeToast(message: "Your password and confirm password does not match.")
            return false
        }else{
            return true
        }
    }
    func validateProfile_update_Form(_ editProfileValidateObj:EditProfileView) -> Bool {
        //        if signUpVCValidateObj.profileImg.image == nil{
        //            signUpVCValidateObj.view.makeToast(message: "Please select profile photo.")
        //            signUpVCValidateObj.view.endEditing(true)
        //            return false
        //        }else
        if isBlank(editProfileValidateObj.fullNameTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your full name.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if editProfileValidateObj.fullNameTxtField.text!.count < 3 || editProfileValidateObj.fullNameTxtField.text!.count > 120 {
            editProfileValidateObj.view.makeToast(message: "Full name should be 3-30 character")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.emailTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your email.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isValidEmail(editProfileValidateObj.emailTxtField.text!) {
            editProfileValidateObj.view.makeToast(message: "This is not correct email address")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.hourlyRateTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your hourly rate.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if editProfileValidateObj.hourlyRateTxtField.text == "0" {
            editProfileValidateObj.view.makeToast(message: "Hourly rate could't be zero.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.workingDaysTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your working days.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isValidDays(editProfileValidateObj.workingDaysTxtField.text!) {
            editProfileValidateObj.view.makeToast(message: "Working days could't be zero or grater then seven.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.cityTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please select your address.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.addressLine2TxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your address line 2.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isTextViewBlank(editProfileValidateObj.aboutTxtView) {
            editProfileValidateObj.view.makeToast(message: "Please enter something about you")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    func validateBarProfileupdateForm(_ editProfileValidateObj:BarEditProfileView) -> Bool {
        //        if signUpVCValidateObj.profileImg.image == nil{
        //            signUpVCValidateObj.view.makeToast(message: "Please select profile photo.")
        //            signUpVCValidateObj.view.endEditing(true)
        //            return false
        //        }else
        if isBlank(editProfileValidateObj.fullNameTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your full name.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if editProfileValidateObj.fullNameTxtField.text!.count < 3 || editProfileValidateObj.fullNameTxtField.text!.count > 120 {
            editProfileValidateObj.view.makeToast(message: "Full name should be 3-30 character")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.emailTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your email.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isValidEmail(editProfileValidateObj.emailTxtField.text!) {
            editProfileValidateObj.view.makeToast(message: "This is not correct email address")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.cityTxtField) {
            editProfileValidateObj.view.makeToast(message: "Please select your address.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isBlank(editProfileValidateObj.addressLine2TxtField) {
            editProfileValidateObj.view.makeToast(message: "Please enter your address line 2.")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else if isTextViewBlank(editProfileValidateObj.aboutTxtView) {
            editProfileValidateObj.view.makeToast(message: "Please enter something about you")
            editProfileValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
    //
    func validateAddExperienceForm(_ AddExpValidateObj:AddExperienceView) -> Bool {
        if isBlank(AddExpValidateObj.positionNameTxt) {
            AddExpValidateObj.view.makeToast(message: "Please enter your position name.")
            AddExpValidateObj.view.endEditing(true)
            return false
        }else if AddExpValidateObj.positionNameTxt.text!.count < 3 || AddExpValidateObj.positionNameTxt.text!.count > 120 {
            AddExpValidateObj.view.makeToast(message: "Position name should be 3-30 character")
            AddExpValidateObj.view.endEditing(true)
            return false
        }else if isBlank(AddExpValidateObj.barNameTxt) {
            AddExpValidateObj.view.makeToast(message: "Please enter bar name.")
            AddExpValidateObj.view.endEditing(true)
            return false
        }else if isBlank(AddExpValidateObj.startDateTxt) {
            AddExpValidateObj.view.makeToast(message: "Please select start date.")
            AddExpValidateObj.view.endEditing(true)
            return false
        }else if isBlank(AddExpValidateObj.endDateTxt) {
            if AddExpValidateObj.checkBtn.currentImage != UIImage(named: "checkFilled") {
                AddExpValidateObj.view.makeToast(message: "Please select end date.")
                AddExpValidateObj.view.endEditing(true)
                return false
            }else{
                return true
            }
        }else if AddExpValidateObj.viewModel.isComeFromAdd {
            if AddExpValidateObj.end < AddExpValidateObj.start {
                AddExpValidateObj.endDateTxt.text = ""
                AddExpValidateObj.view.makeToast(message: "start date must be earlier than the end date. ")
                AddExpValidateObj.view.endEditing(true)
                return false
            }else if AddExpValidateObj.end == AddExpValidateObj.start {
                AddExpValidateObj.view.makeToast(message: "start date must be earlier than the end date. ")
                AddExpValidateObj.view.endEditing(true)
                return false
            }else{
                return true
            }
        }else{
            return true
        }
    }
    func ValidateCreatePostForm(_ CreatePostViewValidateObj:CreatePostView) -> Bool {
        if isBlank(CreatePostViewValidateObj.titleTxtField) {
            CreatePostViewValidateObj.view.makeToast(message: "Please enter your post title.")
            CreatePostViewValidateObj.view.endEditing(true)
            return false
        }else if isBlank(CreatePostViewValidateObj.hourlyRateTxtField) {
            CreatePostViewValidateObj.view.makeToast(message: "Please enter your hourly rate.")
            CreatePostViewValidateObj.view.endEditing(true)
            return false
        }else if CreatePostViewValidateObj.hourlyRateTxtField.text == "0" {
            CreatePostViewValidateObj.view.makeToast(message: "Hourly rate could't be zero.")
            CreatePostViewValidateObj.view.endEditing(true)
            return false
        }else if isBlank(CreatePostViewValidateObj.deadlineTxtField) {
            CreatePostViewValidateObj.view.makeToast(message: "Please enter your deadline date.")
            CreatePostViewValidateObj.view.endEditing(true)
            return false
        }else if isBlank(CreatePostViewValidateObj.jobTimeTxtField) {
            CreatePostViewValidateObj.view.makeToast(message: "Please enter your job time and date.")
            CreatePostViewValidateObj.view.endEditing(true)
            return false
        }else if isTextViewBlank(CreatePostViewValidateObj.descriptionTxtView) {
            CreatePostViewValidateObj.view.makeToast(message: "Please enter your job description.")
            CreatePostViewValidateObj.view.endEditing(true)
            return false
        }else{
            return true
        }
    }
}


