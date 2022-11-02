//
//  SkillsView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import UIKit
import Foundation

class SkillesCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
}

class SkillsView: UIViewController {
    
    @IBOutlet weak var skillsTblView: UITableView!
    
    var viewModel = SkillsViewModel()
    var idArray = [String]()
    var nameArray = [String]()
    var idString = String()
    var delegate : SkillProtocolDelegate? = nil
    var skillsArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.getSkillsAPI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    // MARK: - button for side menu
    @IBAction func btnRight(_ sender: UIButton){
        let stringRepresentation = idArray.joined(separator: ",")
        self.idString = stringRepresentation
        if idString != ""{
            self.viewModel.updateSkillsAPI()
        }else{
            self.view.makeToast(message: "Please select Skills")
        }
        
    }
    
}

extension SkillsView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.model.count > 0 {
            if self.viewModel.model[0].data?.count ?? 0 > 0 {
                return self.viewModel.model[0].data?.count ?? 0
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SkillesCell
        cell.nameLbl.text = self.viewModel.model[0].data?[indexPath.row].title ?? ""
        cell.selectBtn.tag = indexPath.row
        cell.selectBtn.addTarget(self, action: #selector(selectBtnAction), for: .touchUpInside)
        let id = String(self.viewModel.model[0].data?[indexPath.row].id ?? 0)
        if self.skillsArray.contains(id){
            cell.selectBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
        }else{
            cell.selectBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
        }
        return cell
    }
    
    @objc func selectBtnAction(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        let index = IndexPath(row: sender.tag, section: 0)
        let cell = skillsTblView.cellForRow(at: index) as? SkillesCell
        if cell?.selectBtn.currentImage != UIImage(named: "checkFilled"){
            cell?.selectBtn.setImage(UIImage(named: "checkFilled"), for: .normal)
            let id = String(self.viewModel.model[0].data?[sender.tag].id ?? 0)
            self.idArray.append(id)
            print(self.idArray)
        }else{
            cell?.selectBtn.setImage(UIImage(named: "unCheckBox"), for: .normal)
            let id = String(self.viewModel.model[0].data?[sender.tag].id ?? 0)
            let valueID = idArray.firstIndex(of: id)
            self.idArray.remove(at: valueID!)
            print(self.idArray)
        }
    }
    
}

protocol SkillProtocolDelegate {
    func skillData(skills:Bool)
}
