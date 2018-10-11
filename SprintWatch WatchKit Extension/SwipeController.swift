//
//  SwipeController.swift
//  SprintWatch WatchKit Extension
//
//  Created by oscar thorwid on 2018-10-10.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

//
//  Timer.swift
//  SprintWatch WatchKit Extension
//
//  Created by oscar thorwid on 2018-10-10.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class SwipeController: WKInterfaceController {
    
    var timer = TimerController()
    
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
    
    @IBAction func PauseButton() {
       TimerController().timerOutlet.stop()
    }
    
}
