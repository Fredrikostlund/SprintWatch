import WatchKit
import Foundation
import UserNotifications

class TimerController: WKInterfaceController {
    @IBOutlet weak var timerOutlet: WKInterfaceTimer! //
    
    @IBOutlet weak var simple_timer_label: WKInterfaceLabel!
    var myTimer : Timer?
    var duration : TimeInterval = 1 //arbitrary number. 1 seconds
    
    var isPaused = false //flag to determine if it is paused or not
    var elapsedTime : TimeInterval = 0.0 //time that has passed between
    var number_as_a_timer:Int = 0
    var startTime = NSDate()
    var dim_date = Date()
    var current_minute: Int = 0
    var current_hour: Int = 0
    var curent_second: Int = 0
    
    var initiated = Bool()
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
       
        
        let userdee = UserDefaults.standard
        
        var is_first_time: Bool = userdee.bool(forKey: "is_playing")
        
        if !is_first_time {
            
        }
        
        if myTimer == nil {
            start_timer()
            self.initiated = true
            print("first open. starting")
           // userdee.set(true, forKey: "is_playing")
        }
        
        print("is first_time: \(is_first_time)")
        userdee.synchronize()
        
//        timerOutlet.setTextColor(UIColor.red)
        
        // Configure interface objects here.
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours: Int = Int(time) / 3600
        let minutes: Int = Int(time) / 60 % 60
        let seconds: Int = Int(time) % 60
      
        let com = NSDateComponents()
        com.minute = minutes
        com.second = seconds
        com.hour = hours
        dim_date = NSCalendar.current.date(from: com as DateComponents)!
        self.timerOutlet.setDate(dim_date)
        self.timerOutlet.start()
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func start_timer() {
        let userdee = UserDefaults.standard
        let is_playing = userdee.bool(forKey: "is_playing")
        
        // if the is playing is true, we will not schedule then
        
       // lets work on the first run, first
        
        if let is_valid = myTimer?.isValid {
            if is_valid == true {
                myTimer?.invalidate()
                myTimer = nil
                // i have another solution if this does not work
                print("timer is valid: \(is_valid)")
            }
        }
        
        
        print("start_timer_hit: init:\(initiated), is)play :\(is_playing)")
        if !initiated {
            myTimer = Timer.scheduledTimer(timeInterval: duration, target:
                self,selector: #selector(timerDone), userInfo: nil, repeats:
                true)
            userdee.set(true, forKey: "is_playing")
            self.initiated = true
        }
        
       // timerOutlet.setDate(NSDate(timeIntervalSinceNow: duration ) as
          //  Date)
       // timerOutlet.start()
    }
    @objc private func timerDone(){
    //   print("got hit")
        //timer done counting down
        
        number_as_a_timer += 1
        let output:String = self.timeString(time: TimeInterval(number_as_a_timer))
        self.simple_timer_label.setText(output)
        print(output)
        
        let userdee = UserDefaults.standard
        var is_playing: Bool = userdee.bool(forKey: "is_playing")
        print("is playing: \(is_playing)")
          userdee.synchronize()
        
    }
    @IBAction func pauseResumePressed() { // is this the button when i click pause?
        //timer is paused. so unpause it and resume countdown
        /*
        if isPaused{
            isPaused = false
            myTimer = Timer.scheduledTimer(timeInterval: duration -
                elapsedTime, target: self, selector:
               #selector(timerDone), userInfo:
                nil, repeats: true)
            timerOutlet.setDate(NSDate(timeIntervalSinceNow: duration -
                elapsedTime) as Date)
            timerOutlet.start()
            startTime = NSDate()
            
            print("timer paused: resumming")
            
        }
            //pause the timer
        else{
            isPaused = true
            
            //get how much time has passed before they paused it
            let paused = NSDate()
            elapsedTime += paused.timeIntervalSince(startTime as Date)
            
            //stop watchkit timer on the screen
            timerOutlet.stop()
            
            //stop the ticking of the internal timer
            myTimer!.invalidate()
            
            //do whatever UI changes you need to
            //pauseResumeButton.setTitle("Resume")
        } */
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to
        super.willActivate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle_notification(notification:)), name: .stopTimer, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fullystop(notification:)), name: .handle, object: nil)
        
       
         print("will activate called")
        
    }
    override func didAppear() {
      print("did appear called")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no
        super.didDeactivate()
         print("did deactivate called")
    }
    @objc func fullystop(notification:NSNotification) {
        
        guard let command = notification.userInfo?["command"] as? String else {
            return
        }
        let userdee = UserDefaults.standard
        print("the command is to \(command)")
        if command == "stop_the_timer" {
            
            myTimer?.invalidate()
            myTimer = nil
            
            
            print("timer is running. stopping")
            
            userdee.set(false, forKey: "is_playing")
            
            
        } else if command == "play_the_timer" {
            print("timer is not running.")
            self.initiated = false
            start_timer()
            
            let isp = userdee.bool(forKey: "is_playing")
            if isp {
                
            }
            
            
            
        }
          userdee.synchronize()
     
        /*
        let is_playing: Bool = userdee.bool(forKey: "is_playing")
        if !is_playing {
            print("timer is not running.")
            start_timer()
        }
*/
        
        /*if myTimer != nil {
            myTimer!.invalidate()
            myTimer = nil
            print("timer is running. stopping")
            
        } else {
            
        } */
    }
    @objc func handle_notification(notification:NSNotification) {
       
        print(myTimer?.debugDescription)
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:
            #selector(timerDone), userInfo:
            nil, repeats: true)
        
        
        
    }
    
    @objc func stop_timer(notification:NSNotification) {
        
        // Timer is paused. so unpause it and resume countdown
        if isPaused{
           
            myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:
                    #selector(timerDone), userInfo:
                    nil, repeats: true)
                 self.isPaused = false
        
            print("timer paused: resumming1")
            
            
            
            // the problem is, both states are invoked when trying to stop the timer through another viewcontroller
            
            
            // what are we going to do? we gonna use a compelete new method to acheieve the work through the other viewcontroller. Are you planning to pause the timer on the other viewcontroller only right? gotcha
            
        } else {
            isPaused = true
            print("stoping timer")
            //get how much time has passed before they paused it
            let paused = NSDate()
            elapsedTime += paused.timeIntervalSince(startTime as Date)
            
            //stop watchkit timer on the screen
            timerOutlet.stop()
            
            //stop the ticking of the internal timer
            myTimer!.invalidate()
            
            //do whatever UI changes you need to
            //pauseResumeButton.setTitle("Resume")
        }
    }
}

extension Notification.Name {
    static let stopTimer = Notification.Name("stopTimer")
}
