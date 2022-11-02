//
//  ProfileView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 14/09/22.
//

import UIKit
import Foundation
import Kingfisher

class WorkExpCell: UITableViewCell {
    @IBOutlet weak var positionName : UILabel!
    @IBOutlet weak var barName : UILabel!
    @IBOutlet weak var dateOfJoinLeave : UILabel!
    @IBOutlet weak var experience : UILabel!
    @IBOutlet weak var editBtn : UIButton!
}
class SkillCollectionCell: UICollectionViewCell {
    @IBOutlet weak var skillName : UILabel!
}
class LanguagesCollectionCell: UICollectionViewCell {
    @IBOutlet weak var languageName : UILabel!
}

class ProfileView: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var aboutUser: UILabel!
    @IBOutlet weak var aboutUserView: UIView!
    @IBOutlet weak var workExpTbl: UITableView!
    @IBOutlet weak var workExpView: UIView!
    @IBOutlet weak var skillsCollection: UICollectionView!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var languageCollection: UICollectionView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var expereincetblViewHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var skillCollectionViewHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var languageViewHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var seeMoreBtn: UIButton!
    @IBOutlet weak var seeMoreBottomConstrant: NSLayoutConstraint!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var editLbl: UILabel!
    @IBOutlet weak var editIcon: UIImageView!
    @IBOutlet weak var editAboutBtn: UIButton!
    @IBOutlet weak var addWorkExpBtn: UIButton!
    @IBOutlet weak var editSkillBtn: UIButton!
    @IBOutlet weak var editLanguageBtn: UIButton!
    
    var viewModel = ProfileViewModel()
    var isworkExpUpdate = true
    var isSkillsUpdate = true
    var isLanguageUpdate = true
    var userID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getProfileAPI()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        DispatchQueue.main.async {
            self.expereincetblViewHeightConstrant.constant = self.workExpTbl.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "EditProfileView") as? EditProfileView
        navigate?.viewModel.coverImage = coverImage.image
        navigate?.viewModel.profileImage = profileImage.image
        navigate?.viewModel.name = self.viewModel.model[0].data?.fullname ?? ""
        navigate?.viewModel.email = self.viewModel.model[0].data?.email ?? ""
        navigate?.viewModel.about = self.viewModel.model[0].data?.aboutMe ?? ""
        navigate?.viewModel.addressLine1 = self.viewModel.model[0].data?.userAddress?.address1 ?? ""
        navigate?.viewModel.addressLine2 = self.viewModel.model[0].data?.userAddress?.address2 ?? ""
        navigate?.viewModel.city = self.viewModel.model[0].data?.userAddress?.city ?? ""
        navigate?.viewModel.state = self.viewModel.model[0].data?.userAddress?.state ?? ""
        navigate?.viewModel.zipCode = self.viewModel.model[0].data?.userAddress?.zip ?? ""
        navigate?.viewModel.country = self.viewModel.model[0].data?.userAddress?.country ?? ""
        navigate?.viewModel.countryCode = self.viewModel.model[0].data?.userAddress?.countryCode ?? ""
        navigate?.viewModel.placeLat = Double(self.viewModel.model[0].data?.userAddress?.latitude ?? "") ?? 0
        navigate?.viewModel.placeLong = Double(self.viewModel.model[0].data?.userAddress?.longitude ?? "") ?? 0
        navigate?.delegate = self
        self.navigationController?.pushViewController(navigate!, animated: true)
    }
    
    @IBAction func editAboutBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "EditProfileView") as? EditProfileView
        navigate?.viewModel.coverImage = coverImage.image
        navigate?.viewModel.profileImage = profileImage.image
        navigate?.viewModel.name = self.viewModel.model[0].data?.fullname ?? ""
        navigate?.viewModel.email = self.viewModel.model[0].data?.email ?? ""
        navigate?.viewModel.about = self.viewModel.model[0].data?.aboutMe ?? ""
        navigate?.viewModel.addressLine1 = self.viewModel.model[0].data?.userAddress?.address1 ?? ""
        navigate?.viewModel.addressLine2 = self.viewModel.model[0].data?.userAddress?.address2 ?? ""
        navigate?.viewModel.city = self.viewModel.model[0].data?.userAddress?.city ?? ""
        navigate?.viewModel.state = self.viewModel.model[0].data?.userAddress?.state ?? ""
        navigate?.viewModel.zipCode = self.viewModel.model[0].data?.userAddress?.zip ?? ""
        navigate?.viewModel.country = self.viewModel.model[0].data?.userAddress?.country ?? ""
        navigate?.viewModel.countryCode = self.viewModel.model[0].data?.userAddress?.countryCode ?? ""
        navigate?.viewModel.placeLat = Double(self.viewModel.model[0].data?.userAddress?.latitude ?? "") ?? 0
        navigate?.viewModel.placeLong = Double(self.viewModel.model[0].data?.userAddress?.longitude ?? "") ?? 0
        navigate?.delegate = self
        self.navigationController?.pushViewController(navigate!, animated: true)
    }
    
    @IBAction func addExperienceBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "AddExperienceView") as? AddExperienceView
        navigate?.delegate = self
        navigate?.viewModel.isComeFromAdd = true
        self.navigationController?.pushViewController(navigate!, animated: true)
    }
    
    @IBAction func editSkillsAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "SkillsView") as? SkillsView
        navigate?.delegate = self
        for i in 0..<(self.viewModel.model[0].data?.userSkill?.count ?? 0)! {
            navigate?.skillsArray.add(self.viewModel.model[0].data?.userSkill?[i].skillID ?? "")
            navigate?.idArray.append(self.viewModel.model[0].data?.userSkill?[i].skillID ?? "")
        }
        self.navigationController?.pushViewController(navigate!, animated: true)
    }
    
    @IBAction func editLanguageBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "LanguageView") as? LanguageView
        navigate?.delegate = self
        for i in 0..<(self.viewModel.model[0].data?.userLanguage?.count ?? 0)! {
            navigate?.languageArray.add(self.viewModel.model[0].data?.userLanguage?[i].languageID ?? "")
            navigate?.idArray.append(self.viewModel.model[0].data?.userLanguage?[i].languageID ?? "")
        }
        self.navigationController?.pushViewController(navigate!, animated: true)
    }
    
    @IBAction func seeMoreBtnAction(_ sender: UIButton){
        
    }
}

