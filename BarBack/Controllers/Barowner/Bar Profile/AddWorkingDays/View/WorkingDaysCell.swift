//
//  WorkingDaysCell.swift
//  BarBack
//
//  Created by Rajesh gurjar on 19/10/22.
//

import UIKit

class WorkingDaysCell: UITableViewCell {
    @IBOutlet weak var weekView:UIView!
    @IBOutlet weak var btnOpneingHours:UIButton!
    @IBOutlet weak var lblhours:UILabel!
    @IBOutlet weak var topConst: NSLayoutConstraint!
    @IBOutlet weak var monFrom: UITextField!
    @IBOutlet weak var monTo: UITextField!
    @IBOutlet weak var lblClosed: UILabel!
    fileprivate let pickerView1 = ToolbarPickerView()
    var tbl:UITableView?
    var weekModal:WeekendModal?
    var type = 0
    var timeArr = ["00","01","02","03","04","05","06","07","08","09", "10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    var minArr = ["00","01","02","03","04","05","06","07","08","09", "10","11","12","13","14","15","16","17","18","19","20","21","22","23","24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    var amPmArr = ["am","pm"]
    var comp = 0
    var hrs = ""
    var mins = ""
    var hrs2 = ""
    var mins2 = ""
    var amPm = ""
    var amPm2 = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        monFrom.setLeftPaddingPoints(15)
        monTo.setLeftPaddingPoints(15)
        monFrom.delegate = self
        monTo.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    func configDate(table:UITableView){
        tbl = table

            self.monFrom.inputView = self.pickerView1
            self.monFrom.inputAccessoryView = self.pickerView1.toolbar
            self.pickerView1.dataSource = self
            self.pickerView1.delegate = self
            self.pickerView1.toolbarDelegate = self
            self.pickerView1.reloadAllComponents()

            self.monTo.inputView = self.pickerView1
            self.monTo.inputAccessoryView = self.pickerView1.toolbar

            self.pickerView1.reloadAllComponents()
        }
       
}
extension WorkingDaysCell: UIPickerViewDelegate,UITextFieldDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)  -> Int {
        if component == 0{
            return timeArr.count
        }else if component == 1{
            return minArr.count
        }else{
            return amPmArr.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)  ->  String? {
        comp = component
        if component == 0{
            if type == 0{
                hrs = timeArr[row]
                print(hrs)
            }
            else{
                hrs2 = timeArr[row]
                print(hrs2)
            }
            return timeArr[row]
            
        }else if component == 1{
            if type == 0{
                mins = minArr[row]
                print(mins)
            }
            else{
                mins2 = minArr[row]
                print(mins2)
            }
            return minArr[row]
        }else {
            if type == 0{
                amPm = amPmArr[row]
                print(amPm)
            }
            else{
                amPm2 = amPmArr[row]
                print(amPm)
            }
            return amPmArr[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            if type == 0{
                hrs = timeArr[row]
                print(hrs)
            }
            else{
                hrs2 = timeArr[row]
                print(hrs2)
            }
            
        }else if component == 1{
            if type == 0{
                mins = minArr[row]
                print(mins)
            }
            else{
                mins2 = minArr[row]
                print(mins2)
            }
        }else{
            if type == 0{
                amPm = amPmArr[row]
                print(amPm)
            }
            else{
                amPm2 = amPmArr[row]
                print(amPm)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return CGFloat(50.0)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
        if textField == monFrom{
            type = 0
           
        }else if textField == monTo{
            type = 1
           
        }
            return true
        
    }
    
}
extension WorkingDaysCell:ToolbarPickerViewDelegate{
    func didTapDone() {
        if type == 0 {
            
            let row = self.pickerView1.selectedRow(inComponent: 0)
            self.pickerView1.selectRow(row, inComponent: 0, animated: false)
             
            weekModal?.dateFrom = "\(hrs)" + ":" + "\(mins)" + " \(amPm)"
            
            tbl?.reloadData()
            self.monFrom.resignFirstResponder()
        }else {
            
            let row = self.pickerView1.selectedRow(inComponent: 0)
            self.pickerView1.selectRow(row, inComponent: 0, animated: false)
            weekModal?.dateTo = "\(hrs2)" + ":" + "\(mins2)" + " \(amPm2)"
            
            tbl?.reloadData()
            self.monFrom.resignFirstResponder()
        }
        
        
    }
    
    func didTapCancel() {
        if type == 0 {
            self.monFrom.resignFirstResponder()
        }else {
            self.monTo.resignFirstResponder()
        }
        
        
    }
    
}
