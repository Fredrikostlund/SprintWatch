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

        // Configure interface objects here.
    }
    
    

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Lap picker outlet
    @IBOutlet var lapPicker: WKInterfacePicker!
    
    //Label tagged "Next", works as button to next view
    @IBOutlet weak var NextLabel: WKInterfaceLabel!
  
    
}