extension ProfileView: LanguageProtocolDelegate {
    func languageData(language: Bool) {
        self.isworkExpUpdate = false
        self.isSkillsUpdate = false
        self.isLanguageUpdate = language
        self.viewModel.getProfileAPI()
    }
}

extension ProfileView: SkillProtocolDelegate {
    func skillData(skills: Bool) {
        self.isworkExpUpdate = false
        self.isSkillsUpdate = skills
        self.isLanguageUpdate = false
        self.viewModel.getProfileAPI()
    }
}

extension ProfileView: AddExperienceProtocolDelegate {
    func experienceData(update: Bool) {
        self.isworkExpUpdate = update
        self.viewModel.getProfileAPI()
    }
}

extension ProfileView: EditProfileProtocolDelegate {
    func editProfileData() {
        self.isworkExpUpdate = false
        self.isSkillsUpdate = false
        self.isLanguageUpdate = false
        self.viewModel.getProfileAPI()
    }
}

extension ProfileView: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.viewModel.model.count > 0 {
            if self.viewModel.model[0].data?.userExperience?.count ?? 0 > 0 {
                return self.viewModel.model[0].data?.userExperience?.count ?? 0
            }else{
                return 0
            }
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkExpCell
        cell.positionName.text = self.viewModel.model[0].data?.userExperience?[indexPath.row].title ?? ""
        cell.barName.text = self.viewModel.model[0].data?.userExperience?[indexPath.row].userExperienceDescription ?? ""
        let startDate = dateFormate(value: self.viewModel.model[0].data?.userExperience?[indexPath.row].startDate ?? "")
        let endDate = dateFormate(value: self.viewModel.model[0].data?.userExperience?[indexPath.row].endDate ?? "")
        let isPreset = self.viewModel.model[0].data?.userExperience?[indexPath.row].present ?? 0
        
