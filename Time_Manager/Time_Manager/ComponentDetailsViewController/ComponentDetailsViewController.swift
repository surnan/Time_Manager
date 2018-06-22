//
//  ComponentDetailsViewController.swift
//  Time_Manager
//
//  Created by admin on 6/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import AVFoundation

//class ComponentDetailsViewController: UIViewController {

class ComponentDetailsViewController: UIViewController {
    
    //MARK:- Parameters passed in
    var myDelegate: manipulatingComponentsListViewController? //passed-in
    var parentTask: TaskItem?   //passed-in
    var currentComponentItem: ComponentItem? {  //passed-in
        didSet {
            if let notes = currentComponentItem?.cNotes {currentNotes.text = notes}
            if let website = currentComponentItem?.cWebsite {currentWebsite = website}
            if let media = currentComponentItem?.cMedia {currentMedia = media}
        }
    }
    
    //MARK:- Local declared parameters loaded up from incoming variables
    lazy var myScrollView: UIScrollView = {
        let v = UIScrollView()
        v.backgroundColor = .cyan
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var currentNotes: UITextView = {
        var tempTextView = UITextView()
        tempTextView.backgroundColor = UIColor.white
        tempTextView.textColor = UIColor.black
        tempTextView.font = UIFont.boldSystemFont(ofSize: 20)
        tempTextView.isEditable = false
        tempTextView.isScrollEnabled = false
//                tempTextView.isScrollEnabled = true; tempTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        tempTextView.translatesAutoresizingMaskIntoConstraints = false
        return tempTextView
    }()
    
    var buttonWebsite: UIButton = {
        var tempButton = UIButton()
        tempButton.setTitle("LOAD WEBSITE", for: .normal)
        tempButton.setTitleColor(UIColor.black, for: .normal)
        tempButton.backgroundColor = UIColor.white
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        return tempButton
    }()
    
    var currentWebsite: String?
    var currentMedia: Data?
    
    //MARK:- Setup Navigation Bar
    private func setupNavigationBar(){
        navigationItem.title = "\(parentTask?.name ?? "") --> \(currentComponentItem?.cName ?? "")"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(handleRightBarButton))
    }
    
    
    @objc private func handleRightBarButton(){
        print("Right Button Selected")
    }
    
    
    private func useScrollableContraints(){
        view.addSubview(myScrollView)
        myScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        myScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        myScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        myScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        
        [currentNotes, buttonWebsite].forEach{myScrollView.addSubview($0)}
        currentNotes.topAnchor.constraint(equalTo: myScrollView.topAnchor, constant: 5).isActive = true
        currentNotes.leftAnchor.constraint(equalTo: myScrollView.leftAnchor, constant: 5).isActive = true
        currentNotes.rightAnchor.constraint(equalTo: myScrollView.rightAnchor, constant: -5).isActive = true
    }
    
    private func noScrollViewConstraints(){
        [currentNotes, buttonWebsite].forEach{view.addSubview($0)}
        currentNotes.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        currentNotes.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        currentNotes.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
//        currentNotes.heightAnchor.constraint(equalToConstant: 800).isActive = true
    }
    
    //MARK:- Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = UIColor.lightGray
        print("currentNotext.text --> \(currentNotes.text ?? "")")
        
        
        [currentNotes].forEach{view.addSubview($0)}
        currentNotes.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        currentNotes.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        currentNotes.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        
//        noScrollViewConstraints()
//        useScrollableContraints()
    }
}
