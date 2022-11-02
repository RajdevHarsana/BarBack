//
//  BarJobDetailView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 15/09/22.
//

import UIKit
import Kingfisher

class BarJobDetailCell: UITableViewCell {
    @IBOutlet weak var img_person: UIImageView!
    @IBOutlet weak var lbl_shiftName: UILabel!
    @IBOutlet weak var lbl_place: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var view_tblCell: UIView!
}

class BarJobDetailView: UIViewController {
    
    @IBOutlet weak var listTblView: UITableView!
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barImage: UIImageView!
    @IBOutlet weak var barCoverImg: UIImageView!
    @IBOutlet weak var barAbout: UILabel!
    @IBOutlet weak var barLocation: UILabel!
    @IBOutlet weak var barWorkingHours: UILabel!
    @IBOutlet weak var barWorkingDays: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var barAboutView: UIView!
    @IBOutlet weak var barDetailView: UIView!
    
    
    var viewModel = BarDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
        
        self.barImage.layer.cornerRadius = self.barImage.frame.height / 2
        self.scrollView.layer.cornerRadius = 16
        self.mainView.layer.cornerRadius = 16
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.model.removeAll()
        self.viewModel.barDetailRequestAPI()
    }
    // MARK: - IB Actions
         // MARK: - button for back navigation
       @IBAction func btn_back(_ sender: UIButton){
           navigationController?.popViewController(animated: true)
//           self.dismiss(animated: true)
         }
    
    // MARK: - button for search on map
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
    
    @IBAction func showMoreBtn(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigate = storyboard.instantiateViewController(withIdentifier: "DreamsBarVC") as! DreamsBarVC
        navigate.viewModel.userId = self.viewModel.userID
        navigate.viewModel.image = self.viewModel.model[0].data?.profileImage ?? ""
        navigate.viewModel.name = self.viewModel.model[0].data?.fullname ?? ""
        self.navigationController?.pushViewController(navigate, animated: true)
//           self.dismiss(animated: true)
      }
}

extension BarJobDetailView: UITableViewDelegate,UITableViewDataSource {
    // MARK: - Table view deligates and datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.model.count > 0 {
            if self.viewModel.model[0].data?.jobs?.count ?? 0 > 0{
                return self.viewModel.model[0].data?.jobs?.count ?? 0
            }else{
                return 0
            }
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarJobDetailCell
        
        cell.btn_select.layer.cornerRadius = 5
        cell.btn_select.layer.masksToBounds = true
        
        cell.view_tblCell.layer.cornerRadius = 10
        cell.view_tblCell.layer.masksToBounds = true
        let profileImgURL = URL(string: self.viewModel.model[0].data?.profileImage ?? "")
        cell.img_person.kf.indicatorType = .activity
        cell.img_person.kf.setImage(with: profileImgURL)
        cell.img_person.layer.cornerRadius = cell.img_person.frame.height/2
        cell.img_person.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        cell.img_person.layer.borderWidth = 2
        cell.lbl_place.text = "\(self.viewModel.model[0].data?.userAddress?.city ?? "")" + ", " + "\(self.viewModel.model[0].data?.userAddress?.state ?? "")"
        cell.lbl_shiftName.text = self.viewModel.model[0].data?.jobs?[indexPath.row].title ?? ""
        
        let isApplied = self.viewModel.model[0].data?.jobs?[indexPath.row].isApplied
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
        vc?.viewModel.jobId = self.viewModel.model[0].data?.jobs?[sender.tag].id ?? 0
        vc?.viewModel.isApplied = self.viewModel.model[0].data?.jobs?[sender.tag].isApplied ?? false
        vc?.viewModel.selectedIndex = sender.tag
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension BarJobDetailView: SideMenuDelegates {
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
