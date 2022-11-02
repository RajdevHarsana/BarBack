//
//  BarSearchView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 10/10/22.
//

import UIKit

import UIKit
import Kingfisher

class BarSearchList_cell:UITableViewCell
{
    @IBOutlet weak var img_person: UIImageView!
    @IBOutlet weak var lbl_shiftName: UILabel!
    @IBOutlet weak var lbl_place: UILabel!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var view_tblCell: UIView!
}

class BarSearchView: UIViewController,UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate  {
    
    // MARK: - IB Outlets
    @IBOutlet weak var tbl_searchList: UITableView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var btn_showMap: UIButton!
    @IBOutlet weak var view_baground: UIView!
    @IBOutlet weak var btnClose: UIButton!
    
    var viewModel = BarSearchViewModel()
    var pageNumber = 1
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.btnClose.isHidden = true
        self.viewModel.controller = self
        self.viewModel.updateView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.model.removeAll()
        self.pageNumber = 1
        self.viewModel.searchListRequestAPI(pageNumber: pageNumber, searchTxt: "")
    }
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    // MARK: - button for search on map
    @IBAction func btn_SearchOnMap(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "BarLocationView") as? BarLocationView
        navigate?.viewModel.model.append(contentsOf: self.viewModel.model)
        self.navigationController?.pushViewController(navigate!, animated: true)
    }
    // MARK: - button for side menu
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
    // MARK: - button for search data
    @IBAction func btnSearch(_ sender: UIButton){
        self.txt_search.resignFirstResponder()
        self.viewModel.model.removeAll()
        self.viewModel.searchListRequestAPI(pageNumber: pageNumber, searchTxt: txt_search.text!)
    }
    @IBAction func btnClose(_ sender: UIButton){
        self.txt_search.text = ""
        self.view.endEditing(true)
        self.btnClose.isHidden = true
        self.viewModel.model.removeAll()
        self.viewModel.searchListRequestAPI(pageNumber: pageNumber, searchTxt: txt_search.text!)
    }
    // MARK: - button for filter data
    @IBAction func btnFilter(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "FilterView") as? FilterView
        //        navigate?.viewModel.minPriceRage = self.viewModel.model[0].minPrice ?? 0
        //        navigate?.viewModel.maxPriceRage = self.viewModel.model[0].maxPrice ?? 0
        //        navigate?.delegate = self
        //        navigate?.viewModel.rateSlideminValue = self.viewModel.priceMin
        //        navigate?.viewModel.rateSlidemaxValue = self.viewModel.priceMax
        //        navigate?.viewModel.daysSlideminValue = self.viewModel.dayMin
        //        navigate?.viewModel.daysSlidemaxValue = self.viewModel.dayMax
        //        navigate?.viewModel.shortBy = self.viewModel.sortBy
        //        navigate?.viewModel.isFilterApplied = self.viewModel.apply
        //        navigate?.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(navigate!, animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BarSearchList_cell
        cell.btn_select.roundCorners(.allCorners, radius: 5)
        cell.view_tblCell.roundCorners(.allCorners, radius: 10)
        let profileImgURL = URL(string: self.viewModel.model[indexPath.row].profileImage ?? "")
        cell.img_person.kf.indicatorType = .activity
        cell.img_person.kf.setImage(with: profileImgURL)
        cell.img_person.layer.cornerRadius = cell.img_person.frame.height/2
        cell.img_person.layer.borderColor = #colorLiteral(red: 0.7058823529, green: 0.1921568627, blue: 0.2509803922, alpha: 1)
        cell.img_person.layer.borderWidth = 2
        cell.lbl_shiftName.text = self.viewModel.model[indexPath.row].fullname ?? ""
        cell.lbl_place.text = self.viewModel.model[indexPath.row].aboutMe ?? ""
        //        cell.lbl_Time.text = self.viewModel.model[0].data?.data?[indexPath.row].postedTime ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BarShitDetailView") as? BarShitDetailView
        vc?.userID = self.viewModel.model[indexPath.row].id ?? 0
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
                self.viewModel.searchListRequestAPI(pageNumber: pageNumber, searchTxt: txt_search.text!)
            }else{
                
            }
        }
    }
    
}
// MARK: - filter protocol delegate
extension BarSearchView: FilterPrototcolDelegate {
    func filterData(minPrice: String, maxPrice: String, minDays: String, maxDays: String, shortBy: String,isFilterApply:Bool) {
        self.viewModel.priceMin = minPrice
        self.viewModel.priceMax = maxPrice
        self.viewModel.dayMin = minDays
        self.viewModel.dayMax = maxDays
        self.viewModel.sortBy = shortBy
        self.viewModel.apply = isFilterApply
        self.viewModel.model.removeAll()
        self.viewModel.searchListRequestAPI(pageNumber: pageNumber, searchTxt: self.txt_search.text!)
    }
}

// MARK: - side menu protocol delegate
extension BarSearchView: RightMenuDelegates {
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
// MARK: - apply job protocol delegate
extension BarSearchView: ApplyJobProtocol {
    func jobApply(isApplied: Bool, Index: Int) {
        let index = IndexPath(row: Index, section: 0)
        let cell = tbl_searchList.cellForRow(at: index) as? SearchList_cell
        if isApplied != true{
            cell?.btn_select.setTitle("Select", for: .normal)
        }else{
            cell?.btn_select.setTitle("Applied", for: .normal)
        }
    }
}

extension BarSearchView: UITextFieldDelegate {
    //MARK: - Text Feild Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.btnClose.isHidden = false
        let maxLength = 100
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length <= 0 {
            self.btnClose.isHidden = true
        }else{
            self.btnClose.isHidden = false
        }
        return newString.length <= maxLength
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty{
            self.btnClose.isHidden = true
        }else{
            self.btnClose.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.btnClose.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
