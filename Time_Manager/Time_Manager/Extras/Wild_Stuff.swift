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
    
    
    func printCoreDataPath(){
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
    }
    
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
    
    
    
    var myImagePickerController: UIImagePickerController = {
        let tempPicker = UIImagePickerController()
        tempPicker.sourceType = .photoLibrary
        tempPicker.allowsEditing = true
//        if let allMedia = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
//            tempPicker.mediaTypes = allMedia
//        }
        return tempPicker
    }()
    
    
    var myImagePickerController2: UIImagePickerController = {
        let tempPicker = UIImagePickerController()
        tempPicker.sourceType = .photoLibrary
        tempPicker.mediaTypes = [kUTTypeMovie as String]
        tempPicker.allowsEditing = false
//        if let allMedia = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
//            tempPicker.mediaTypes = allMedia
//        }
        return tempPicker
    }()

    
    
    //MARK:- Button Action Code
    
    @objc func handleAlbumButtonPressed(){
//        let videoPicker = UIImagePickerController()
//        videoPicker.delegate = self
//        videoPicker.sourceType = .photoLibrary  //enum [camera, savedPhotosAlbum ]
////        videoPicker.mediaTypes = [kUTTypeMovie as String]
//        self.present(videoPicker, animated: true, completion: nil)

        self.present(myImagePickerController, animated: true, completion: nil)
    }

    @objc func handleVideoButtonPressed(){
//        let videoPicker = UIImagePickerController()
//        videoPicker.delegate = self
//        videoPicker.sourceType = .photoLibrary  //enum [camera, savedPhotosAlbum ]
//        videoPicker.mediaTypes = [kUTTypeMovie as String]
//        self.present(videoPicker, animated: true, completion: nil)
        
        self.present(myImagePickerController2, animated: true, completion: nil)
        
    }

    
    
    //MARK:- Image Picker Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){

        if picker == myImagePickerController {
            print("PICKER #1")
        } else {
            print("PICKER #2")
            
            var videoURL: NSURL?
            videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
            print("video URL = \(videoURL!)")
            
        }
        
        //        iconImage.image = info[UIImagePickerControllerEditedImage] != nil ? info[UIImagePickerControllerEditedImage] as? UIImage :
//            info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK:- DEFAULT SWIFT FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightBlue
        
        myImagePickerController.delegate = self
        myImagePickerController2.delegate = self
        
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
