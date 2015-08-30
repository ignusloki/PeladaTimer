//
//  ViewController.swift
//  PeladaTimer
//
//  Created by Felipe on 21/08/2015.
//  Copyright (c) 2015 fastman. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    let shareData = SharingManager.sharedInstance
    
    var localNotification:UILocalNotification = UILocalNotification()
    var timer = NSTimer()
    var stopWatch : StopWatch = StopWatch()

    @IBOutlet weak var displayTimeLabel: UILabel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func start(sender: AnyObject) {
        
        if !timer.valid {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
            self.stopWatch.start()
        }
    }    
    
    @IBAction func stop(sender: AnyObject) {
        self.stopWatch.stop()
    }
    
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: Int = Int(stopWatch.elapsedTimeInterval)
        
        displayTimeLabel.text = "\(stopWatch.elapsedTimeString)"
        
        if let timeMax = shareData.timeMax {
        
            if elapsedTime == timeMax * 60 && timeMax != 0 {
                
                localNotification.alertAction = "Alarme do Timer!"
                localNotification.alertBody = "Acabou o tempo!!"
                localNotification.soundName = UILocalNotificationDefaultSoundName;
                localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
                self.stopWatch.stop()
                timer.invalidate()
                
                var alert = UIAlertController(title: "Alerta", message: "Acabou o tempo!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        if let timeAlarm = shareData.timeAlarm {
            
            if (elapsedTime % (timeAlarm * 60)) == 0 && timeAlarm != 0 && timer.valid {
                println("Intervalo de Alarme acionado!!")
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                localNotification.alertAction = "Alarme do Timer!"
                localNotification.alertBody = "Intervalo acionado!!"
                localNotification.soundName = UILocalNotificationDefaultSoundName;
                localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
            }
            
        }
        
    }

}

