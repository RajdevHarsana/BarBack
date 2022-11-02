//
//  MyShiftsView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import UIKit
import Kingfisher

class MyShiftsCell:UITableViewCell
{
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblShiftName: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewTblCell: UIView!
}

class MyShiftsView: UIViewController {
    
    @IBOutlet weak var myShiftListTblView: UITableView!
    @IBOutlet weak var viewBaground: UIView!
    @IBOutlet weak var postBtn: UIButton!
    
    var viewModel = MyShiftsViewModel()
    var pageNumber = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewBaground.roundCorners([.topLeft, .topRight], radius: 16)
        self.postBtn.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.model.removeAll()
        self.pageNumber = 1
        self.viewModel.myShiftsRequestAPI(pageNumber: pageNumber)
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
    
    @IBAction func postBtn(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "CreatePostView") as! CreatePostView
        self.navigationController?.pushViewController(navigate, animated: true)
    }
}
extension MyShiftsView: UITableViewDelegate,UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyShiftsCell
        let profileImgURL = URL(string: self.viewModel.model[indexPath.row].user?.profileImage ?? "")
        cell.imgPerson.kf.indicatorType = .activity
        cell.imgPerson.kf.setImage(with: profileImgURL)
        cell.lblShiftName.text = self.viewModel.model[indexPath.row].title ?? ""
        cell.imgPerson.layer.cornerRadius = cell.imgPerson.frame.height/2
        cell.imgPerson.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        cell.imgPerson.layer.borderWidth = 2
        cell.lblTime.text = self.viewModel.model[indexPath.row].postedTime ?? ""
        cell.lblPlace.text = "\(self.viewModel.model[indexPath.row].user?.userAddress?.city ?? "")" + ", " + "\(self.viewModel.model[indexPath.row].user?.userAddress?.state ?? "")"
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(editBtn), for: .touchUpInside)
        cell.viewTblCell.layer.cornerRadius = 10
        return cell
    }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PostDetailView") as? PostDetailView
            vc?.viewModel.jobId = self.viewModel.model[indexPath.row].id ?? 0
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
                    self.viewModel.myShiftsRequestAPI(pageNumber: pageNumber)
                }else{
                    
                }
            }
        }
        // MARK: - select button action
        @objc func editBtn(_ sender: UIButton){
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreatePostView") as? CreatePostView
            vc?.viewModel.isComeFromEdit = true
            vc?.viewModel.postId = String(self.viewModel.model[sender.tag].id ?? 0)
            vc?.viewModel.titleName = self.viewModel.model[sender.tag].title ?? ""
            vc?.viewModel.hourlyRate = String(self.viewModel.model[sender.tag].hourlyRate ?? 0)
            vc?.viewModel.deadline = self.viewModel.model[sender.tag].deadline ?? ""
            vc?.viewModel.jobTime = self.viewModel.model[sender.tag].jobTime ?? ""
            vc?.viewModel.description = self.viewModel.model[sender.tag].datumDescription ?? ""
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
    
    extension MyShiftsView: RightMenuDelegates {
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
