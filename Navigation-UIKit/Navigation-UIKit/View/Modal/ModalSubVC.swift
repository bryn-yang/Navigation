//
//  ModalSubVC.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/24/23.
//

import UIKit

class ModalSubVC: UIViewController {
    
    private let subLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        navigationController?.isNavigationBarHidden = false
        
        subLabel.text = "ModalSubVC"
        
        view.addSubview(subLabel)
        
        subLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
