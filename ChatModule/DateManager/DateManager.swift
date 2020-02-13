//
//  DateManager.swift
//  ChatModule
//
//  Created by Namrata Khanduri on 11/02/20.
//  Copyright © 2020 Namrata Khanduri. All rights reserved.
//"hh:mm a"
//MMM dd, yyyy

import Foundation

struct DateManager{
    
    enum Day{
        case today
        case yesterday
        case gapFromToday(Int)
    }
    
    var inputDateFormat : String!
    var outputDateFormat : String!
    var outputTimeFormat : String!

    //MARK: - DATE FORMATTORS
    
    lazy var inputDateFormattor : DateFormatter = {
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = inputDateFormat
        return dateformattor
    }()
    lazy var outputDateFormattor : DateFormatter = {
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = outputDateFormat
        return dateformattor
    }()
    lazy var outputTimeFormattor : DateFormatter = {
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = outputTimeFormat
        return dateformattor
    }()
    
    
    //MARK: - METHODS
    mutating func getCurrentDate()->String{
        return outputDateFormattor.string(from: Date())
    }
    mutating func getCurrentTime()->String{
        return outputTimeFormattor.string(from: Date())
    }
    func getCurrentDateTime()->String{
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = [outputDateFormat,outputTimeFormat].joined(separator: " ")
        return dateformattor.string(from: Date())
    }
    mutating func getDate(from string : String)->Date?{
         return inputDateFormattor.date(from: string)
    }
    mutating func getTime(from string : String)->String?{
        convertFormat(from: string, fromFormat: inputDateFormat, toFormat: outputTimeFormat)
    }
    mutating func getDate(from string : String)->String?{
        convertFormat(from: string, fromFormat: inputDateFormat, toFormat: outputDateFormat)
    }
    
    func convertFormat(from string: String,
                       fromFormat : String? = nil,
                       toFormat: String? = nil)->String{
        
        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = fromFormat ?? inputDateFormat
        
        guard let date = dateFormattor.date(from: string) else {
            return string
        }
        
        dateFormattor.dateFormat = toFormat ?? outputDateFormat
        return dateFormattor.string(from: date)
    }
    mutating func convertToDate(from string : String)->Date?{ // input string is in input date format
        return inputDateFormattor.date(from: string)
    }
    
    mutating func daysFromTodaysDate(from date : String)->Day?{
        guard let date = convertToDate(from: date)else{
            return nil
        }
        return daysFromTodaysDate(from: date)
    }
    
    mutating func daysFromTodaysDate(from date : Date)->Day?{
        guard let currentDate = outputDateFormattor.date(from: getCurrentDate())else{
            return nil
        }
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for: currentDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        if let day = components.day{
            if day == 0{
                return .today
            }
            if day == 1{
                return .yesterday
            }
            return .gapFromToday(day)
        }
        return nil
    }
}
