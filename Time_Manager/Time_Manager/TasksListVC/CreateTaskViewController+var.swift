//
//  CreateTaskViewController.swift
//  Time_Manager
//
//  Created by admin on 5/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit


class CreateTaskViewController: UIViewController {
    
    
    var delegate: TasksListViewController?
    
    var nameLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "Name: "
        tempLabel.font = UIFont.boldSystemFont(ofSize: 25)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var nameTextField: UITextField = {
        let tempTextField = UITextField()
        tempTextField.clearsOnBeginEditing = true
        tempTextField.placeholder = "Please enter name here"
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        return tempTextField
    }()

    var timeLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.text = "TIME"
        tempLabel.font = UIFont.boldSystemFont(ofSize: 20)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        return tempLabel
    }()
    
    var timeDatePicker: UIDatePicker = {
        let tempDatePicker = UIDatePicker()
        tempDatePicker.datePickerMode = .time
        tempDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return tempDatePicker
    }()
    
    func setupDayLabel(label: UILabel, name: String) -> UILabel {
        let tempLabel = label
        tempLabel.text = name
        return tempLabel
    }
    
    func setupDaySwitch(switch: UISwitch) -> UISwitch {
        let tempSwitch = UISwitch()
        tempSwitch.isOn = false
        return tempSwitch
    }
    
    var sundayLabel = UILabel(), mondayLabel = UILabel(), tuesdayLabel = UILabel(), wednesdayLabel = UILabel(),
        thursdayLabel = UILabel(), fridayLabel = UILabel(), saturdayLabel = UILabel()

    var sundaySwitch = UISwitch(), mondaySwitch = UISwitch(), tuesdaySwitch = UISwitch(), wednesdaySwitch = UISwitch(),
        thursdaySwitch = UISwitch(), fridaySwitch = UISwitch(), saturdaySwitch = UISwitch()
}


