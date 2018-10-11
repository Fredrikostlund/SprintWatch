//
//  circleInterfaceController.swift
//  SprintWatch WatchKit Extension
//
//  Created by Fredrik Östlund on 2018-10-11.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import WatchKit
import Foundation


class circleInterfaceController: WKInterfaceController {

    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet weak var circleText: WKInterfaceLabel!
    
    @IBAction func checkInButtonTapped() {
        // 1
        let duration: Double = 3
        //let delay = DispatchTime.now() + (duration + 0.15)
        // 2
        backgroundGroup.setBackgroundImageNamed("Progress")
        // 3
        backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10),
                                                 duration: duration,
                                                 repeatCount: 1)
        startCountdown()
        //circleText.setText("2")
    }
    
    func startCountdown() {
        var countdownTimer = Timer()
        let numbers = [1, 2, 3]
        let count = 0
        
        for i in numbers {
            countdownTimer = Timer.scheduledTimer(withTimeintertavl: 3, repeat: false, block: {circleText.setText(String(3-i))})
        }
        
    }

}
