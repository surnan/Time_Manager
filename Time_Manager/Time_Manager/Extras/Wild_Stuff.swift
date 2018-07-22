//
//  Wild_Stuff.swift
//  Time_Manager
//
//  Created by admin on 7/22/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import MobileCoreServices  // --> kUTTypeMovie

class Wild_Stuff: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var myLabel : UILabel = {
        var tempLabel = UILabel()
        tempLabel.text = "WILD_STUFF VIEW CONTROLLER LOADED"
        tempLabel.textColor = UIColor.black
        tempLabel.backgroundColor = UIColor.white
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var myAlbumButton: UIButton = {
        var tempButton = UIButton()
        tempButton.setTitleColor(UIColor.white, for: .normal)
        tempButton.setTitle("PRESS FOR Pictures", for: .normal)
        tempButton.backgroundColor = UIColor.black
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        return tempButton
    }()
    
    var myVideoButton: UIButton = {
        var tempButton = UIButton()
        tempButton.setTitleColor(UIColor.white, for: .normal)
        tempButton.setTitle("PRESS FOR Videos", for: .normal)
        tempButton.backgroundColor = UIColor.blue
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        return tempButton
    }()
    
    //MARK:- Button Action Code
    
    @objc func handleAlbumButtonPressed(){
        let videoPicker = UIImagePickerController()
        videoPicker.delegate = self
        videoPicker.sourceType = .photoLibrary  //enum [camera, savedPhotosAlbum ]
//        videoPicker.mediaTypes = [kUTTypeMovie as String]
        self.present(videoPicker, animated: true, completion: nil)
        
    }

    @objc func handleVideoButtonPressed(){
        let videoPicker = UIImagePickerController()
        videoPicker.delegate = self
        videoPicker.sourceType = .photoLibrary  //enum [camera, savedPhotosAlbum ]
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        self.present(videoPicker, animated: true, completion: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightBlue
        
        myAlbumButton.addTarget(self, action: #selector(handleAlbumButtonPressed), for: .touchDown)
        myVideoButton.addTarget(self, action: #selector(handleVideoButtonPressed), for: .touchDown)
        
        [myLabel, myAlbumButton, myVideoButton].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myAlbumButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 100),
            myAlbumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myAlbumButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            myVideoButton.topAnchor.constraint(equalTo: myAlbumButton.bottomAnchor, constant: 100),
            myVideoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myVideoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
            
            ])
    }
}
