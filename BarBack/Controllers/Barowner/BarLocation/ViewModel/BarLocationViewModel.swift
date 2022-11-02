//
//  BarLocationViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 17/10/22.
//

import Foundation
import UIKit
import Kingfisher

class BarLocationViewModel {
    
    var controller: BarLocationView?
    var model = [BarDatum]()
    var firstIndexLat = Double()
    var firstIndexLong = Double()
    var selectedMarkerIndex = 0
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    
    func requestJobAPI(id:Int,action:String){
        Loader.start()
        let paramDict = ["job_request_id":id,"action":action] as [String : Any]
        
        APIManager.shared.acceptDeclineJobRequestApi(baseUrl: Config().API_URL + "/api/request-action", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["success"] as? Bool ?? false == true {
                self.controller?.btnSelect.setTitle("Offered", for: .normal)
                self.controller?.btnSelect.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        
        self.firstIndexLat = Double(self.model[0].userAddress?.latitude ?? "") ?? 0.0
        self.firstIndexLong = Double(self.model[0].userAddress?.longitude ?? "") ?? 0.0
        
//        let isApplied = self.model[0].isApplied ?? false
//        if isApplied != true{
//            self.controller?.btnSelect.setTitle("Select", for: .normal)
//            self.controller?.btnSelect.backgroundColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
//        }else{
//            self.controller?.btnSelect.setTitle("Applied", for: .normal)
//            self.controller?.btnSelect.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        }
        
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
        for locations in 0..<(self.model.count) {
            let profileImgURL = URL(string: self.model[locations].profileImage ?? "")
            self.controller?.barImg.kf.indicatorType = .activity
            self.controller?.barImg.kf.setImage(with: profileImgURL)
            
            self.controller?.barName.text = self.model[locations].fullname ?? ""
            self.controller?.barLocation.text = "\(self.model[locations].userAddress?.city ?? "")" + ", " + "\(self.model[locations].userAddress?.state ?? "")"
            let lat = self.model[locations].userAddress?.latitude ?? ""
            if lat != ""{
                break
            }else{
                
            }
        }
    }
}
