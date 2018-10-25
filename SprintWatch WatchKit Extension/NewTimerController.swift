//
//  NewTimerController.swift
//  SprintWatch WatchKit Extension
//
//  Created by oscar thorwid on 2018-10-23.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class NewTimerController: WKInterfaceController {
    
    var currentLap: Int = 0
    var laps: Int = 0
    var restTime: Int = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //extract laps and rest time from context value
        let s = String(describing: context ?? "none")
        let arr = s.split(separator: " ")
        laps = Int(arr[0]) ?? 0
        restTime = Int(arr[1]) ?? 0
        
        print(laps)
        print(restTime)
        
        setLabelText()
        
        //Start timer
        timerOutlet.start()
        startRest()
        
        // Configure interface objects here.
    }
    
    //sets lap label to current lap and max laps (current/max)
    func setLabelText(){
        currentLap += 1
        
        var s = String(currentLap)
        s.append("/")
        s.append(String(laps))
        
        lapLbl.setText(s)
    }
    
    //Starts rest, sends current lap, number of laps and restTime to RestController
    func startRest(){
        
        var s = String(laps)
        s.append(" ")
        s.append(String(currentLap))
        s.append(" ")
        s.append(String(restTime))
        print(s)
        
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "RestController", context: s as AnyObject)])
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBOutlet weak var lapLbl: WKInterfaceLabel!
    @IBOutlet weak var timerOutlet: WKInterfaceTimer!

    
}
