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
    
    
    func getCurrentPath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //        print(urls[urls.count-1] as URL)
        
        let temp = urls[urls.count-1] as URL
        return temp
    }
    
    var currentPath : URL!
    
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
    
    var myShowPicButton: UIButton = {
        var tempButton = UIButton()
        tempButton.setTitleColor(UIColor.white, for: .normal)
        tempButton.setTitle("Show Saved Picture", for: .normal)
        tempButton.backgroundColor = UIColor.black
        tempButton.translatesAutoresizingMaskIntoConstraints = false
        return tempButton
    }()
    
    var myShowVideoButton: UIButton = {
        var tempButton = UIButton()
        tempButton.setTitleColor(UIColor.white, for: .normal)
        tempButton.setTitle("Show Saved Video", for: .normal)
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
        
        var fileManger = FileManager.default
        
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
    
    @objc func handleShowPicButtonPressed(){
        self.present(myImagePickerController, animated: true, completion: nil)
        
    }
    @objc func handleShowVideoButtonPressed(){
        self.present(myImagePickerController2, animated: true, completion: nil)
        
    }
    
    
    
    //MARK:- Image Picker Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if picker == myImagePickerController {
            //            print("PICKER #1")
            var imageURL: NSURL?
            imageURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
            print("\n==\nimage URL = \(imageURL!)")
            
        } else {
            //            print("PICKER #2")
            
            var videoURL: NSURL?
            videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
            print("\n==\nvideo URL = \(videoURL!)")
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
        
        print("getCurrentPath = \(getCurrentPath())")
        
        
        myAlbumButton.addTarget(self, action: #selector(handleAlbumButtonPressed), for: .touchDown)
        myVideoButton.addTarget(self, action: #selector(handleVideoButtonPressed), for: .touchDown)
        myShowPicButton.addTarget(self, action: #selector(handleShowPicButtonPressed), for: .touchDown)
        myShowVideoButton.addTarget(self, action: #selector(handleShowVideoButtonPressed), for: .touchDown)
        
        
        
        [myLabel, myAlbumButton, myVideoButton, myShowPicButton, myShowVideoButton].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            myAlbumButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor  , constant: 70),
            myAlbumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myAlbumButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            myShowPicButton.topAnchor.constraint(equalTo: myAlbumButton.bottomAnchor, constant: 30),
            myShowPicButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myShowPicButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            myVideoButton.topAnchor.constraint(equalTo: myShowPicButton.bottomAnchor, constant: 70),
            myVideoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myVideoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            myShowVideoButton.topAnchor.constraint(equalTo: myVideoButton.bottomAnchor, constant: 30),
            myShowVideoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myShowVideoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            ])
    }
}
