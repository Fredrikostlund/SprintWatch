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
    
    
    @IBAction func PauseButton() {
        
        
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
