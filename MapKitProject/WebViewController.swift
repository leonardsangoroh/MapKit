//
//  WebViewController.swift
//  MapKitProject
//
//  Created by Lee Sangoroh on 21/02/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    /// instance of WKWebView class
    var webView: WKWebView!
    
    var placeName: String? = ""
    var placeInfo: String? = ""
    
    /// store default Wikipedia URL
    var wikipedia = "https://en.wikipedia.org/wiki/"
    /// store full city URL
    var wikipediaPage: String = ""
    
    override func loadView() {
        /// initialization
        webView = WKWebView()
        /// make view the view for WebViewController
        view = webView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /// set full URL
        wikipediaPage = wikipedia + placeName!
        /// type URL - swift's way of storing location of files
        let url = URL(string:wikipediaPage)
        /// wrap url in a url request
        webView.load(URLRequest(url: url!))
        /// enables a property of the webview - BackForward Navigation
        /// swipe left or right to move backwards or forwards
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
