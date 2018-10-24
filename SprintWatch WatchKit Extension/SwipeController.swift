import WatchKit
import Foundation
import UserNotifications


class SwipeController: WKInterfaceController {
    
    //@IBOutlet weak var myTimer: WKInterfaceTimer!
    var timer = TimerController()
    var status: Bool = false
    
    fileprivate var is_paused: Bool = false

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        super.willActivate()
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    
    @IBOutlet weak var laps: WKInterfaceLabel!
    var number: Int = 1
    
    @IBAction func pauseButton() {
    
        // TEST
        
        let is_Val = timer.myTimer
        print("isval: \(is_Val?.isValid ?? false)")
        
      
        let userdee = UserDefaults.standard
        var is_playing: Bool = userdee.bool(forKey: "is_playing")
        userdee.synchronize()
        if is_playing {
           
            print("system playing")
            
            let userInfo = ["command": "stop_the_timer"] as [String: String] // you could also transfer data
            NotificationCenter.default.post(name: .handle, object: nil, userInfo: userInfo)
            
            print("HELLO")
            print("timer: ",is_Val)
            
            number += 1
            let xNSNumber = number as NSNumber
            let xString : String = xNSNumber.stringValue
            print("stringvalue: ", xString)
            laps.setText(String(number))
            
             //userdee.set(false, forKey: "is_playing")
        } else {
            // userdee.set(true, forKey: "is_playing")
            print("not playing, setting up")
            let userInfo = ["command": "play_the_timer"] as [String: String] // you could also 
            NotificationCenter.default.post(name: .handle, object: nil, userInfo: userInfo)
            
            

        }
       
    }
    
    
}

extension UserDefaults {
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}

extension Notification.Name {
    static let handle = Notification.Name("handle")
}
