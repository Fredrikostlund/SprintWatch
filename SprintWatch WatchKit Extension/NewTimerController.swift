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
    
    
    @IBOutlet weak var pulseLabel: WKInterfaceLabel!
    
    
    var currentLap: Int = 0
    var laps: Int = 0
    var restTime: Int = 0
    var activeTimer = Timer()
    var pulseTimer = Timer()
    
    let activeSeconds = 8
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //extract laps and rest time from context value
        let s = String(describing: context ?? "none")
        let arr = s.split(separator: " ")
        laps = Int(arr[0]) ?? 0
        restTime = Int(arr[1]) ?? 0
        
        //If containing currentLap from RestController
        if(arr.count == 3){
            currentLap = Int(arr[2]) ?? 0
            print(currentLap)
        }
        
        setLabelText()
        
        //Start timer
        isFinished()
        timerOutlet.start()
        timeToRest()

        
        // Configure interface objects here.
    }
    
    //Sets timer to start rest
    func timeToRest(){
        /*
         *---TIMER CODE HERE---*
         */
        activeTimer = Timer.scheduledTimer(timeInterval: TimeInterval(activeSeconds), target: self, selector: #selector(NewTimerController.startRest), userInfo: nil, repeats: false)
        
        pulseTimer = Timer.scheduledTimer(timeInterval: TimeInterval(activeSeconds/2), target: self, selector: #selector(NewTimerController.setPulse), userInfo: nil, repeats: false)
        
    }
    
    //sets lap label to current lap and max laps (current/max)
    func setLabelText(){
        currentLap += 1
        
        var s = String("Lap ")
        s.append(String(currentLap))
        s.append("/")
        s.append(String(laps))
        
        lapLbl.setText(s)
    }
    
    @objc func setPulse() {
        pulseLabel.setText("164")
    }
    
    //Starts rest, sends current lap, number of laps and restTime to RestController
    @objc func startRest(){
        
        var s = String(laps)
        s.append(" ")
        s.append(String(restTime))
        s.append(" ")
        s.append(String(currentLap))
        print(s,"startRest()")
        
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
    
    func isFinished() {
        if (currentLap == laps)  {
            WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "FinishedController", context: laps as AnyObject)])
        }
    }
    
    @IBOutlet weak var lapLbl: WKInterfaceLabel!
    @IBOutlet weak var timerOutlet: WKInterfaceTimer!

    
}
