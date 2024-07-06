//
//  FoderList.swift
//  Reminder Project
//
//  Created by 박다현 on 7/3/24.
//

import UIKit

struct Folder{
    var icon:String
    var title:String
    var count:Int
    var color:UIColor
}

final class FolderData{
    static let shared = FolderData()
    private init(){}
    
    var Folderlists:[Folder] = [
        Folder(icon: "calendar", title: "오늘", count: 0, color: AppColor.blue),
        Folder(icon: "calendar.badge.clock", title: "예정", count: 0, color: AppColor.red),
        Folder(icon: "tray.full.fill", title: "전체", count: 0, color: AppColor.gray),
        Folder(icon: "flag.fill", title: "깃발 표시", count: 0, color: AppColor.yellow),
        Folder(icon: "checkmark", title: "완료됨", count: 0, color: AppColor.bluegray)
    ]
}
