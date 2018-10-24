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
    @IBOutlet weak var heartRateLabel: WKInterfaceLabel!
    
    
    var countdownTimer = Timer()
    var times:Int = 0
    var timer = Timer()
    
    //Heart Rate test
    let healthStore = HKHealthStore()
    let heartRateUnit = HKUnit(from: "count/min")
    var currenQuery : HKQuery?
    //@IBOutlet weak var heartLabel: WKInterfaceLabel!
    
    
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
    public func subscribeToHeartBeatChanges() {

        // Creating the sample for the heart rate
        print("Creating the sample for the heart rate")
        guard let sampleType: HKSampleType =
            HKObjectType.quantityType(forIdentifier: .heartRate) else {
                return
        }

        /// Creating an observer, so updates are received whenever HealthKit’s
        // heart rate data changes.
        print("Creating an observer, so updates are received whenever HealthKit’s heart rate data changes.")
        let heartRateQuery = HKObserverQuery.init(
            sampleType: sampleType,
            predicate: nil) { [weak self] _, _, error in
                guard error == nil else {
                    print("Error")
                    return
                }

                /// When the completion is called, an other query is executed
                /// to fetch the latest heart rate
                print("When the completion is called, an other query is executed to fetch the latest heart rate")
                self?.fetchLatestHeartRateSample(completion: { sample in
                    guard let sample = sample else {
                        print("gick fel i kall på fetchlatestheartratesample")
                        return
                    }

                    /// The completion in called on a background thread, but we
                    /// need to update the UI on the main.
                    print("Innan DispatchQueue.main.async")
                    DispatchQueue.main.async {
                        print("I DispatchQueue.main.async")

                        print("Converting the heart rate to bpm")
                        /// Converting the heart rate to bpm
                        let heartRateUnit = HKUnit(from: "count/min")
                        let heartRate = sample
                            .quantity
                            .doubleValue(for: heartRateUnit)
                        
                        print(heartRate)
                        print(heartRateUnit)

                        /// Updating the UI with the retrieved value
                        print("Updating the UI with the retrieved value")
                        self?.heartRateLabel.setText("\(Int(heartRate))")
                        self?.RestLabel.setText("Heart")
                        print("\(Int(heartRate)) Testar skriva ut heartrate")
                    }
                })
                
        }
        healthStore.execute(heartRateQuery)
        print("Query kört i subscribe")
    }

    public func fetchLatestHeartRateSample(
        completion: @escaping (_ sample: HKQuantitySample?) -> Void) {
        print("Create sample type for the heart rate")
        /// Create sample type for the heart rate
        guard let sampleType = HKObjectType
            .quantityType(forIdentifier: .heartRate) else {
                completion(nil)
                return
        }

        /// Predicate for specifiying start and end dates for the query
        print("Predicate for specifiying start and end dates for the query")
        let predicate = HKQuery
            .predicateForSamples(
                withStart: Date.distantPast,
                end: Date(),
                options: .strictEndDate)

        /// Set sorting by date.
        
        let sortDescriptor = NSSortDescriptor(
            key: HKSampleSortIdentifierStartDate,
            ascending: false)

        /// Create the query
        let query = HKSampleQuery(
            sampleType: sampleType,
            predicate: predicate,
            limit: Int(HKObjectQueryNoLimit),
            sortDescriptors: [sortDescriptor]) { (_, results, error) in

                guard error == nil else {
                    print("Error: \(error!.localizedDescription)")
                    return
                }
                completion(results?[0] as? HKQuantitySample)
        }
        print("Kör query")
        self.healthStore.execute(query)
        print("Query kört")
    }
    //Redirect to active interval after rest interval is finished
    func endOfRest(){
        RestLabel.setText("Spring")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        //TODO move all code related to circle to Willactivate()
        super.willActivate()
        subscribeToHeartBeatChanges()
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
