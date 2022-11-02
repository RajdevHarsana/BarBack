//
//  FilterViewModel.swift
//  BarBack
//
//  Created by Rajesh gurjar on 24/09/22.
//

import Foundation
import UIKit


class FilterViewModel {
    
    var controller: FilterView?
    var rateSlideminValue = String()
    var rateSlidemaxValue = String()
    var daysSlideminValue = String()
    var daysSlidemaxValue = String()
    var shortBy = String()
    var mostRecentSelected = false
    var mostPopularSelected = false
    var bestMatchSelected = false
    var minPriceRage = Int()
    var maxPriceRage = Int()
    var isFilterApplied = Bool()
    
    func updateView(){
        
        self.controller?.minRate.text = "$ " + "\(minPriceRage)"
        self.controller?.maxRate.text = "$ " + "\(maxPriceRage)"
        self.controller?.rateRangeSlider.minValue = CGFloat(minPriceRage)
        self.controller?.rateRangeSlider.maxValue = CGFloat(maxPriceRage)
        self.controller?.daysRangeSlider.minValue = CGFloat(1)
        self.controller?.daysRangeSlider.maxValue = CGFloat(7)
        self.controller?.rateRangeSlider.hideLabels = true
        
        if rateSlidemaxValue == "" {
            rateSlidemaxValue = String(maxPriceRage)
        }else{
            
        }
        if rateSlideminValue == "" {
            rateSlideminValue = String(minPriceRage)
        }else{
            
        }
        if daysSlidemaxValue == "" {
            daysSlidemaxValue = String(7)
        }else {
            
        }
        if daysSlideminValue == "" {
            daysSlideminValue = String(1)
        }else{
            
        }
        
        if isFilterApplied {
            self.controller?.rateRangeSlider.selectedMaxValue = CGFloat(Int(rateSlidemaxValue) ?? 0)
            self.controller?.rateRangeSlider.selectedMinValue = CGFloat(Int(rateSlideminValue) ?? 0)
            self.controller?.daysRangeSlider.selectedMaxValue = CGFloat(Int(daysSlidemaxValue) ?? 0)
            self.controller?.daysRangeSlider.selectedMinValue = CGFloat(Int(daysSlideminValue) ?? 0)
        }else{
            self.controller?.rateRangeSlider.selectedMaxValue = CGFloat(maxPriceRage)
            self.controller?.rateRangeSlider.selectedMinValue = CGFloat(minPriceRage)
            self.controller?.daysRangeSlider.selectedMaxValue = CGFloat(7)
            self.controller?.daysRangeSlider.selectedMinValue = CGFloat(1)
        }
        
        
        self.controller?.daysRangeSlider.hideLabels = true
        
        self.controller?.backView.roundCorners([.topLeft,.topRight], radius: 16)
        
        if self.shortBy == "most_recent" {
            self.controller?.mostRecentLbl.changeSelectLabel()
            self.controller?.mostPopularLbl.changeUnSelectLabel()
            self.controller?.bestMatchLbl.changeUnSelectLabel()
        }else if self.shortBy == "most_popular" {
            self.controller?.mostPopularLbl.changeSelectLabel()
            self.controller?.mostRecentLbl.changeUnSelectLabel()
            self.controller?.bestMatchLbl.changeUnSelectLabel()
        }else if self.shortBy == "best_match" {
            self.controller?.bestMatchLbl.changeSelectLabel()
            self.controller?.mostRecentLbl.changeUnSelectLabel()
            self.controller?.mostPopularLbl.changeUnSelectLabel()
        }else{
            self.controller?.mostRecentLbl.changeUnSelectLabel()
            self.controller?.mostPopularLbl.changeUnSelectLabel()
            self.controller?.bestMatchLbl.changeUnSelectLabel()
        }
            
        self.controller?.searchBtn.layer.cornerRadius = 8
    }
}
