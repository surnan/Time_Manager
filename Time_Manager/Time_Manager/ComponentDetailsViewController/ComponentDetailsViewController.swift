//
//  ComponentDetailsViewController.swift
//  Time_Manager
//
//  Created by admin on 6/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import WebKit
//import AVFoundation


class ComponentDetailsViewController: UIViewController, WKNavigationDelegate {
    
    //MARK:- Parameters passed in
    var myDelegate: manipulatingComponentsListViewController? //passed-in
    var parentTask: TaskItem?   //passed-in
    var currentComponentItem: ComponentItem? {  //passed-in
        didSet {
            if let notes = currentComponentItem?.cNotes {currentNotes.text = notes}
            if let website = currentComponentItem?.cWebsite {currentWebsite = website}
            if let media = currentComponentItem?.cMedia {currentMediaData = media}
        }
    }
    
    //MARK:- Local declared parameters loaded up from incoming variables
    let currentNotes: UITextView = {
        let tempTextView = UITextView()
        tempTextView.backgroundColor = UIColor.lightPurple
        tempTextView.textColor = UIColor.black
        tempTextView.font = UIFont.boldSystemFont(ofSize: 20)
        tempTextView.isEditable = false
        tempTextView.isScrollEnabled = false
        //tempTextView.isScrollEnabled = true; tempTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tempTextView.translatesAutoresizingMaskIntoConstraints = false
        return tempTextView
    }()
    
    var currentMediaData: Data!

    
    let currentMedia : UIImageView = {
        let tempImage = UIImageView()
        tempImage.backgroundColor = UIColor.yellow
        tempImage.contentMode = .scaleAspectFit
        //        tempImage.contentMode = .scaleToFill
        //        tempImage.contentMode = .scaleAspectFill
        tempImage.translatesAutoresizingMaskIntoConstraints = false
        return tempImage
    }()
    
    let thumbImage : UIImageView = {
        let tempImage = UIImageView()
        tempImage.backgroundColor = UIColor.yellow
        tempImage.contentMode = .scaleAspectFit
        tempImage.isUserInteractionEnabled = true
        //        tempImage.contentMode = .scaleToFill
        //        tempImage.contentMode = .scaleAspectFill
        tempImage.translatesAutoresizingMaskIntoConstraints = false
        tempImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        //        tempImage.widthAnchor.constraint(equalToConstant: 120).isActive = true  //causes constraint warnings in our scenario
        return tempImage
    }()
    
