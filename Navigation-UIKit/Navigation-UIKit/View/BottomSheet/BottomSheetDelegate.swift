//
//  BottomSheetDelegate.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/27/23.
//

import Foundation

protocol BottomSheetDelegate: AnyObject {
    func dismissButtonTapped(completion: (() -> Void)?)
}
