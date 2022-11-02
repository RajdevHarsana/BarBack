//
//  SkillsViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import Foundation

class SkillsViewModel {
    
    var controller: SkillsView?
    var model = [SkillsModel]()
    
    func getSkillsAPI(){
        Loader.start()
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.getSkillsApi(baseUrl: Config().API_URL + "/api/get-skills", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as! SkillsModel
            let message = data.message ?? ""
            if (data.status != nil) == true {
                self.model.append(response as! SkillsModel)
                self.controller?.skillsTblView.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
        
    }
    
    func updateSkillsAPI(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["skill_ids":self.controller?.idString ?? ""] as [String : Any]
        
        APIManager.shared.updateSkillsApi(baseUrl: Config().API_URL + "/api/update-skills", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if ((data?["success"]) != nil) == true {
                self.controller?.view.makeToast(message: "Saved Successfully")
                if self.controller?.delegate != nil {
                    self.controller?.navigationController?.popViewController(animated: true)
                    self.controller?.delegate?.skillData(skills:self.controller?.delegate != nil)
                }
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
}
