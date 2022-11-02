//
//  DreamBarViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 20/09/22.
//

import Foundation

class DreamBarViewModel {
    
    var controller: DreamsBarVC? = nil
    var model = [DreamBarDatum]()
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    var userId = Int()
    var image = String()
    var name = String()
    var lastPage = Int()
    
    func dreamBarRequestAPI(pageNumber:Int){
        Loader.start()
        let paramDict = ["user_id":userId,"page":pageNumber] as [String : Any]
        
        APIManager.shared.dreamBarDataApi(baseUrl: Config().API_URL + "/api/job-list", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! DreamBarModel
            let message = data.message ?? ""
            if (data.status != nil) == true {
                self.model.append(contentsOf: data.data?.data ?? [])
                self.lastPage = data.data?.lastPage ?? 0
                self.updateUI()
                self.controller?.tbl_dreamsbarList.reloadData()
                self.controller?.isLoading = false
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        self.controller?.barImg.layer.cornerRadius = (self.controller?.barImg.frame.height)!/2
        self.controller?.barImg.layer.borderColor = #colorLiteral(red: 0.7067357302, green: 0.191364646, blue: 0.2495637238, alpha: 1)
        self.controller?.barImg.layer.borderWidth = 2
    }
    
    func updateUI(){
        let profileImgURL = URL(string: image)
        self.controller?.barImg.kf.indicatorType = .activity
        self.controller?.barImg.kf.setImage(with: profileImgURL)
        self.controller?.barName.text = name
    }
}
