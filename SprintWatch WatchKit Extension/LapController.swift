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
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        setPickerItems()
        // Configure interface objects here.
    }
    
    //sets the items 1 to 10 to lap picker
    func setPickerItems(){
        var pickerItems: [WKPickerItem] = []
        
        for i in 1...10{
            print(i)
            let item = WKPickerItem()
            item.title = String(i)
            pickerItems.append(item)
        }
        
        lapPicker.setItems(pickerItems)
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBOutlet weak var lapPicker: WKInterfacePicker!
    
    //Label tagged "Next", works as button to next view
    @IBOutlet weak var NextLabel: WKInterfaceLabel!
  
    
}
