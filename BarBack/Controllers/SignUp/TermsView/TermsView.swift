//
//  TermsView.swift
//  BarBack
//
//  Created by Rajesh gurjar on 25/09/22.
//

import UIKit
import WebKit

class TermsView: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicationView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.roundCorners([.topLeft,.topRight], radius: 16)
        self.webView.navigationDelegate = self
        indicationView.style = .large
        indicationView.color = UIColor.black
        indicationView.center = self.view.center
        self.termsandconditionmethod()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - webview Function
    func termsandconditionmethod() {
            
        indicationView.startAnimating()
        indicationView.isHidden = false
        webView.scrollView.isScrollEnabled = true
        webView.scrollView.contentOffset = CGPoint(x: 0, y: 800)
        webView.scrollView.bounces = false
        let url = URL(string: "https://bar-backapp.com/terms-of-service")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
}

extension TermsView: WKNavigationDelegate {
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
