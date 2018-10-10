//
//  RestController.swift
//  SprintWatch WatchKit Extension
//
//  Created by Martin Sjölund on 2018-10-10.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class RestController: WKInterfaceController {
    
    var timer = Timer()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        RestTimer.setDate(Date(timeIntervalSinceNow: 30))
        RestTimer.start()
        
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
    
    @IBOutlet weak var RestTimer: WKInterfaceTimer!
}
