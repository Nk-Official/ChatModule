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
    
    var second = 0
    var minute = 0
    var hour = 0
    
    var time: String{
        
        if hour != 0{
            return [hour,minute,hour].map({String($0)}).joined(separator: ":")
        }
        else{
            return [minute,hour].map({String($0)}).joined(separator: ":")
        }
        
    }
    
    var triggerAction: ((String)->())?
    
    //MARK: - METHODS
    func startTimer(){
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] (_) in
            self?.triggerSecond()
            self?.triggerAction?(self!.time)
        })
        
    }
    func stopTimer(){
        timer?.invalidate()
    }
    
    func triggerSecond(){
        if second == 60{
            if minute == 60{
                hour += 1
                minute = 0
                second = 0
            }else{
                minute += 1
                second = 0
            }
        }else{
            second += 1
        }
    }
    func resetTimer(){
        hour = 0
        minute = 0
        second = 0
    }
    
}
