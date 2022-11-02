//
//  DreamsBarVC.swift
//  BarBack
//
//  Created by Mac on 09/09/22.
//

import UIKit
import Kingfisher

class dreamsbar_cell:UITableViewCell
{
    @IBOutlet weak var img_person: UIImageView!
    @IBOutlet weak var lbl_shiftName: UILabel!
    @IBOutlet weak var lbl_place: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var view_tblCell: UIView!
}


class DreamsBarVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tbl_dreamsbarList: UITableView!
    @IBOutlet weak var view_baground: UIView!
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barImg: UIImageView!
    
    var viewModel = DreamBarViewModel()
    var pageNumber = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
        
        self.view_baground.roundCorners([.topLeft, .topRight], radius: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.model.removeAll()
        self.pageNumber = 1
        self.viewModel.dreamBarRequestAPI(pageNumber: pageNumber)
    }
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    // MARK: - button for side menu
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
    
    // MARK: - Table view deligates and datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.model.count > 0 {
            if self.viewModel.model.count > 0{
                return self.viewModel.model.count
            }else{
                return 0
            }
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dreamsbar_cell
        cell.btn_select.roundCorners(.allCorners, radius: 5)
        cell.view_tblCell.roundCorners(.allCorners, radius: 10)
        let profileImgURL = URL(string: self.viewModel.model[indexPath.row].user?.profileImage ?? "")
        cell.img_person.kf.indicatorType = .activity
        cell.img_person.kf.setImage(with: profileImgURL)
        cell.img_person.layer.cornerRadius = cell.img_person.frame.height/2
        cell.lbl_shiftName.text = self.viewModel.model[indexPath.row].title ?? ""
        cell.img_person.layer.cornerRadius = cell.img_person.frame.height/2
        cell.img_person.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        cell.img_person.layer.borderWidth = 2
        cell.lbl_Time.text = self.viewModel.model[indexPath.row].postedTime ?? ""
        cell.lbl_place.text = "\(self.viewModel.model[indexPath.row].user?.userAddress?.city ?? "")" + ", " + "\(self.viewModel.model[indexPath.row].user?.userAddress?.state ?? "")"
        let isApplied = self.viewModel.model[indexPath.row].isApplied
        if isApplied != true{
            cell.btn_select.setTitle("Select", for: .normal)
            cell.btn_select.backgroundColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        }else{
            cell.btn_select.setTitle("Applied", for: .normal)
            cell.btn_select.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        cell.btn_select.tag = indexPath.row
        cell.btn_select.addTarget(self, action: #selector(selectBtn), for: .touchUpInside)
        
        return cell
    }
    
    // MARK: - select button action
    @objc func selectBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShiftDetailView") as? ShiftDetailView
        vc?.viewModel.jobId = self.viewModel.model[sender.tag].id ?? 0
        vc?.viewModel.createDate = self.viewModel.model[sender.tag].createdAt ?? ""
        vc?.viewModel.isApplied = self.viewModel.model[sender.tag].isApplied ?? false
        vc?.viewModel.selectedIndex = sender.tag
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: - scrollView delegate for pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            if viewModel.lastPage != pageNumber {
                self.isLoading = true
                self.pageNumber += 1
                self.viewModel.dreamBarRequestAPI(pageNumber: pageNumber)
            }else{
                
            }
        }
    }
    
}


extension DreamsBarVC: SideMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
    func toggleRightMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
        vc.delegate = self
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: false)
    }
}
