//
//  PauseController.swift
//  SprintWatch WatchKit Extension
//
//  Created by oscar thorwid on 2018-10-16.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//




import WatchKit
import Foundation
import UIKit


class PauseController: WKInterfaceController {
    
    var first = true
  
    @IBOutlet weak var timer: WKInterfaceTimer!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if first == true{
            //timer.start()
            first = false
        }else{
            print("first = false")
        }
        
        
    }
    // Configure interface objects here.
    
    @IBAction func start() {
        timer.start()
    }
    
    
    @IBAction func pausebutton() {
        timer.stop()
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func buttonAction() {
        
        
    }
}
