//
//  MyShiftsViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 12/10/22.
//

import Foundation

class MyShiftsViewModel {
    
    var controller: MyShiftsView?
    var model = [MyShiftsDatum]()
    var lastPage = Int()
    
    let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    
    func myShiftsRequestAPI(pageNumber:Int){
        Loader.start()
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.myShiftsListApi(baseUrl: Config().API_URL + "/api/my-job-list", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! MyShiftsModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                self.model.append(contentsOf: data.data?.data ?? [])
                self.lastPage = data.data?.lastPage ?? 0
                self.controller?.myShiftListTblView.reloadData()
                self.controller?.isLoading = false
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
}
