//
//  MessageView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 14/09/22.
//

import UIKit

class MessageListcell:UITableViewCell
{
    @IBOutlet weak var img_person: UIImageView!
    @IBOutlet weak var lbl_shiftName: UILabel!
    @IBOutlet weak var lbl_place: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var view_tblCell: UIView!
    
}

class MessageView: UIViewController {
    // MARK: - IB Outlets
    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var view_baground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view_baground.roundCorners([.topLeft, .topRight], radius: 16)
    }
    
    
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
        //           self.dismiss(animated: true)
    }
    
    // MARK: - button for search on map
    @IBAction func btnSideMenu(_ sender: UIButton){
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

extension MessageView: UITableViewDelegate,UITableViewDataSource{
    
    // MARK: - Table view deligates and datasource
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageListcell
        cell.img_person.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        cell.img_person.layer.borderWidth = 2
        cell.img_person.layer.cornerRadius = cell.img_person.frame.height/2
        cell.img_person.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        
        cell.view_tblCell.layer.cornerRadius = 8
        cell.view_tblCell.layer.masksToBounds = true
        
        return cell
    }
}

extension MessageView: SideMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
}
