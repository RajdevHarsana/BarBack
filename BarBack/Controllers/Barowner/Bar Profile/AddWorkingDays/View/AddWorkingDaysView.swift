//
//  AddWorkingDaysView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 16/10/22.
//

import UIKit

enum Weekdays: String {
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
    case sunday = "sunday"
}

class WeekendModal{
    var isSelect = false
    var dateFrom: String?
    var dateTo: String?
    var headerTitle: String?
    init(dateFrom: String?,dateTo: String?,headerTitle: String?) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.headerTitle = headerTitle
    }
}

class AddWorkingDaysView: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var tblWorkingDays: UITableView!
    
    var isHoursSelected = false
    var isHeaderSelected = false
    var weekModal = [WeekendModal]()
    var FromDate = "9:00 pm"
    let daysArr:[String] = ["sunday","monday", "tuesday", "wednesday", "thursday", "friday", "saturday"]
    var isBtnSelect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Monday"))
        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Tuesday"))
        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Wednesday"))
        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Thursday"))
        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Friday"))
        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Saturday"))
        weekModal.append(WeekendModal(dateFrom: "", dateTo: "", headerTitle: "Sunday"))
        self.tblWorkingDays.reloadData()
    }
    
    @IBAction func backBtnClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        print(weekModal.count)
        var count = 0
        _ = weekModal.compactMap { list in
            if list.isSelect == false {
                count = count+1
            }else {
                count = count - 1
            }
        }
        if count == 7 {
            self.view.makeToast(message: "Please select atleast one day.")
            return
        }
        var time1 = [String:Any]()
        var days = [[String:Any]]()
        weekModal.compactMap { list in
            if list.isSelect == true {
                time1 =  ["from_time":list.dateFrom!+":00", "to_time":list.dateTo!+":00"]
               
                days.append(["weekdays":list.headerTitle!,"status": 1,"time":time1] as [String : Any])
                print(days)
            }
            else{
//                days.append(["weekdays":list.headerTitle!,"status": 0,"time":time1] as [String : Any])
//                print(days)
            }
        }
    }

}

extension AddWorkingDaysView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weekModal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tblWorkingDays.dequeueReusableCell(withIdentifier: "cell") as! WorkingDaysCell
            cell.btnOpneingHours.setTitle(" \(weekModal[indexPath.row].headerTitle ?? "")", for: .normal)
            cell.btnOpneingHours.addTarget(self, action: #selector(didTapWeek(_:)), for: .touchUpInside)
            cell.btnOpneingHours.tag = indexPath.row
            cell.monFrom.text = weekModal[indexPath.row].dateFrom
            cell.monTo.text = weekModal[indexPath.row].dateTo
            cell.weekModal = weekModal[indexPath.row]
            cell.configDate(table: self.tblWorkingDays)
            if weekModal[indexPath.row].isSelect == true {
                cell.btnOpneingHours.setImage(#imageLiteral(resourceName: "checkFilled"), for: .normal)
                cell.weekView.isHidden = false
//                cell.lblClosed.isHidden = true
            }else {
                cell.btnOpneingHours.setImage(#imageLiteral(resourceName: "unCheckBox"), for: .normal)
                cell.weekView.isHidden = true
//                cell.lblClosed.isHidden = false
            }
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if weekModal[indexPath.row].isSelect == true {
            return 140
        }else {
            return 80
        }
    }
        
    @objc func didTapWeek(_ sender:UIButton){
        //        sender.isSelected = !sender.isSelected
        
        if weekModal[sender.tag].isSelect == false {
            weekModal[sender.tag].isSelect = true
        }else {
            weekModal[sender.tag].isSelect = false
        }
        
        tblWorkingDays.reloadData()
    }
}
