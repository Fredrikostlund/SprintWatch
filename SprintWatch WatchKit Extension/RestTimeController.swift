//
//  RestTimeController.swift
//  SprintWatch WatchKit Extension
//
//  Created by Martin Sjölund on 2018-10-12.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class RestTimeController: WKInterfaceController{
    
    var pickerItems: [WKPickerItem] = []
    var laps: Any? = 0
    var restTime: Int = 0
    
    var s:String = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //extracts context to laps
        laps = context
        
        setPickerItems()
            
        // Configure interface objects here.
    }
    
    //sets the items 1 to 60 to rest time Picker
    func setPickerItems(){
        
        for i in 1...60{
            let item = WKPickerItem()
            item.title = String(i)
            pickerItems.append(item)
        }
        restTimePicker.setItems(pickerItems)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Redirects user to CountdownController with lap count and rest time as context string
    @IBAction func doneBtn() {
        s.append(String(describing: laps ?? "none"))
        s.append(" ")
        s.append(String(restTime))
        
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "CountdownController", context: s as AnyObject)])
    }
    
    @IBOutlet weak var restTimePicker: WKInterfacePicker!
    
    //Changes timeIndex to value shown on Picker
    @IBAction func RestTimeAction(_ value: Int) {
        restTime = value+1
    }
    
}
