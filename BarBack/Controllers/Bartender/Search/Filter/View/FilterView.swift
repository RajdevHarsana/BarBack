//
//  FilterView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 24/09/22.
//

import UIKit

protocol FilterPrototcolDelegate {
    func filterData(minPrice:String,maxPrice:String,minDays:String,maxDays:String,shortBy:String,isFilterApply:Bool)
}

var isRateRange = "true"

class FilterView: UIViewController {
    
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mostRecentLbl : UILabel!
    @IBOutlet weak var mostPopularLbl : UILabel!
    @IBOutlet weak var bestMatchLbl : UILabel!
    @IBOutlet weak var rateRangeSlider: RangeSeekSlider!
    @IBOutlet weak var daysRangeSlider: RangeSeekSlider!
    @IBOutlet weak var searchBtn : UIButton!
    @IBOutlet weak var minRate : UILabel!
    @IBOutlet weak var maxRate : UILabel!
    
    var viewModel = FilterViewModel()
    var delegate : FilterPrototcolDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rateRangeSlider.delegate = self
        self.daysRangeSlider.delegate = self
        self.viewModel.controller = self
        self.viewModel.updateView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        self.touchView.addGestureRecognizer(gesture)
    }
    
    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @IBAction func mostRecentBtn(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        if self.viewModel.mostRecentSelected != false {
            self.viewModel.mostRecentSelected = false
            self.viewModel.shortBy = ""
            self.mostRecentLbl.changeUnSelectLabel()
        }else{
            self.viewModel.shortBy = "most_recent"
            self.viewModel.bestMatchSelected = false
            self.bestMatchLbl.changeUnSelectLabel()
            self.viewModel.mostRecentSelected = true
            self.mostRecentLbl.changeSelectLabel()
            self.viewModel.mostPopularSelected = false
            self.mostPopularLbl.changeUnSelectLabel()
        }
        
    }
    
    @IBAction func mostPopularBtn(_ sender: UIButton){
        if self.viewModel.mostPopularSelected != false {
            self.viewModel.mostPopularSelected = false
            self.mostPopularLbl.changeUnSelectLabel()
            self.viewModel.shortBy = ""
        }else{
            self.viewModel.shortBy = "most_popular"
            self.viewModel.bestMatchSelected = false
            self.bestMatchLbl.changeUnSelectLabel()
            self.viewModel.mostRecentSelected = false
            self.mostRecentLbl.changeUnSelectLabel()
            self.viewModel.mostPopularSelected = true
            self.mostPopularLbl.changeSelectLabel()
        }
    }
    
    @IBAction func bestMatchBtn(_ sender: UIButton){
        if self.viewModel.bestMatchSelected != false {
            self.viewModel.bestMatchSelected = false
            self.bestMatchLbl.changeUnSelectLabel()
            self.viewModel.shortBy = ""
        }else{
            self.viewModel.shortBy = "best_match"
            self.viewModel.bestMatchSelected = true
            self.bestMatchLbl.changeSelectLabel()
            self.viewModel.mostRecentSelected = false
            self.mostRecentLbl.changeUnSelectLabel()
            self.viewModel.mostPopularSelected = false
            self.mostPopularLbl.changeUnSelectLabel()
        }
    }
    
    @IBAction func searchBtn(_ sender: UIButton){
        if delegate != nil {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.filterData(minPrice: viewModel.rateSlideminValue, maxPrice: viewModel.rateSlidemaxValue, minDays: viewModel.daysSlideminValue, maxDays: viewModel.daysSlidemaxValue, shortBy: viewModel.shortBy, isFilterApply: true)
        }
    }
}

// MARK: - RangeSeekSliderDelegate
extension FilterView: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rateRangeSlider {
            //            Config().AppUserDefaults.set("true", forKey: "Change")
            let MinValue = rateRangeSlider.numberFormatter.string(from: minValue as NSNumber)
            let newMin = MinValue?.replacingOccurrences(of: " miles", with: "")
            self.viewModel.rateSlideminValue = newMin ?? ""
            let MaxValue = rateRangeSlider.numberFormatter.string(from: maxValue as NSNumber)
            let newMax = MaxValue?.replacingOccurrences(of: " miles", with: "")
            self.viewModel.rateSlidemaxValue = newMax ?? ""
            //            Config().AppUserDefaults.set(newMin, forKey: "MINVALUE")
            //            Config().AppUserDefaults.set(newMax, forKey: "MAXVALUE")
            print("Formated updated. Min Value: \(String(describing: MinValue)) Max Value: \(String(describing: MaxValue))")
        }else{
            let MinValue = daysRangeSlider.numberFormatter.string(from: minValue as NSNumber)
            let newMin = MinValue?.replacingOccurrences(of: " miles", with: "")
            self.viewModel.daysSlideminValue = newMin ?? ""
            let MaxValue = daysRangeSlider.numberFormatter.string(from: maxValue as NSNumber)
            let newMax = MaxValue?.replacingOccurrences(of: " miles", with: "")
            self.viewModel.daysSlidemaxValue = newMax ?? ""
            //            Config().AppUserDefaults.set(newMin, forKey: "MINVALUE")
            //            Config().AppUserDefaults.set(newMax, forKey: "MAXVALUE")
            print("Formated updated. Min Value: \(String(describing: MinValue)) Max Value: \(String(describing: MaxValue))")
        }
    }
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
        if slider == rateRangeSlider {
            self.rateRangeSlider.hideLabels = false
            self.rateRangeSlider.hideLabels = false
        }else{
            self.daysRangeSlider.hideLabels = false
            self.daysRangeSlider.hideLabels = false
        }
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        if slider == rateRangeSlider {
            self.rateRangeSlider.hideLabels = true
            self.rateRangeSlider.hideLabels = true
        }else{
            self.daysRangeSlider.hideLabels = true
            self.daysRangeSlider.hideLabels = true
        }
    }
    
    func StringToFloat(str:String)->(CGFloat){
        let string = str
        var cgFloat:CGFloat = 0
        if let doubleValue = Double(string){
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
}
extension UILabel {
    
    func changeSelectLabel() {
        self.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.roundCorners([.allCorners], radius: 16)
        self.layer.borderColor = #colorLiteral(red: 0.6392156863, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.layer.borderWidth = 2
        self.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
    }
    func changeUnSelectLabel() {
        self.textColor = #colorLiteral(red: 0.6392156863, green: 0.1176470588, blue: 0.1921568627, alpha: 1)
        self.layer.cornerRadius = 16
        self.layer.borderColor = #colorLiteral(red: 0.5141925812, green: 0.5142051578, blue: 0.5141984224, alpha: 1)
        self.layer.borderWidth = 2
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
}
