//
//  BlankViewController.swift
//  Time_Manager
//
//  Created by admin on 6/15/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import WebKit


//        let newVC = BlankViewController() //<--- viewDidLoad has browser calls
//        navigationController?.pushViewController(newVC, animated: true)

class BlankViewController: UIViewController, WKUIDelegate {
    
    var myTapGesture : UITapGestureRecognizer!
    var webView: WKWebView!
    
    private func setupNavigationBar(){
        print("wtf")
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        let myURL = URL(string: "https://www.google.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)

        
        myTapGesture =  UITapGestureRecognizer(target: self, action: #selector(handleTap))
        myTapGesture.numberOfTapsRequired = 2
        
        
        view.addGestureRecognizer(myTapGesture)
        view.isUserInteractionEnabled = true
        
        webView.addGestureRecognizer(myTapGesture)
        webView.isUserInteractionEnabled = true
        
        
//        webView.addGestureRecognizer(myTapGesture)
        
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


    @objc func handleTap(){
        print("tap happened--")
    }
    
    
}
