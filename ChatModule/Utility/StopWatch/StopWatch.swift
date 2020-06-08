//
//  StopWatch.swift
//  ChatModule
//
//  Created by user on 29/05/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//

import Foundation
class StopWatch {
    
    //MARK: - PROPERTIES
    var timer: Timer?
    
    var second: Double = -1
//    var minute = 0
//    var hour = 0
//
    var time: String{
        time(time: second)
    }
    
    var intialValue: Double = -1
    var triggerAction: ((String)->())?
    
    init(intialValue: Double = -1){
        self.intialValue = intialValue
    }
    //MARK: - METHODS
    func startTimer(){
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.second += 1
            self?.triggerAction?(self!.time)
        })
        
    }
    func time(time: TimeInterval)->String{
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        if hours > 0{
            return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
        return String(format:"%01i:%02i", minutes, seconds)
    }
    func isStopWatchAtZero()->Bool{
        return second == 0
    }
    func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    func resetTimer(){
        second = -1
    }
    func pauseTimer(){
        timer?.invalidate()
    }
}
