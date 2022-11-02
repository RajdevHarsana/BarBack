//
//  BarProfileView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 16/10/22.
//

import UIKit

class BarUserWorkingDaysCell: UICollectionViewCell{
    @IBOutlet weak var daysName: UILabel!
}

class BarUserProfileView: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var aboutUser: UILabel!
    @IBOutlet weak var aboutUserView: UIView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var workingDaysCollection: UICollectionView!
    @IBOutlet weak var wokingDaysView: UIView!
    @IBOutlet weak var wokingDayCollectionViewHeightConstrant: NSLayoutConstraint!
    @IBOutlet weak var editProfileBtn: UIButton!

    
    var viewModel = BarUserProfileViewModel()
    var isworkinDays = true
    var userID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
        self.viewModel.getProfileAPI()
    }
    
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editProfileBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "BarEditProfileView") as? BarEditProfileView
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
        let navigate = storyboard?.instantiateViewController(withIdentifier: "BarEditProfileView") as? BarEditProfileView
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
    
    @IBAction func editLocationBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "BarEditProfileView") as? BarEditProfileView
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
    
    @IBAction func editWorkingDaysBtnAction(_ sender: UIButton){
        let navigate = storyboard?.instantiateViewController(withIdentifier: "AddWorkingDaysView") as? AddWorkingDaysView
        self.navigationController?.pushViewController(navigate!, animated: true)
    }

}

extension BarUserProfileView: BarEditProfileProtocolDelegate {
    func editProfileData() {
        self.viewModel.getProfileAPI()
    }
}

extension BarUserProfileView: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if self.viewModel.model.count > 0 {
                if self.viewModel.model[0].data?.workingdays?.count ?? 0 > 0 {
                    return self.viewModel.model[0].data?.workingdays?.count ?? 0
                }else{
                    return 0
                }
            }else{
                return 0
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BarUserWorkingDaysCell
            cell.daysName.text = "   " + "\(self.viewModel.model[0].data?.workingdays?[indexPath.row].day ?? "")" + "    "
            return cell
    }
    
}

extension BarUserProfileView: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        let padding: CGFloat =  25
//        let collectionViewSize = collectionView.frame.size.width - padding
//        return CGSize(width: collectionViewSize/2, height: 115)
//    }
}
