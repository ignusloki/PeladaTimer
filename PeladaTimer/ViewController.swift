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
    
    var localNotification:UILocalNotification = UILocalNotification()
    var toPass:String!
    var startTime = NSTimeInterval()
    var timer = NSTimer()
    let shareData = SharingManager.sharedInstance

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
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }    
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
    }
    
    func updateTime() {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        var savedElapsedTime = Int(elapsedTime)
        
        //calculate the hour
        let hours = Int(elapsedTime / 3600)
        elapsedTime -= (NSTimeInterval(hours) * 3600)
        
        //calculate the minutes in elapsed time.
        
        let minutes = Int(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        
        let seconds = Int(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strHour = String(format: "%02d", hours)
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        
        displayTimeLabel.text = "\(strHour):\(strMinutes):\(strSeconds)"
        
        if let timeMax = shareData.timeMax {
        
            if savedElapsedTime == timeMax * 60 && timeMax != 0 {
                
                localNotification.alertAction = "Alarme do Timer!"
                localNotification.alertBody = "Acabou o tempo!!"
                localNotification.soundName = UILocalNotificationDefaultSoundName;
                localNotification.fireDate = NSDate(timeIntervalSinceNow: 0)
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
                
                timer.invalidate()
                var alert = UIAlertController(title: "Alerta", message: "Acabou o tempo!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        if let timeAlarm = shareData.timeAlarm {
            
            if (savedElapsedTime % (timeAlarm * 60)) == 0 && timeAlarm != 0 && minutes != 0 {
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

