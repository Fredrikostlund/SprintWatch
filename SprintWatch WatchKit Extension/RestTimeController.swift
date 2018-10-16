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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setPickerItems()
        
        
        // Configure interface objects here.
    }
    
    //sets the items 1 to 60 to rest time Picker
    func setPickerItems(){
        var pickerItems: [WKPickerItem] = []
        
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
    
    @IBOutlet weak var restTimePicker: WKInterfacePicker!
    
}
