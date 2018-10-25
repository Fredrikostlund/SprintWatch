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
    
    var countdownTimer = Timer()
    var times:Int = 0
    var timer = Timer()
    var restTime: Double = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        getData(context: context)
        
        let date = Date.init(timeIntervalSinceNow: restTime)
        
        RestTimer.setDate(date)
        RestTimer.start()
        
        timer = Timer.scheduledTimer(withTimeInterval: restTime, repeats: false, block: { (Timer) in
            self.endOfRest(context: context)
        })
        // Configure interface objects here.
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
        print(restTime,"RestController")
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let duration: Double = 10
        
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


}
