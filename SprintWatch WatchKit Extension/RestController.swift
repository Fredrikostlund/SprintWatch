//
//  InterfaceController.swift
//  SprintWatch WatchKit Extension
//
//  Created by Fredrik Östlund on 2018-10-08.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//


import WatchKit
import Foundation
import UIKit


class RestController: WKInterfaceController {
    
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet weak var RestTimer: WKInterfaceTimer!
    @IBOutlet weak var RestLabel: WKInterfaceLabel!
    @IBOutlet weak var pulseLabel: WKInterfaceLabel!
    @IBOutlet weak var lapLabel: WKInterfaceLabel!
    
    var countdownTimer = Timer()
    var times:Int = 0
    var timer = Timer()
    var restTime: Double = 0
    var pulseTimer = Timer()
    var lap = 0
    var currentLap = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        getData(context: context)
        
        let date = Date.init(timeIntervalSinceNow: restTime)
        setLabelText()
        RestTimer.setDate(date)
        RestTimer.start()
        
        timer = Timer.scheduledTimer(withTimeInterval: restTime, repeats: false, block: { (Timer) in
            self.endOfRest(context: context)
        })
        // Configure interface objects here.
        
        pulseTimer = Timer.scheduledTimer(timeInterval: TimeInterval(restTime/2), target: self, selector: #selector(RestController.setPulse), userInfo: nil, repeats: false)
    }
    
    //Redirect to active interval after rest interval is finished
    func endOfRest(context:Any?){
        let values = String(describing: context ?? "none")
        
        WKInterfaceController.reloadRootControllers(withNamesAndContexts: [(name: "TimerController", context: values as AnyObject)])
    }
    
    func getData(context:Any?){
        let s = String(describing: context ?? "none")
        let arr = s.split(separator: " ")
        restTime = Double(arr[1]) ?? 0
        lap = Int(arr[0]) ?? 0
        currentLap = Int(arr[2]) ?? 0
        print(restTime,"RestController")
        
    }
    @objc func setPulse() {
        pulseLabel.setText("118")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let duration: Double = restTime
        
        //Setting background image, and animating through the set
        //Length is the number of images to be animated, edit for smoother animation
        backgroundGroup.setBackgroundImageNamed("progress")
        backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 101),
                                                 duration: duration,
                                                 repeatCount: 1)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func setLabelText(){

        var s = ""
        s.append(String(currentLap))
        s.append("/")
        s.append(String(lap))
        
        lapLabel.setText(s)
    }

}
