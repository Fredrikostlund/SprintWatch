//
//  NewTimerController.swift
//  SprintWatch WatchKit Extension
//
//  Created by oscar thorwid on 2018-10-23.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class NewSwipeController: WKInterfaceController {
    
    @IBOutlet weak var PauseOutlet: WKInterfaceButton!
    @IBOutlet weak var StopOutlet: WKInterfaceButton!
    @IBOutlet weak var LockOutlet: WKInterfaceButton!
    @IBOutlet weak var EditOutlet: WKInterfaceButton!
    
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
    
    @IBAction func StopButton() {
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "FinishedController", context: "none" as AnyObject)])
    }
    
    
    
}

