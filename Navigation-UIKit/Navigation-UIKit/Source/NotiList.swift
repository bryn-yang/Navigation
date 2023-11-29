//
//  NotiList.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/27/23.
//

import Foundation

enum NotiList: String {
    case moveToSub
    
    static func makeNotiName(list: Self) -> Notification.Name {
        return Notification.Name(String(describing: list))
    }
}
