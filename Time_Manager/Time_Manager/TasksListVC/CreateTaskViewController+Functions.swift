//
//  CreateTaskViewController+Functions.swift
//  Time_Manager
//
//  Created by admin on 5/28/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import CoreData

extension CreateTaskViewController  {
    
    //MARK:- UI Functions
    private func setupNavBar(){
        let rightButtonText: String
        if currentTaskItem != nil {
            rightButtonText = "Save Changes"
            navigationItem.title = "Editing Task"
        } else {
            rightButtonText = "Add"
            navigationItem.title = "Create new task"
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButtonText, style: .done, target: self, action:#selector(handleRightBarButton))
    }
    
    @objc private func handleLeftBarButton(){
        print("Handle Left")
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func handleRightBarButton(){
        if currentTaskItem == nil {
            let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
            let myTaskItem = NSEntityDescription.insertNewObject(forEntityName: "TaskItem", into: myViewContext)
            myTaskItem.setValue(nameTextField.text, forKey: "name")
            myTaskItem.setValue(sundaySwitch.isOn, forKey: "sunday")
            myTaskItem.setValue(mondaySwitch.isOn, forKey: "monday")
            myTaskItem.setValue(tuesdaySwitch.isOn, forKey: "tuesday")
            myTaskItem.setValue(wednesdaySwitch.isOn, forKey: "wednesday")
            myTaskItem.setValue(thursdaySwitch.isOn, forKey: "thursday")
            myTaskItem.setValue(fridaySwitch.isOn, forKey: "friday")
            myTaskItem.setValue(saturdaySwitch.isOn, forKey: "saturday")
            
            do {
                try myViewContext.save()
                delegate?.addNewTaskToTableView(myTaskItem: myTaskItem as! TaskItem)
            } catch let saveErr {
                print("Problems saving new Task: \(saveErr)")
            }
        } else {
            let myViewContext = CoreDataManager.shared.persistentContainer.viewContext
            currentTaskItem?.name = nameTextField.text
            currentTaskItem?.sunday = sundaySwitch.isOn
            currentTaskItem?.monday = mondaySwitch.isOn
            currentTaskItem?.tuesday = tuesdaySwitch.isOn
            currentTaskItem?.wednesday = wednesdaySwitch.isOn
            currentTaskItem?.thursday = thursdaySwitch.isOn
            currentTaskItem?.friday = fridaySwitch.isOn
            currentTaskItem?.saturday = saturdaySwitch.isOn
            
            
            
            delegate?.editExistingTaskOnTableView(myTaskItem: currentTaskItem!)
            do {
                try myViewContext.save()
            } catch let editTaskError {
                print("EditTaskError \(editTaskError)")
            }
        }
        navigationController?.popViewController(animated: true)
    }

    //MARK:- Built In Swift Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUserFieldsforDataEntry()
        view.backgroundColor = UIColor.lightYellow
        
        if let myCurrentTask = currentTaskItem {
            sundaySwitch.setOn(myCurrentTask.sunday, animated: false)
            mondaySwitch.setOn(myCurrentTask.monday, animated: false)
            tuesdaySwitch.setOn(myCurrentTask.tuesday, animated: false)
            wednesdaySwitch.setOn(myCurrentTask.wednesday, animated: false)
            thursdaySwitch.setOn(myCurrentTask.thursday, animated: false)
            fridaySwitch.setOn(myCurrentTask.friday, animated: false)
            saturdaySwitch.setOn(myCurrentTask.saturday, animated: false)
        }
    }
    
    
    //MARK: Setting up Fields for User Entry
    private func setupUserFieldsforDataEntry(){
        sundayLabel = setupDayLabel(label: sundayLabel, name: "Sunday"); sundaySwitch = setupDaySwitch(switch: sundaySwitch)
        mondayLabel = setupDayLabel(label: mondayLabel, name: "Monday"); mondaySwitch = setupDaySwitch(switch: mondaySwitch)
        tuesdayLabel = setupDayLabel(label: tuesdayLabel, name: "Tuesday"); tuesdaySwitch = setupDaySwitch(switch: tuesdaySwitch)
        wednesdayLabel = setupDayLabel(label: wednesdayLabel, name: "Wednesday"); wednesdaySwitch = setupDaySwitch(switch: wednesdaySwitch)
        thursdayLabel = setupDayLabel(label: thursdayLabel, name: "Thursday"); thursdaySwitch = setupDaySwitch(switch: thursdaySwitch)
        fridayLabel = setupDayLabel(label: fridayLabel, name: "Friday"); fridaySwitch = setupDaySwitch(switch: fridaySwitch)
        saturdayLabel = setupDayLabel(label: saturdayLabel, name: "Saturday"); saturdaySwitch = setupDaySwitch(switch: saturdaySwitch)
        
        [nameLabel, nameTextField, timeLabel, timeDatePicker, sundayLabel,sundaySwitch,
         mondayLabel, mondaySwitch, tuesdayLabel, tuesdaySwitch, wednesdayLabel, wednesdaySwitch,
         thursdayLabel, thursdaySwitch, fridayLabel, fridaySwitch, saturdayLabel, saturdaySwitch].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 20).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30).isActive = true
        
        timeDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeDatePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10).isActive = true
        timeDatePicker.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        sundaySwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30).isActive = true
        sundaySwitch.topAnchor.constraint(equalTo: timeDatePicker.bottomAnchor, constant: 30).isActive = true
        
        let verticalSpacer: CGFloat = 20
        let horizontalSpacer: CGFloat = -20
        
        mondaySwitch.placeUnderneath(aboveSwitch: sundaySwitch, spacing: verticalSpacer)
        tuesdaySwitch.placeUnderneath(aboveSwitch: mondaySwitch, spacing: (verticalSpacer))
        wednesdaySwitch.placeUnderneath(aboveSwitch: tuesdaySwitch, spacing: (verticalSpacer))
        thursdaySwitch.placeUnderneath(aboveSwitch: wednesdaySwitch, spacing: (verticalSpacer))
        fridaySwitch.placeUnderneath(aboveSwitch: thursdaySwitch, spacing: (verticalSpacer))
        saturdaySwitch.placeUnderneath(aboveSwitch: fridaySwitch, spacing: (verticalSpacer))
        
        sundayLabel.placeLeftofSwitch(thatSwitch: sundaySwitch, spacing: horizontalSpacer)
        mondayLabel.placeLeftofSwitch(thatSwitch: mondaySwitch, spacing: horizontalSpacer)
        tuesdayLabel.placeLeftofSwitch(thatSwitch: tuesdaySwitch, spacing: horizontalSpacer)
        wednesdayLabel.placeLeftofSwitch(thatSwitch: wednesdaySwitch, spacing: horizontalSpacer)
        thursdayLabel.placeLeftofSwitch(thatSwitch: thursdaySwitch, spacing: horizontalSpacer)
        fridayLabel.placeLeftofSwitch(thatSwitch: fridaySwitch, spacing: horizontalSpacer)
        saturdayLabel.placeLeftofSwitch(thatSwitch: saturdaySwitch, spacing: horizontalSpacer)
    }
}
