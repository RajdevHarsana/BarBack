//
//  LocationViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 21/09/22.
//

import Foundation
import UIKit
import Kingfisher

class LocationViewModel {
    
    var controller: LocationVC?
    var model = [SearchDatum]()
    var firstIndexLat = Double()
    var firstIndexLong = Double()
    var selectedMarkerIndex = 0
    
    
    func updateView(){
        
        self.firstIndexLat = Double(self.model[0].user?.userAddress?.latitude ?? "") ?? 0.0
        self.firstIndexLong = Double(self.model[0].user?.userAddress?.longitude ?? "") ?? 0.0
        
        let isApplied = self.model[0].isApplied ?? false
        if isApplied != true{
            self.controller?.btnSelect.setTitle("Select", for: .normal)
            self.controller?.btnSelect.backgroundColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        }else{
            self.controller?.btnSelect.setTitle("Applied", for: .normal)
            self.controller?.btnSelect.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        
        self.controller?.detailView.layer.cornerRadius = 10
        self.controller?.detailView.layer.masksToBounds = true;
        self.controller?.btnSelect.layer.cornerRadius = 10
        self.controller?.btnSelect.layer.masksToBounds = true;
        
        self.controller?.detailView.layer.shadowColor = UIColor.lightGray.cgColor
        self.controller?.detailView.layer.shadowOpacity = 0.6
        self.controller?.detailView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.controller?.detailView.layer.shadowRadius = 2.0
        self.controller?.detailView.layer.masksToBounds = false
        
        self.controller?.barImg.layer.cornerRadius = (self.controller?.barImg.frame.height)!/2
        self.controller?.barImg.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        self.controller?.barImg.layer.borderWidth = 2
        
        let profileImgURL = URL(string: self.model[0].user?.profileImage ?? "")
        self.controller?.barImg.kf.indicatorType = .activity
        self.controller?.barImg.kf.setImage(with: profileImgURL)
        
        self.controller?.barName.text = self.model[0].user?.fullname ?? ""
        self.controller?.barLocation.text = "\(self.model[0].user?.userAddress?.city ?? "")" + ", " + "\(self.model[0].user?.userAddress?.state ?? "")"
        
    }
}
