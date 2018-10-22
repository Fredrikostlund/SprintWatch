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
import HealthKit


class RestController: WKInterfaceController {
    
    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet weak var RestTimer: WKInterfaceTimer!
    @IBOutlet weak var RestLabel: WKInterfaceLabel!
    
    var countdownTimer = Timer()
    var times:Int = 0
    var timer = Timer()
    
    //Heart Rate test
    let healthStore = HKHealthStore()
    
    var currenQuery : HKQuery?
    @IBOutlet weak var heartLabel: WKInterfaceLabel!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let date = Date.init(timeIntervalSinceNow: 10)
        
        RestTimer.setDate(date)
        RestTimer.start()
        
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false, block: { (Timer) in
            self.endOfRest()
        })
        
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            let heartRateQuantityType = HKObjectType.quantityType(forIdentifier: .heartRate)!
            let allTypes = Set([HKObjectType.workoutType(),
                                heartRateQuantityType
                ])
            healthStore.requestAuthorization(toShare: nil, read: allTypes) { (result, error) in
                if let error = error {
                    // deal with the error
                    print(error)
                    return
                }
                guard result else {
                    // deal with the failed request
                    return
                }
                // begin any necessary work if needed
            }
        }

        // Configure interface objects here.
    }

    //Redirect to active interval after rest interval is finished
    func endOfRest(){
        RestLabel.setText("Spring")
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
