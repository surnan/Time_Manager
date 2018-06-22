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
    
    /*
     let newVC = CreateComponentViewController()
     newVC.currentComponentItem = components[indexPath.row]
     newVC.parentTask = currentTask
     newVC.delegate = self
     navigationController?.pushViewController(newVC, animated: true)
     */
    
    
    //MARK:- Parameters passed in
    var myDelegate: manipulatingComponentsListViewController? //passed-in
    var parentTask: TaskItem?   //passed-in
    var currentComponentItem: ComponentItem? {  //passed-in
        didSet {
            if let notes = currentComponentItem?.cNotes {
                currentNotes.text = notes
            }
            
            if let website = currentComponentItem?.cWebsite {
                currentWebsite = website
            }
            
            if let media = currentComponentItem?.cMedia {
                currentMedia = media
            }
        }
    }
    
    //MARK:- Local declared parameters loaded up from incoming variables

        lazy var myScrollView: UIScrollView = {
            let sv = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//            sv.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 3)
            
            sv.contentSize = CGSize(width: self.view.frame.size.width, height: 2000)
            
            sv.translatesAutoresizingMaskIntoConstraints = false
            return sv
        }()
        
        
    var currentNotes: UITextView = {
       var tempTextView = UITextView()
        tempTextView.backgroundColor = UIColor.white
        tempTextView.textColor = UIColor.black
        tempTextView.font = UIFont.boldSystemFont(ofSize: 20)
        tempTextView.isEditable = false
        tempTextView.isScrollEnabled = false
//        tempTextView.isScrollEnabled = true; tempTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
    
    
    //MARK:- Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view.backgroundColor = UIColor.lightGray
        
        view.addSubview(myScrollView)
        


        [currentNotes, buttonWebsite, scrollView].forEach{view.addSubview($0)}
        
        currentNotes.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        currentNotes.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currentNotes.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        currentNotes.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        buttonWebsite.topAnchor.constraint(equalTo: currentNotes.bottomAnchor, constant: 30).isActive = true
        buttonWebsite.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        print("currentNotext.text --> \(currentNotes.text ?? "")")
        
        
        
        
    }
    
    
    
    
    
    
    
}
