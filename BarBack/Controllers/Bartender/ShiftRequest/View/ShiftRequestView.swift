//
//  ShiftRequestView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 14/09/22.
//

import UIKit

class ShiftRequestcell:UITableViewCell
{
    @IBOutlet weak var img_person: UIImageView!
    @IBOutlet weak var lbl_shiftName: UILabel!
    @IBOutlet weak var lbl_place: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var view_tblCell: UIView!
}

class ShiftRequestView: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var view_baground: UIView!
    
    var viewModel = MyRequestViewModel()
    var pageNumber = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        
        view_baground.roundCorners([.topLeft, .topRight], radius: 16)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.model.removeAll()
        self.pageNumber = 1
        self.viewModel.myRquestListAPI(pageNumber: pageNumber)
    }
    
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
}

extension ShiftRequestView: UITableViewDelegate,UITableViewDataSource{
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShiftRequestcell
        let profileImgURL = URL(string: self.viewModel.model[indexPath.row].user?.profileImage ?? "")
        cell.img_person.kf.indicatorType = .activity
        cell.img_person.kf.setImage(with: profileImgURL)
        cell.img_person.layer.cornerRadius = cell.img_person.frame.height/2
        cell.img_person.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        cell.img_person.layer.borderWidth = 2
        cell.lbl_shiftName.text = self.viewModel.model[indexPath.row].title ?? ""
        cell.lbl_place.text = dateFormate(value: self.viewModel.model[indexPath.row].createdAt ?? "")
        cell.btn_select.layer.cornerRadius = 8
        cell.btn_select.layer.masksToBounds = true
        cell.btn_select.layer.borderWidth = 1
        cell.btn_select.layer.borderColor = #colorLiteral(red: 0.6498134136, green: 0.660738945, blue: 0.6677950025, alpha: 1)
        cell.btn_select.tag = indexPath.row
        cell.btn_select.addTarget(self, action: #selector(cencelBtn), for: .touchUpInside)
        
        cell.view_tblCell.layer.cornerRadius = 10
        cell.view_tblCell.layer.masksToBounds = true
        
        return cell
    }
    
    @objc func cencelBtn(_ sender: UIButton){
        let logoutAlert = UIAlertController(title: "BarBak", message: "Are you sure want to cancel your job request?", preferredStyle: UIAlertController.Style.alert)
        
        logoutAlert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (action: UIAlertAction!) in
            let jobId = self.viewModel.model[sender.tag].id ?? 0
            self.viewModel.cancelJobAPI(id: jobId,index: sender.tag)
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.present(logoutAlert, animated: true, completion: nil)
        
    }
    
    func dateFormate(value:String) -> String{
        let isoDate = value
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        //
        var finalDate = String()
        if let date = dateFormatter.date(from: isoDate) {
            dateFormatter.dateFormat = "MMM yyyy"
            //Output: Jan 2000
            finalDate = dateFormatter.string(from: date)
            print(dateFormatter.string(from: date))
            print(date)
            return finalDate
        }else{
            return ""
        }
    }
    
    // MARK: - scrollView delegate for pagination
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) && !isLoading {
            if viewModel.lastPage != pageNumber {
                self.isLoading = true
                self.pageNumber += 1
                self.viewModel.myRquestListAPI(pageNumber: pageNumber)
            }else{
                
            }
        }
    }
}

extension ShiftRequestView: SideMenuDelegates {
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
