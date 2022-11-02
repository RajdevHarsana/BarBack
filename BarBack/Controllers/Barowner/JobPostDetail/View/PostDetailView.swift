//
//  PostDetailView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 13/10/22.
//

import UIKit
import Kingfisher
import CloudKit

class PostListCell: UITableViewCell{
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var shiftName: UILabel!
    @IBOutlet weak var describeLbl: UILabel!
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var viewTblCell: UIView!
}

class PostDetailView: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var jobImg : UIImageView!
    @IBOutlet weak var jobTitle : UILabel!
    @IBOutlet weak var jobBarName : UILabel!
    @IBOutlet weak var jobPostDate : UILabel!
    @IBOutlet weak var jobRate : UILabel!
    @IBOutlet weak var jobLocation : UILabel!
    @IBOutlet weak var jobJoinDate : UILabel!
    @IBOutlet weak var jobTimeing : UILabel!
    @IBOutlet weak var jobDiscription : UILabel!
    @IBOutlet weak var editBtn : UIButton!
    @IBOutlet weak var listTblView: UITableView!
    @IBOutlet weak var applicationsLbl : UILabel!

    var viewModel = PostDetailViewModel()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.isHidden = true
        self.viewModel.controller = self
        self.viewBackground.roundCorners([.topLeft, .topRight], radius: 16)
        self.viewModel.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.model.removeAll()
        self.viewModel.listDataModel.removeAll()
        self.viewModel.postDetailRequestAPI()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func rightMenuBtnAction(_ sender: UIButton){
        self.toggleRightMenu()
    }

    @IBAction func editBtnAction(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreatePostView") as? CreatePostView
        vc?.viewModel.isComeFromEdit = true
        vc?.viewModel.postId = String(self.viewModel.model[0].data?.id ?? 0)
        vc?.viewModel.titleName = self.viewModel.model[0].data?.title ?? ""
        vc?.viewModel.hourlyRate = String(self.viewModel.model[0].data?.hourlyRate ?? 0)
        vc?.viewModel.deadline = self.viewModel.model[0].data?.deadline ?? ""
        vc?.viewModel.jobTime = self.viewModel.model[0].data?.jobTime ?? ""
        vc?.viewModel.description = self.viewModel.model[0].data?.dataDescription ?? ""
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension PostDetailView: UITableViewDelegate,UITableViewDataSource {
    // MARK: - Table view deligates and datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 153
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.model.count > 0 {
            if self.viewModel.listDataModel.count > 0{
                return self.viewModel.listDataModel.count
            }else{
                return 0
            }
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostListCell
        cell.viewTblCell.layer.cornerRadius = 10
        cell.viewTblCell.layer.masksToBounds = true
        let profileImgURL = URL(string: self.viewModel.listDataModel[indexPath.row].user?.profileImage ?? "")
        cell.imgPerson.kf.indicatorType = .activity
        cell.imgPerson.kf.setImage(with: profileImgURL)
        cell.imgPerson.layer.cornerRadius = cell.imgPerson.frame.height/2
        cell.imgPerson.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        cell.imgPerson.layer.borderWidth = 2
//        cell.lbl_place.text = "\(self.viewModel.model[0].data?.userAddress?.city ?? "")" + ", " + "\(self.viewModel.model[0].data?.userAddress?.state ?? "")"
        cell.shiftName.text = self.viewModel.listDataModel[indexPath.row].user?.fullname ?? ""
        cell.acceptBtn.tag = indexPath.row
        cell.acceptBtn.addTarget(self, action: #selector(acceptBtn), for: .touchUpInside)
        cell.declineBtn.tag = indexPath.row
        cell.declineBtn.addTarget(self, action: #selector(declineBtn), for: .touchUpInside)
        let action = self.viewModel.listDataModel[indexPath.row].action ?? ""
        if action == "Pending" {
            cell.acceptBtn.setTitle("Accept", for: .normal)
            cell.declineBtn.setTitle("Decline", for: .normal)
        }else if action == "Accept" {
            cell.acceptBtn.setTitle("Accepted", for: .normal)
            cell.declineBtn.setTitle("Decline", for: .normal)
            cell.declineBtn.setTitleColor(UIColor.white, for: .normal)
        }else if action == "Reject" {
            cell.acceptBtn.setTitle("Accept", for: .normal)
            cell.acceptBtn.setTitleColor(UIColor.white, for: .normal)
            cell.declineBtn.setTitle("Declined", for: .normal)
        }else{
            
        }
        
        return cell
    }
    // MARK: - accept button action
    @objc func acceptBtn(_ sender: UIButton){
        let jobId = self.viewModel.listDataModel[sender.tag].id ?? 0
        let action = self.viewModel.listDataModel[sender.tag].action ?? ""
        if action == "Pending" {
            self.viewModel.requestJobAPI(id: jobId, action: "Accept")
        }else{
            
        }
    }
    // MARK: - accept button action
    @objc func declineBtn(_ sender: UIButton){
        let jobId = self.viewModel.listDataModel[sender.tag].id ?? 0
        let action = self.viewModel.listDataModel[sender.tag].action ?? ""
        if action == "Pending" {
            self.viewModel.requestJobAPI(id: jobId, action: "Reject")
        }else{
            
        }
    }
}

extension PostDetailView: RightMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
    func toggleRightMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RightMenuViewController") as! RightMenuViewController
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