        if isPreset != 1 {
            cell.dateOfJoinLeave.text = "\(startDate)" + " to " + "\(endDate)"
            let value = self.viewModel.model[0].data?.userExperience?[indexPath.row].years ?? ""
            let result = value.replacingOccurrences(of: ".00", with: "")
            let totalExp = changeDateFormate(item: result)
            cell.experience.text = totalExp
        }else{
            cell.dateOfJoinLeave.text = "\(startDate)" + " to " + "Present"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: self.viewModel.model[0].data?.userExperience?[indexPath.row].startDate ?? "")!
            let dateComponentsFormatter = DateComponentsFormatter()
            let result = dateComponentsFormatter.difference(from: date, to: Date())!
            let totalExp = changeDateFormate(item: result)
            cell.experience.text = totalExp
        }
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtn), for: .touchUpInside)
        return cell
    }
    
    // MARK: - select button action
    @objc func editBtn(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddExperienceView") as? AddExperienceView
        vc?.viewModel.expId = self.viewModel.model[0].data?.userExperience?[sender.tag].id ?? 0
        vc?.viewModel.startDate = self.viewModel.model[0].data?.userExperience?[sender.tag].startDate ?? ""
        vc?.viewModel.endDate = self.viewModel.model[0].data?.userExperience?[sender.tag].endDate ?? ""
        vc?.viewModel.totalExp = self.viewModel.model[0].data?.userExperience?[sender.tag].years ?? ""
        vc?.viewModel.positionName = self.viewModel.model[0].data?.userExperience?[sender.tag].title ?? ""
        vc?.viewModel.barName = self.viewModel.model[0].data?.userExperience?[sender.tag].userExperienceDescription ?? ""
        vc?.viewModel.isCheck = self.viewModel.model[0].data?.userExperience?[sender.tag].present ?? 0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func dateFormate(value:String) -> String{
        let isoDate = value
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //
        var finalDate = String()
        if let date = dateFormatter.date(from: isoDate) {
            dateFormatter.dateFormat = "MM/dd/YYYY"
            //Output: 12:16 PM on January 01, 2000
            finalDate = dateFormatter.string(from: date)
            print(dateFormatter.string(from: date))
            print(date)
            return finalDate
        }else{
            return ""
        }
    }
    
    func changeDateFormate(item:String) -> String{
        if item.contains("year") && item.contains("month"){
            var newitem = item.replacingOccurrences(of: "years", with: "Year(s)")
            newitem = newitem.replacingOccurrences(of: "year", with: "Year(s)")
            newitem = newitem.replacingOccurrences(of: "months", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "month", with: "Month(s)")
            return newitem
        }else if item.contains("month") && item.contains("week"){
            var newitem = item.replacingOccurrences(of: "months", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "month", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "weeks", with: "Week(s)")
            newitem = newitem.replacingOccurrences(of: "week", with: "Week(s)")
            return newitem
        }else if item.contains("week") && item.contains("day"){
            return "Less then month"
        }else if item.contains("year"){
            var newitem = item.replacingOccurrences(of: "years", with: "Year(s)")
            newitem = newitem.replacingOccurrences(of: "year", with: "Year(s)")
            return newitem
        }else if item.contains("month"){
            var newitem = item.replacingOccurrences(of: "months", with: "Month(s)")
            newitem = newitem.replacingOccurrences(of: "month", with: "Month(s)")
            return newitem
        }else if item.contains("week"){
            return "Less then month"
        }else if item.contains("day"){
            return "Less then month"
        }else{
            return item
        }
    }
    
}

extension ProfileView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == skillsCollection {
            if self.viewModel.model.count > 0 {
                if self.viewModel.model[0].data?.userSkill?.count ?? 0 > 0 {
                    return self.viewModel.model[0].data?.userSkill?.count ?? 0
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }else{
            if self.viewModel.model.count > 0 {
                if self.viewModel.model[0].data?.userLanguage?.count ?? 0 > 0 {
                    return self.viewModel.model[0].data?.userLanguage?.count ?? 0
                }else{
                    return 0
                }
            }else{
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == skillsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SkillCollectionCell
            cell.skillName.text = "   " + "\(self.viewModel.model[0].data?.userSkill?[indexPath.row].skill ?? "")" + "    "
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LanguagesCollectionCell
            cell.languageName.text = "  " + "\(self.viewModel.model[0].data?.userLanguage?[indexPath.row].language ?? "")" +
            "     "
            return cell
        }
    }
    
}

extension ProfileView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let padding: CGFloat =  25
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 115)
    }
}


