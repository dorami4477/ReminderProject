//
//  DateExtension.swift
//  Reminder Project
//
//  Created by 박다현 on 7/5/24.
//

import Foundation


class GetDate{
    
    static let shared = GetDate()
    private init(){}
    
    func toDate(_ from: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: from) {
            return date
        } else {
            return nil
        }
    }
    
    func getToday() -> String{
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy. MM. dd"
        let dateString = myFormatter.string(from: Date())
        return dateString
    }
    
    func dateCompare(fromDate: Date) -> String {
        var strDateMessage:String = ""
        let result:ComparisonResult = fromDate.compare(Date())
        switch result {
        case .orderedAscending:
            strDateMessage = "Future"
            break
        case .orderedDescending:
            strDateMessage = "Past"
            break
        case .orderedSame:
            strDateMessage = "Same"
            break
        default:
            strDateMessage = "Error"
            break
        }
        return strDateMessage
    }
    
}
