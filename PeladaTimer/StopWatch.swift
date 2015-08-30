//
//  StopWatch.swift
//  PeladaTimer
//
//  Created by Felipe on 29/08/2015.
//  Copyright (c) 2015 fastman. All rights reserved.
//

import Foundation

func timeIntervalToString(ti: NSTimeInterval) -> String? {
    let dcf = NSDateComponentsFormatter()
    dcf.zeroFormattingBehavior = .Pad
    dcf.allowedUnits = (.CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond)
    return dcf.stringFromTimeInterval(ti)
}

public struct StopWatch {
    
    private var startTime: NSDate?
    private var accumulatedTime: NSTimeInterval = 0.0
    
    public var elapsedTimeInterval: NSTimeInterval {
        get {
            return self.accumulatedTime + NSDate().timeIntervalSinceDate(self.startTime ?? NSDate())
        }
    }
    
    public var elapsedTimeString: String {
        get {
            return timeIntervalToString(self.elapsedTimeInterval) ?? "00:00:00"
        }
    }
    
    public mutating func start() {
        self.startTime = NSDate()
    }
    
    public mutating func stop() {
        self.accumulatedTime += NSDate().timeIntervalSinceDate(self.startTime ?? NSDate())
        self.startTime = nil
    }
    
    public mutating func reset() {
        self.accumulatedTime = 0.0
        self.start()
    }
}