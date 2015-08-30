//
//  ConfigViewController.swift
//  PeladaTimer
//
//  Created by Felipe on 22/08/2015.
//  Copyright (c) 2015 fastman. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    
    let shareData = SharingManager.sharedInstance
    
    @IBOutlet weak var displayTimeMax: UILabel!
    @IBOutlet weak var displayTimeAlarm: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let timeMaxLabel = shareData.timeMax {
            
            displayTimeMax.text = "\(shareData.timeMax)"
            
        } else {
            
            displayTimeMax.text = "0"
            
        }
        
        if let timeTimeAlarmLabel = shareData.timeAlarm {
            
            displayTimeAlarm.text = "\(shareData.timeAlarm)"
            
        } else {
            
            displayTimeAlarm.text = "0"
            
        }       
        
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
       
        displayTimeMax.text = "\(Int(sender.value))"
        self.shareData.timeMax = Int(sender.value)
        
    }
    
    @IBAction func displayTimeAlarm(sender: UIStepper) {
        
        displayTimeAlarm.text = "\(Int(sender.value))"
        self.shareData.timeAlarm = Int(sender.value)
        
    }
}