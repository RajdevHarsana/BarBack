//
//  MyRequestViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 19/09/22.
//

import Foundation

class MyRequestViewModel {
    
    var controller: ShiftRequestView?
    var model = [MyRequestDatum]()
    var authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
    var jobId = Int()
    var lastPage = Int()
    
    func myRquestListAPI(pageNumber:Int){
        Loader.start()
        let paramDict = ["page":pageNumber] as [String : Any]
        
        APIManager.shared.myRquestListDataApi(baseUrl: Config().API_URL + "/api/user-job-applications", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! MyRequestModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                self.model.append(contentsOf: data.data?.data ?? [])
                self.lastPage = data.data?.lastPage ?? 0
                if self.model.count > 0{
//                    self.controller?.view.makeToast(message: "Request found")
                }else{
                    self.controller?.view.makeToast(message: "No request found")
                }
                self.controller?.tblList.reloadData()
                self.controller?.isLoading = false
            }else {
                self.model.removeAll()
                self.controller?.tblList.reloadData()
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func cancelJobAPI(id:Int,index:Int){
        Loader.start()
        let paramDict = ["job_id":id] as [String : Any]
        
        APIManager.shared.cancelJobRequestApi(baseUrl: Config().API_URL + "/api/cancel-job-request", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["success"] as? Bool ?? false == true {
                self.model.remove(at: index)
                self.controller?.tblList.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
}
