//
//  AboutUsView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 23/09/22.
//

import UIKit
import WebKit

class AboutUsView: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicationView: UIActivityIndicatorView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.roundCorners([.topLeft,.topRight], radius: 16)
        self.webView.navigationDelegate = self
        indicationView.style = .large
        indicationView.color = UIColor.black
        indicationView.center = self.view.center
        self.aboutUsMethod()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - webview Function
    func aboutUsMethod() {
        indicationView.startAnimating()
        indicationView.isHidden = false
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.contentOffset = CGPoint(x: 0, y: 800)
        webView.scrollView.bounces = false
        let url = URL(string: "https://bar-backapp.com/#about")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    // MARK: - IB Actions
    // MARK: - button for back navigation
    @IBAction func btn_back(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
        //           self.dismiss(animated: true)
    }
    // MARK: - button for side menu
    @IBAction func btnSideMenu(_ sender: UIButton){
        self.toggleRightMenu()
    }
}

extension AboutUsView: WKNavigationDelegate {
    //MARK: - Webview Delegates
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        indicationView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        indicationView.stopAnimating()
        indicationView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}

extension AboutUsView: SideMenuDelegates {
    func sideMenuNavigation(controllerView: UIViewController) {
        self.navigationController?.pushViewController(controllerView, animated: false)
    }
    func toggleRightMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LeftMenuViewController") as! LeftMenuViewController
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
