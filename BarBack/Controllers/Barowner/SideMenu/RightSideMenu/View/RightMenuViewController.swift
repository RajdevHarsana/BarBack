//
//  RightMenuViewController.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import UIKit

protocol RightMenuDelegates {
    func sideMenuNavigation(controllerView:UIViewController)
}

class RightMenuViewController: UIViewController {

    //MARK: - IBOutlates
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var ProfileImgView: UIImageView!
    @IBOutlet weak var UserNameLbl: UILabel!
    
    var viewModel = RightMenuViewModel()
    var delegate : RightMenuDelegates? = nil
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tapView = UITapGestureRecognizer(target: self, action: #selector(didTapDismis))
        self.backView.addGestureRecognizer(tapView)
    }
    
    @objc func didTapDismis(){
        dismissDetail()
    }
    
}

extension RightMenuViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RightMenuCell" ,for: indexPath) as! RightMenuCell
        cell.nameLbl.text = self.viewModel.menuItems[indexPath.row]
        return cell
    }
    //MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismissDetail()
        if indexPath.row == 0{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "BarSearchView") as! BarSearchView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 1{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "BarUserProfileView") as! BarUserProfileView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 2{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "MessageView") as! MessageView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 3{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "MyShiftsView") as! MyShiftsView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 4{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "BarSettingView") as! BarSettingView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }
    }
}
