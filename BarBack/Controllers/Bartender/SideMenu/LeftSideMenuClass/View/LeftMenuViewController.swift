//
//  LeftMenuViewController.swift
//  DadeSocial
//
//  Created by MAC-27 on 06/04/21.
//

import UIKit

protocol SideMenuDelegates {
    func sideMenuNavigation(controllerView:UIViewController)
}

class LeftMenuViewController: UIViewController {
    
    //MARK: - IBOutlates
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var ProfileImgView: UIImageView!
    @IBOutlet weak var UserNameLbl: UILabel!
    
    var viewModel = SideMenuViewModel()
    var delegate : SideMenuDelegates? = nil
    
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

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: - TableView Datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuCell" ,for: indexPath) as! LeftMenuCell
        cell.nameLbl.text = self.viewModel.menuItems[indexPath.row]
        return cell
    }
    //MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismissDetail()
        if indexPath.row == 0{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 1{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "ProfileView") as! ProfileView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 2{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "MessageView") as! MessageView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 3{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "ShiftRequestView") as! ShiftRequestView
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }else if indexPath.row == 4{
            if delegate != nil {
                let navigate = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
                delegate?.sideMenuNavigation(controllerView: navigate)
            }
        }
        
        //        }else if indexPath.row == 10{
        //            let appearance = SCLAlertView.SCLAppearance(showCloseButton: false)
        //            let alert = SCLAlertView(appearance: appearance)
        //            alert.addButton("YES", backgroundColor: UIColor(red: 246/255, green: 113/255, blue: 46/255, alpha: 1.0)){
        //                Config().AppUserDefaults.removeObject(forKey: "login")
        //                Config().AppUserDefaults.removeObject(forKey: "isLoginEmail")
        //                isLoginEmail = true
        //                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        //                let navigationController = UINavigationController(rootViewController: newViewController)
        //                UIApplication.shared.windows.first?.rootViewController = navigationController
        //                UIApplication.shared.windows.first?.makeKeyAndVisible()
        //            }
        //            alert.addButton("NO", backgroundColor: UIColor(red: 246/255, green: 113/255, blue: 46/255, alpha: 1.0)){
        //                print("NO")
        //            }
        //            alert.showEdit("LOGOUT", subTitle: "Are you sure you want to logout?")
        //
        //        }
    }
}

extension UIViewController{
    func transitionVc(vc: UIView, duration: CFTimeInterval, type: CATransitionSubtype) {
        _ = vc
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        // present(customVcTransition, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
