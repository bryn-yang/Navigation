//
//  showBottomSheet.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/27/23.
//

import UIKit

extension UIViewController {
    func showBottomSheet(content: BottomSheetContentVC) {
        let bottomsheet = BottomSheet(contentVC: content)
        bottomsheet.modalPresentationStyle =  .overFullScreen
        bottomsheet.modalTransitionStyle = .crossDissolve
        self.present(bottomsheet, animated: true)
    }
}