    let buttonWebsite: UIButton = {
        let tempButton = UIButton()
        tempButton.setTitle("LOAD WEBSITE", for: .normal)
        tempButton.setTitleColor(UIColor.black, for: .normal)
        tempButton.backgroundColor = UIColor.lightGray
        tempButton.addTarget(self, action: #selector(handleButtonWebsite), for: .touchDown)
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        return tempButton
    }()
    
    
    
    //MARK:- Locally declared and locally loaded
    
    var myScrollView2: UIScrollView = {
        let tempScrollView = UIScrollView()
        tempScrollView.backgroundColor = UIColor.black
        tempScrollView.isDirectionalLockEnabled = true
        tempScrollView.bounces = false
        tempScrollView.isUserInteractionEnabled = true
        tempScrollView.translatesAutoresizingMaskIntoConstraints = false
        return tempScrollView
    }()
    
    var myStackView : UIStackView = {
        let tempStackView = UIStackView()
        tempStackView.translatesAutoresizingMaskIntoConstraints = false
        tempStackView.axis = .vertical
        tempStackView.spacing = 20
        return tempStackView
    }()
    
    var currentWebsite: String?
    
    var notesTextViewHeight: NSLayoutConstraint!
    
    
    
    //MARK:- Setup Navigation Bar
    private func setupNavigationBar(){
        navigationItem.title = "\(parentTask?.name ?? "") --> \(currentComponentItem?.cName ?? "")"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleRightBarButton))
    }
    
    @objc private func handleRightBarButton(){
        print("Right Button Selected")
    }
    
    
    //MARK:- My functions
    @objc private func handleButtonWebsite(){
        let webView: WKWebView!
        webView = WKWebView()
        myStackView.addArrangedSubview(webView)
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: currentWebsite!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    //MARK:- UI Constraints
    private func useScrollViewConstraints(){
        //let screenSize = UIScreen.main.bounds
        let tempImage = UIImage(data: currentMediaData)
        currentMedia.image = tempImage
        thumbImage.image = tempImage
        
        [myScrollView2].forEach{view.addSubview($0)}
        [myStackView].forEach{myScrollView2.addSubview($0)}
        
//        [currentNotes, thumbImage, currentMedia, buttonWebsite].forEach{myStackView.addArrangedSubview($0)}
        [currentNotes, thumbImage, buttonWebsite].forEach{myStackView.addArrangedSubview($0)}
        
        notesTextViewHeight = currentNotes.heightAnchor.constraint(equalToConstant: 500)
        
  
        NSLayoutConstraint.activate([
            myScrollView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myScrollView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myScrollView2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myScrollView2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            myStackView.topAnchor.constraint(equalTo: myScrollView2.topAnchor),
            myStackView.bottomAnchor.constraint(equalTo: myScrollView2.bottomAnchor),
            myStackView.leadingAnchor.constraint(equalTo: myScrollView2.leadingAnchor),
            myStackView.trailingAnchor.constraint(equalTo: myScrollView2.trailingAnchor),
            myStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
        
        
//        let fixedWidth = currentNotes.frame.size.width
//        let fixedWidth = view.frame.width
        
//        let fixedWidth = currentNotes.frame.width
        let fixedWidth = myStackView.frame.size.width
        let fixedWidth2 = myScrollView2.frame.size.width
        let fixedWidth3 = currentNotes.frame.size.width
        let fixedWidth4 = view.frame.size.width

        
        let newSize = currentNotes.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize2 = currentNotes.sizeThatFits(CGSize(width: fixedWidth2, height: CGFloat.greatestFiniteMagnitude))
        let newSize3 = currentNotes.sizeThatFits(CGSize(width: fixedWidth3, height: CGFloat.greatestFiniteMagnitude))
        let newSize4 = currentNotes.sizeThatFits(CGSize(width: fixedWidth4, height: CGFloat.greatestFiniteMagnitude))
        
        
        if newSize4.height > 300 {
            currentNotes.isScrollEnabled = true
            notesTextViewHeight.constant = 300
        } else {
//            currentNotes.isScrollEnabled = false
            currentNotes.isScrollEnabled = true
            notesTextViewHeight.constant = newSize.height
        }
        
        notesTextViewHeight.isActive = true
        view.layoutIfNeeded()
        
        //*//        let notesMaxHeight = CGFloat.greatestFiniteMagnitude
        //*//        let notesCurrentHeight = currentNotes.sizeThatFits(CGSize(width: fixedWidth, height: notesMaxHeight))
        
        //        notesTextViewHeight.constant = notesCurrentHeight.height
        //        notesTextViewHeight.constant = notesCurrentHeight.height
        //        notesTextViewHeight.isActive = true
        
        self.view.layoutIfNeeded()
        
        
        print("currentNotes ---> \(currentNotes.text)")
    }
    
    
    var myTapGesture: UITapGestureRecognizer!
    
    @objc private func handleTap(){
        print("**** PICTURE TAPPED ****")
        let tempVC = PictureViewController()
        
        tempVC.myImageView = currentMedia
        navigationController?.pushViewController(tempVC, animated: true)
    }
    
    //MARK:- Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        thumbImage.addGestureRecognizer(myTapGesture)
        
        setupNavigationBar()
        view.backgroundColor = UIColor.lightGray
        useScrollViewConstraints()
    }
}
