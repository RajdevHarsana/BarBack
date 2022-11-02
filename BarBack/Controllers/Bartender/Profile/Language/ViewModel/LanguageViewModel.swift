//
//  LanguageViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import Foundation

class LanguageViewModel {
    
    var controller: LanguageView?
    var model = [LanguageModel]()
    
    func getLanguageAPI(){
        Loader.start()
        let paramDict = [:] as [String : Any]
        
        APIManager.shared.getLanguagesApi(baseUrl: Config().API_URL + "/api/get-languages", parameter: paramDict, token: "") { response in
            print(response)
            
            let data = response as! LanguageModel
            let message = data.message ?? ""
            if (data.status != nil) == true {
                self.model.append(response as! LanguageModel)
                self.controller?.languageTblView.reloadData()
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateLanguageAPI(){
        Loader.start()
        let authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["language_ids":self.controller?.idString ?? ""] as [String : Any]
        
        APIManager.shared.updateLanguageApi(baseUrl: Config().API_URL + "/api/update-languages", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as? [String:Any]
            let message = data?["message"] as? String ?? ""
            if data?["status"] as! Int == 200 {
                self.controller?.view.makeToast(message: "Saved Successfully")
                if self.controller?.delegate != nil {
                    self.controller?.navigationController?.popViewController(animated: true)
                    self.controller?.delegate?.languageData(language:self.controller?.delegate != nil)
                }
            }else {
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
}
