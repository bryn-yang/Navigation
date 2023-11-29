//
//  BottomSheetVC.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/27/23.
//

import UIKit
import SnapKit

class BottomSheetContentVC: UIViewController {
    weak var bottomSheetDelegate: BottomSheetDelegate?
}

class BottomSheetVC: BottomSheetContentVC {
    
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let closeButton = UIButton(type: .system)
    private let okButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTargeet()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "타이틀"
        titleLabel.font = .systemFont(ofSize: 24)
        
        subTitleLabel.text = "추가 링크 누르기"
        subTitleLabel.font = .systemFont(ofSize: 20)
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        closeButton.setTitle("닫기", for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 20)
        
        okButton.setTitle("확인", for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private func setLayout() {
        [titleLabel, subTitleLabel, buttonStackView].forEach { view.addSubview($0) }
        [closeButton, okButton].forEach { buttonStackView.addArrangedSubview($0) }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(40)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(30)
        }
    }
    
    private func setAddTargeet() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func closeButtonTapped() {
        bottomSheetDelegate?.dismissButtonTapped(completion: nil)
    }
    
    @objc
    private func okButtonTapped() {
        bottomSheetDelegate?.dismissButtonTapped(completion: {
            NotificationCenter.default.post(name: NotiList.makeNotiName(list: .moveToSub), object: nil)
        })
    }
}
