//
//  BarLocationView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 17/10/22.
//

import UIKit
import MapKit
import GoogleMaps
import Kingfisher

class BarLocationView: UIViewController {

    //MARK: - IBOutlates
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var barName: UILabel!
    @IBOutlet weak var barLocation: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var barImg: UIImageView!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    //MARK: - Variables
    var viewModel = BarLocationViewModel()
    var mapMarkers : [GMSMarker] = []
    var locationManager = CLLocationManager()
    var userModel = [UserModel]()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.controller = self
        self.viewModel.updateView()
        self.backView.roundCorners([.topLeft, .topRight], radius: 16)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: UIScreen.main.bounds.height - 275 , right: 15)
        view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for locations in 0..<(self.viewModel.model.count) {
            let lat = Double(self.viewModel.model[locations].userAddress?.latitude ?? "") ?? 0
            let long = Double(self.viewModel.model[locations].userAddress?.longitude ?? "") ?? 0
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 14.0)
            mapView.camera = camera
            mapView.delegate = self
            
            let stringLat = self.viewModel.model[locations].userAddress?.latitude ?? ""
            if stringLat != "" {
                showMarker(position: camera.target)
                userModel.append(UserModel(userName: viewModel.model[locations].fullname ?? "", userImage: viewModel.model[locations].profileImage ?? "", userCity: viewModel.model[locations].userAddress?.city ?? "", userState: viewModel.model[locations].userAddress?.city ?? "", userId: viewModel.model[locations].id ?? 0))
            }else{
                
            }
        }
        print("Now done")
    }
    
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.icon = UIImage(named: "pin")
        marker.map = mapView
        mapMarkers.append(marker)
    }
    
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - button for search on map
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
    
    // MARK: - button for search on map
    @IBAction func btnSelectAction(_ sender: UIButton){
        let id = userModel[viewModel.selectedMarkerIndex].userId ?? 0
        self.viewModel.requestJobAPI(id: id, action: "Accept")
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
//        DispatchQueue.main.async {
//            if (CLLocationManager.locationServicesEnabled()) {
//                self.locationManager.delegate = self
//                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                self.locationManager.requestWhenInUseAuthorization()
//                self.locationManager.startUpdatingLocation()
//            } else {
//                print("Location services are not enabled");
//            }
//        }
    }
    
}

extension BarLocationView: RightMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
    func toggleRightMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RightMenuViewController") as! RightMenuViewController
        vc.delegate = self
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        self.navigationController?.present(vc, animated: false)
    }
}

extension BarLocationView : GMSMapViewDelegate{
    //MARK:- Google Map Delegates
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if let index = mapMarkers.firstIndex(of: marker) {
            self.viewModel.selectedMarkerIndex = index
            let profileImgURL = URL(string: userModel[index].userImage ?? "")
            self.barImg.kf.indicatorType = .activity
            self.barImg.kf.setImage(with: profileImgURL)
            
            self.barName.text = userModel[index].userName ?? ""
            self.barLocation.text = "\(userModel[index].userCity ?? "")" + ", " + "\(userModel[index].userState ?? "")"
            
        }
        return true
    }
}

extension BarLocationView:  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let myMarker = GMSMarker()
        myMarker.position = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        
        myMarker.icon = UIImage(named: "test2")
        myMarker.map = self.mapView
        myMarker.snippet = "Location"
        self.mapView.settings.consumesGesturesInView = false
        let BigMapupdatedCamera = GMSCameraUpdate.setTarget((myMarker.position), zoom: 14.0)
        self.mapView.animate(with: BigMapupdatedCamera)
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Error \(error)")
    }
}

struct UserModel {
    var userName:String?
    var userImage:String?
    var userCity:String?
    var userState:String?
    var userId:Int?
}
