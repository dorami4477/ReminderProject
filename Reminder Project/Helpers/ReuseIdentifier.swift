//
//  ReuseIdentifier.swift
//  Reminder Project
//
//  Created by 박다현 on 7/2/24.
//

import UIKit

protocol ReuseIdentifierProtocol{
    static var identifier:String { get }
}


extension UITableViewCell:ReuseIdentifierProtocol{
    static var identifier:String{
        return String(describing: self)
    }
}

extension UIViewController:ReuseIdentifierProtocol{
    static var identifier:String{
        return String(describing: self)
    }
}

