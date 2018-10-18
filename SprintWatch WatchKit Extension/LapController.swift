//
//  SettingsController.swift
//  SprintWatch WatchKit Extension
//
//  Created by Martin Sjölund on 2018-10-11.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class LapController: WKInterfaceController{
    
    var lapIndex = 0
    var pickerItems: [WKPickerItem] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setPickerItems()
        // Configure interface objects here.
    }
    
    //sets the items 1 to 10 to lap Picker
    func setPickerItems(){
        
        for i in 1...10{
            let item = WKPickerItem()
            item.title = String(i)
            pickerItems.append(item)
        }
        
        lapPicker.setItems(pickerItems)
    }

    //Sends lap count to next view trough segue
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        
        if segueIdentifier == "lapId"{
            print(lapIndex)
            return lapIndex+1
        }
        
        return 0
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Outlet to Picker where you can choose number of laps
    @IBOutlet weak var lapPicker: WKInterfacePicker!
    
    @IBAction func pickerChanged(_ value: Int){
        lapIndex = value
    }
    
}