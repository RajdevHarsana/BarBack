//
//  SearchListViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 17/09/22.
//

import Foundation
import UIKit

class SearchListViewModel {
    
    var controller: SearchVC?
    var model = [SearchDatum]()
    var authToken = String()
    var priceMin = String()
    var priceMax = String()
    var dayMin = String()
    var dayMax = String()
    var sortBy = String()
    var apply = Bool()
    var lastPage = Int()
    var apiMinPrice = Int()
    var apiMaxPrice = Int()
    
    func searchListRequestAPI(pageNumber:Int,searchTxt:String){
        Loader.start()
        authToken = Config().AppUserDefaults.string(forKey: "UserToken") ?? ""
        let paramDict = ["page":pageNumber,"q":searchTxt,"price_min":priceMin,"price_max":priceMax,"day_min":dayMin,"day_max":dayMax,"sort_by":sortBy] as [String : Any]
        
        APIManager.shared.searchListDataApi(baseUrl: Config().API_URL + "/api/job-list", parameter: paramDict, token: authToken) { response in
            print(response)
            
            let data = response as! SearchListModel
            let message = data.message ?? ""
            if data.success ?? false == true {
                self.model.append(contentsOf: data.data?.data ?? [])
                self.apiMinPrice = data.minPrice ?? 0
                self.apiMaxPrice = data.maxPrice ?? 0
                self.lastPage = data.data?.lastPage ?? 0
                self.controller?.tbl_searchList.reloadData()
                self.controller?.isLoading = false
            }else {
                self.model.removeAll()
                self.controller?.tbl_searchList.reloadData()
                self.controller?.view.makeToast(message: message)
            }
            Loader.stop()
        }
    }
    
    func updateView(){
        
        self.controller?.btn_showMap.layer.cornerRadius = 5
        self.controller?.btn_showMap.layer.masksToBounds = true
        
        self.controller?.txt_search.layer.borderWidth = 1
        self.controller?.txt_search.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8067654237)
        self.controller?.txt_search.layer.cornerRadius = 23
        self.controller?.txt_search.layer.masksToBounds = true
        self.controller?.txt_search.delegate = self.controller
        
        self.controller?.txt_search.setLeftPaddingPoints(15)
        
        self.controller?.view_baground.roundCorners([.topLeft, .topRight], radius: 16)
    }
    
}
