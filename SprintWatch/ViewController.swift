//
//  ViewController.swift
//  SprintWatch
//
//  Created by Fredrik Östlund on 2018-10-08.
//  Copyright © 2018 Fredrik Östlund. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    //let healthStore = HKHealthStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        authorize()
    }
//    func authorize() {
//        print("I authorize")
//        let allTypes = Set([HKObjectType.workoutType(),
//                            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//                            HKObjectType.quantityType(forIdentifier: .distanceCycling)!,
//                            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//                            HKObjectType.quantityType(forIdentifier: .heartRate)!])
//
//        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { (success, error) in
//            if !success {
//                // Handle the error here.
//            }
//        }
//    }
    
    
//    @IBAction func authorizeHealthKit(_ sender: UIButton) {
//        TestLabel.text = "Changed"
//        print("I funktion")
//        authorize()
//        print("Authorize körd")
//    }
    
    @IBOutlet weak var TestLabel: UILabel!
    @IBAction func ChangeText(_ sender: UIButton) {
        TestLabel.text = "Changed"
    }
}

