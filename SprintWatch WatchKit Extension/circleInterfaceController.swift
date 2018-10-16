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
    var countdownTimer = Timer()
    var times:Int = 0
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        let duration: Double = 3
        
        //Setting background image, and animating through the set
        //Length is the number of images to be animated, edit for smoother animation
        backgroundGroup.setBackgroundImageNamed("progress")
        backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 101),
                                                 duration: duration,
                                                 repeatCount: 1)
        startCountdown()

    }
    
    //Obsolete
    @IBAction func checkInButtonTapped() {
    }
    
    //Timer which handles how long the circle will be animated
    func startCountdown() {
        
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(circleInterfaceController.setRestText), userInfo: nil, repeats: false)
        
    }
    
    //Editing the number counter
    @objc func setRestText() {
        times = times + 1
        if times < 3 {
            circleText.setText(String(3 - times))
            self.startCountdown()
        }
        else {
            circleText.setText("0")
            backgroundGroup.stopAnimating()
        }
        
    }
    
}
