//
//  EditProfileView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import UIKit
import GooglePlaces
//import GooglePlacePicker

protocol EditProfileProtocolDelegate {
    func editProfileData()
}

class EditProfileView: UIViewController, ScrollViewKeyboardDelegate {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var hourlyRateTxtField: UITextField!
    @IBOutlet weak var workingDaysTxtField: UITextField!
    @IBOutlet weak var addressLine1TxtField: UITextField!
    @IBOutlet weak var addressLine2TxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var stateTxtField: UITextField!
    @IBOutlet weak var zipCodeTxtField: UITextField!
    @IBOutlet weak var aboutTxtView: UITextView!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet var scrollViewOutlet: UIScrollView?
    @IBOutlet weak var selectBtn: UIButton!
    
    var scrollView: UIScrollView?
    
    var imageType = String()
    var delegate : EditProfileProtocolDelegate? = nil
    
    var viewModel = EditProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.viewModel.controller = self
        self.viewModel.updateView()
        self.viewModel.updateUI()
        scrollView = scrollViewOutlet
        scrollView?.isScrollEnabled = true
        self.registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    deinit {
        self.unregisterKeyboardNotifications()
    }
    
    @IBAction func selectImgBtnAction(_ sender:UIButton){
        self.imageType = "profileImage"
        let Picker = UIImagePickerController()
        Picker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: "Choose your source", preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .camera
            self.present(Picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .photoLibrary
            self.present(Picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func selectCoverImgBtnAction(_ sender:UIButton){
        self.imageType = "coverImage"
        let Picker = UIImagePickerController()
        Picker.delegate = self
        
        let actionSheet = UIAlertController(title: nil, message: "Choose your source", preferredStyle: UIAlertController.Style.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .camera
            self.present(Picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            
            Picker.sourceType = .photoLibrary
            self.present(Picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveBtnAction(_ sender:UIButton){
        if ValidationClass().validateProfile_update_Form(self){
            self.viewModel.editProfileApi(fullName: fullNameTxtField.text!, email: emailTxtField.text!, about: aboutTxtView.text!, address1: addressLine1TxtField.text!, address2: addressLine2TxtField.text!, city: cityTxtField.text!, state: stateTxtField.text!, zipCode: zipCodeTxtField.text!, image: viewModel.profileImage, coverImage: viewModel.coverImage,hourlyRate: hourlyRateTxtField.text!,workingDays: workingDaysTxtField.text!)
        }
    }
    
    @IBAction func backBtnAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditProfileView: UITextFieldDelegate {
    //MARK: - Text Feild Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fullNameTxtField {
            let maxLength = 50
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == emailTxtField {
            let maxLength = 50
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.addressLine1TxtField{
            self.addressLine1TxtField.resignFirstResponder()
            let acController = GMSAutocompleteViewController()
            acController.delegate = self
            present(acController, animated: true, completion: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        textField.layer.borderColor = UIColor(named: "whiteFive")?.cgColor
        //        textField.layer.borderWidth = 1.0
        //        textField.layer.cornerRadius = 8
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Text View Delegates
extension EditProfileView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.aboutLbl.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.aboutLbl.isHidden = false
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxLength = 300
        let currentString: NSString = (aboutTxtView.text ?? "") as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: text) as NSString
        return newString.length <= maxLength
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool{
        textView.resignFirstResponder()
        return true
    }
}

extension EditProfileView: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    //MARK:- Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: {
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
                if self.imageType == "profileImage"{
                    self.profileImg.image = image
                    self.viewModel.profileImage = image
                }else{
                    self.coverImg.image = image
                    self.viewModel.coverImage = image
                }
                
            }else{
                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                    if self.imageType == "profileImage"{
                        self.profileImg.image = image
                        self.viewModel.profileImage = image
                    }else{
                        self.coverImg.image = image
                        self.viewModel.coverImage = image
                    }
                }
            }
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileView: GMSAutocompleteViewControllerDelegate {
    //MARK:- Google Place Delegate
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        let lat = place.coordinate.latitude
        let lon = place.coordinate.longitude
        self.viewModel.placeLat = place.coordinate.latitude
        self.viewModel.placeLong = place.coordinate.longitude
        let CurrentLat = String(lat)
        let CurrentLong = String(lon)
        Config().AppUserDefaults.set(CurrentLat, forKey: "LAT")
        Config().AppUserDefaults.set(CurrentLong, forKey: "LONG")
        print("lat lon",lat,lon)
        self.cityTxtField.text = place.name
        //        let titleName = place.formattedAddress ?? ""
        var Street = String()
        var Route = String()
        var city = String()
        var state = String()
        var country = String()
        //        let address = place.addressComponents
        print(place)
        print(place.addressComponents ?? "")
        if place.addressComponents != nil {
            for addressComponent in (place.addressComponents)! {
                for type in (addressComponent.types){
                    
                    switch(type){
                        
                    case "street_number":
                        Street = addressComponent.name
                    case "route":
                        Route = addressComponent.name
                    case "locality":
                        city = addressComponent.name
                        self.cityTxtField.text = city
                    case "administrative_area_level_1":
                        state = addressComponent.name
                        self.stateTxtField.text = state
                    case "country":
                        country = addressComponent.name 
                        self.viewModel.country = country
                        let countyCode = addressComponent.shortName ?? ""
                        self.viewModel.countryCode = getCountryCallingCode(countryRegionCode: countyCode)
                    case "postal_code":
                        let zipCode = addressComponent.name
                        self.zipCodeTxtField.text = zipCode
                    default:
                        break
                    }
                }
            }
        }
        
        
        var address = String()
        address = city + ", " + state
        if Street == ""{
            self.addressLine1TxtField.text = Route
            address = Route+", "+city+", "+state+", "+country
        }else if Route == ""{
            self.addressLine1TxtField.text = ""
            address = Street+", "+city+", "+state+", "+country
        }else if Street == "" || Route == "" {
            address = city + ", " + state + ", " + country
        }else{
            self.addressLine1TxtField.text = Street + ", " + Route
            address = Street+", "+Route+", "+city+", "+state+", "+country
        }
        Config().AppUserDefaults.set(address, forKey: "TITLE")
//        self.addressTxtField.text = address
        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    
    func getCountryCallingCode(countryRegionCode:String)->String{

            let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
            let countryDialingCode = prefixCodes[countryRegionCode]
            return countryDialingCode!

    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}
