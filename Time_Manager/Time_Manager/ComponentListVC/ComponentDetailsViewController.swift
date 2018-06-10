//
//  ComponentDetailsViewController.swift
//  Time_Manager
//
//  Created by admin on 6/5/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class ComponentDetailsViewController: UIViewController, UITextViewDelegate {
    
    var componentPicture : UIImageView = {
       let tempImage = UIImageView()
        tempImage.image = #imageLiteral(resourceName: "water")
        tempImage.translatesAutoresizingMaskIntoConstraints = false
        tempImage.widthAnchor.constraint(equalToConstant: 250).isActive = true
        tempImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return tempImage
    }()
    
    
    var textHeightConstraint: NSLayoutConstraint!
    
    var componentText : UITextView = {
        let tempText = UITextView()
        tempText.text = "Hello World"
        tempText.sizeToFit()
        tempText.textAlignment = .center
        tempText.textColor = UIColor.white
        tempText.backgroundColor = UIColor.darkBlue
        tempText.isScrollEnabled = false
        tempText.translatesAutoresizingMaskIntoConstraints = false
        tempText.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        tempText.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return tempText
    }()
    
    //MARK:- UI Functions
    private func setupNavBar(){
        navigationItem.title = "ComponentDetails VC"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }

    func textViewDidChange(_ textView: UITextView) {
        self.adjustTextViewHeight()
    }
    
    func adjustTextViewHeight() {
        let fixedWidth = componentText.frame.size.width
        let newSize = componentText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.textHeightConstraint.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- Swift Built In Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = UIColor.lightGray
        
        textHeightConstraint = componentText.heightAnchor.constraint(equalToConstant: 40)
        textHeightConstraint.isActive = true
        
        componentText.delegate = self
        
        
        [componentPicture, componentText].forEach{view.addSubview($0)}

        componentPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        componentPicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50 ).isActive = true
        
        componentText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        componentText.topAnchor.constraint(equalTo: componentPicture.bottomAnchor, constant: 50).isActive = true
    }
}
