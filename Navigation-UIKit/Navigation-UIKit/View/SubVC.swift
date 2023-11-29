//
//  SubVC.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/24/23.
//

import UIKit

class SubVC: UIViewController {
    
    private let subLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        subLabel.text = "SubVC"
    }

    private func setLayout() {
        view.addSubview(subLabel)
        
        subLabel.snp
            .makeConstraints { make in
                make.center.equalToSuperview()
            }
    }
}
