//
//  ViewController.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/22/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let modalButton = UIButton(type: .system)
    private let subButton = UIButton(type: .system)
    private let bottomSheetButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        setNotiObserver()
    }

    private func setUI() {
        modalButton.setTitle("Modal", for: .normal)
        subButton.setTitle("Sub", for: .normal)
        bottomSheetButton.setTitle("BottomSheet", for: .normal)
        
        [modalButton, subButton, bottomSheetButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 24)
        }
    }
    
    private func setLayout() {
        [modalButton, subButton, bottomSheetButton].forEach({ self.view.addSubview($0) })
        
        modalButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(300)
        }
        
        subButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(modalButton.snp.bottom).offset(40)
        }
        
        bottomSheetButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subButton.snp.bottom).offset(40)
        }
    }
    
    private func setAddTarget() {
        modalButton.addTarget(self, action: #selector(presentModal), for: .touchUpInside)
        subButton.addTarget(self, action: #selector(moveToSub), for: .touchUpInside)
        bottomSheetButton.addTarget(self, action: #selector(presentBottomSheet), for: .touchUpInside)
    }
    
    private func setNotiObserver() {
        NotificationCenter.default.addObserver(
            forName: NotiList.makeNotiName(list: .moveToSub), object: nil, queue: nil
        ) { [weak self] _ in
            self?.moveToSub()
        }
    }
    
    @objc
    func presentModal() {
        let navi = UINavigationController()
        navi.viewControllers = [ModalVC()]
        navi.modalPresentationStyle = .fullScreen
        self.present(navi, animated: true)
    }
    
    @objc
    func moveToSub() {
        navigationController?.pushViewController(SubVC(), animated: true)
    }
    
    @objc
    func presentBottomSheet() {
        showBottomSheet(content: BottomSheetVC())
    }
}
