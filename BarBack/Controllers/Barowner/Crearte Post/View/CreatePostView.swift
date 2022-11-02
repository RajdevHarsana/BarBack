//
//  CreatePostView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 13/10/22.
//

import UIKit

protocol CreatePostProtocolDelegate {
    func CreatePostData(update:Bool)
}

class CreatePostView: UIViewController, ScrollViewKeyboardDelegate {

    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var hourlyRateTxtField: UITextField!
    @IBOutlet weak var deadlineTxtField: UITextField!
    @IBOutlet weak var jobTimeTxtField: UITextField!
    @IBOutlet weak var descriptionTxtView: UITextView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet var scrollViewOutlet: UIScrollView?
    @IBOutlet weak var postBtn: UIButton!
    let datePicker = UIDatePicker()
    
    var dateType = String()
    var viewModel = CreatePostViewModel()
    var delegate : CreatePostProtocolDelegate? = nil
    
    var scrollView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.viewModel.controller = self
        self.viewModel.updateView()
        self.showDatePicker()
        scrollView = scrollViewOutlet
        scrollView?.isScrollEnabled = true
        self.registerKeyboardNotifications()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    @IBAction func backBtnAction(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postBtnAction(_ sender:UIButton){
        if ValidationClass().ValidateCreatePostForm(self){
            self.viewModel.updateJobPostAPi()
        }
        
    }
    
    //MARK: - Date Picker Function
    func showDatePicker(){
        //Formate Date
        let currentDate = Date()
        let gregorian = NSCalendar(calendarIdentifier: .gregorian)
        var components = DateComponents()
        
        components.year = -110
//        let minDate = gregorian?.date(byAdding: components, to: currentDate, options: NSCalendar.Options(rawValue: 0))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = currentDate
//        datePicker.maximumDate = currentDate
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        deadlineTxtField.inputAccessoryView = toolbar
        deadlineTxtField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YYYY"
        deadlineTxtField.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        self.viewModel.deadline = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
}

extension CreatePostView: UITextFieldDelegate {
    //MARK: - Text Feild Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == titleTxtField {
            let maxLength = 50
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == hourlyRateTxtField {
            let maxLength = 5
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == deadlineTxtField {
            self.view.endEditing(true)
            return true
        }else{
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - Text View Delegates
extension CreatePostView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.descriptionLbl.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.descriptionLbl.isHidden = false
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let maxLength = 300
        let currentString: NSString = (descriptionTxtView.text ?? "") as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: text) as NSString
        return newString.length <= maxLength
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool{
        textView.resignFirstResponder()
        return true
    }
}
