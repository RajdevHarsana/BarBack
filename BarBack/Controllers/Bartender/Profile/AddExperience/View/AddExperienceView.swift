//
//  AddExperienceView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import UIKit

protocol AddExperienceProtocolDelegate {
    func experienceData(update:Bool)
}

class AddExperienceView: UIViewController {
    
    @IBOutlet weak var positionNameTxt: UITextField!
    @IBOutlet weak var barNameTxt: UITextField!
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    let datePicker = UIDatePicker()
    
    var dateType = String()
    var viewModel = AddExperienceViewModel()
    var start = Date()
    var end = Date()
    var delegate : AddExperienceProtocolDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
        self.showDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rightBtnAction(_ sender: UIButton){
        if ValidationClass().validateAddExperienceForm(self){
            if self.checkBtn.currentImage != UIImage(named: "checkFilled") {
                if self.viewModel.isComeFromAdd {
                    let dateComponentsFormatter = DateComponentsFormatter()
                    let result = dateComponentsFormatter.difference(from: start, to: end)!
                    self.viewModel.totalExp = viewModel.changeDateFormate(item: result)
                    print(self.viewModel.totalExp)
                }else{
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let startdate = dateFormatter.date(from: self.viewModel.startDate)!
                    let enddate = dateFormatter.date(from: self.viewModel.endDate)!
                    let dateComponentsFormatter = DateComponentsFormatter()
                    let result = dateComponentsFormatter.difference(from: startdate, to: enddate)!
                    self.viewModel.totalExp = viewModel.changeDateFormate(item: result)
                    print(self.viewModel.totalExp)
                }
            }else{
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let startdate = dateFormatter.date(from: self.viewModel.startDate)!
                let dateComponentsFormatter = DateComponentsFormatter()
                let result = dateComponentsFormatter.difference(from: startdate, to: end)!
                self.viewModel.totalExp = viewModel.changeDateFormate(item: result)
                print(self.viewModel.totalExp)
            }
            
            self.viewModel.updateAddExrerienceAPi()
        }
    }
    
    // MARK: - button for perefernce
    @IBAction func btnCheck(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        if self.checkBtn.currentImage != UIImage(named: "checkFilled") {
            self.checkBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            self.endDateTxt.isUserInteractionEnabled = false
            self.viewModel.endDate = ""
            self.viewModel.totalExp = ""
            self.endDateTxt.text = ""
            self.viewModel.isCheck = 1
        }else{
            self.checkBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            self.endDateTxt.isUserInteractionEnabled = true
            self.viewModel.isCheck = 0
        }
    }
    
    func showDatePicker(){
        //Formate Date
        let currentDate = Date()
        let gregorian = NSCalendar(calendarIdentifier: .gregorian)
        var components = DateComponents()
        
        components.year = -110
        let minDate = gregorian?.date(byAdding: components, to: currentDate, options: NSCalendar.Options(rawValue: 0))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.minimumDate = minDate
        datePicker.maximumDate = currentDate
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        startDateTxt.inputAccessoryView = toolbar
        startDateTxt.inputView = datePicker
        endDateTxt.inputAccessoryView = toolbar
        endDateTxt.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        
        if dateType == "start"{
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YYYY"
            start = datePicker.date
            startDateTxt.text = formatter.string(from: datePicker.date)
            formatter.dateFormat = "yyyy-MM-dd"
            self.viewModel.startDate = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/YYYY"
            end = datePicker.date
            endDateTxt.text = formatter.string(from: datePicker.date)
            formatter.dateFormat = "yyyy-MM-dd"
            self.viewModel.endDate = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
        
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }

}

extension AddExperienceView : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == positionNameTxt {
            let maxLength = 20
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == barNameTxt {
            let maxLength = 50
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            return true
        }
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Text Feild Delegates
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == startDateTxt {
            self.dateType = "start"
            self.view.endEditing(true)
            return true
        }else if textField == endDateTxt {
            self.dateType = "end"
            self.view.endEditing(true)
            return true
        }else{
            return true
        }
    }
}

extension DateComponentsFormatter {
    func difference(from fromDate: Date, to toDate: Date) -> String? {
        self.allowedUnits = [.year,.month,.weekOfMonth,.day]
        self.maximumUnitCount = 2
        self.unitsStyle = .full
        return self.string(from: fromDate, to: toDate)
    }
}
