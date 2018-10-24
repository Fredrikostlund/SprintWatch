//
//  MotionController.swift
//  SprintWatch WatchKit Extension
//
//  Created by Martin Sjölund on 2018-10-23.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class MotionController: WKInterfaceController {
    var manager: CMMotionActivityManager!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if CMMotionActivityManager.isActivityAvailable(){
            manager = CMMotionActivityManager()
            print("hej")
            manager.startActivityUpdates(to: OperationQueue.main, withHandler: { (data) in
                print("kalle")
                if let values = data{
                    print("1")
                    if values.walking{
                        self.motionLabel.setText("Walking")
                        print("walking")
                    }
                    else if values.running{
                        self.motionLabel.setText("Running")
                        print("running")
                    }
                    else{
                        self.motionLabel.setText("No Activity")
                        print("no activity")
                    }
                }
            })
        }
        else{
            print("Motion Activity not avalable")
        }
        
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
    @IBOutlet weak var motionLabel: WKInterfaceLabel!
    
}

