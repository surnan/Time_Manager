//
//  ComponentDetailsViewController.swift
//  Time_Manager
//
//  Created by admin on 6/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import AVFoundation

class ComponentDetailsViewController: UIViewController {
    
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
    
    let buttonWebsite: UIButton = {
        let tempButton = UIButton()
        tempButton.setTitle("LOAD WEBSITE", for: .normal)
        tempButton.setTitleColor(UIColor.black, for: .normal)
        tempButton.backgroundColor = UIColor.lightGray
        tempButton.addTarget(self, action: #selector(handleButtonWebsite), for: .touchDown)
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        return tempButton
    }()
    
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
        print("<----- BUTTON PRESSES ------>")
        
        
        
        
    }
    
    

 
    //MARK:- UI Constraints
    private func useScrollViewConstraints(){
//        let screenSize = UIScreen.main.bounds
        let tempImage = UIImage(data: currentMediaData)
        currentMedia.image = tempImage
        
        [myScrollView2].forEach{view.addSubview($0)}
        [myStackView].forEach{myScrollView2.addSubview($0)}
        [currentNotes, currentMedia, buttonWebsite].forEach{myStackView.addArrangedSubview($0)}
        
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
        }
    
    //MARK:- Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = UIColor.lightGray
        useScrollViewConstraints()
    }
}
