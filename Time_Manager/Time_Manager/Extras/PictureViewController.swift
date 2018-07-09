//
//  PictureViewController.swift
//  Time_Manager
//
//  Created by admin on 6/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    var myImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let myImage = myImageView else {
            print("GUARD LET -- set off--")
            return
        }
        
        myImage.backgroundColor = UIColor.yellow
        myImage.contentMode = .scaleAspectFit
        myImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(myImage)
        
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            myImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            myImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            ])
    }
    
    
}


