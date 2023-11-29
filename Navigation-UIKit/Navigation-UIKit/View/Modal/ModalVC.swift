//
//  ModalVC.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/22/23.
//

import UIKit
import SnapKit

class ModalVC: UIViewController {
    
    static let identifier = "ModalVC"
    private let modalLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let switchButton = UIButton(type: .system)
    private let subButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setAddTarget()
        setModal1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUI() {
        self.view.backgroundColor = .white
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        subButton.setTitle("move to submodal", for: .normal)
    }
    
    private func setModal1() {
        modalLabel.text = "ModalView1"
        switchButton.setTitle("modal1", for: .normal)
        subButton.isHidden = true
    }
    
    private func setModal2() {
        modalLabel.text = "ModalView2"
        switchButton.setTitle("modal2", for: .normal)
        subButton.isHidden = false
    }
    
    private func setLayout() {
        [modalLabel, closeButton, switchButton, subButton].forEach {
            self.view.addSubview($0)
        }
        
        modalLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        switchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(modalLabel.snp.bottom).offset(40)
        }
        
        subButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(switchButton.snp.bottom).offset(40)
        }
    }
    
    private func setAddTarget() {
        closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(tappedSwitchButton), for: .touchUpInside)
        subButton.addTarget(self, action: #selector(tappedSubButton), for: .touchUpInside)
    }
    
    @objc
    func tappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    @objc
    func tappedSwitchButton() {
        if modalLabel.text == "ModalView1" {
            setModal2()
        } else {
            setModal1()
        }
    }
    
    @objc
    func tappedSubButton() {
        self.navigationController?.pushViewController(ModalSubVC(), animated: true)
    }
}

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct MyYellowButtonPreview: PreviewProvider{
//    static var previews: some View {
//        UIViewPreview {
//            return ModalVC()
//        }.previewLayout(.sizeThatFits)
//    }
//}
//#endif
//
//
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//struct UIViewPreview<View: UIView>: UIViewRepresentable {
//    let view: View
//    
//    init(_ builder: @escaping () -> View) {
//        view = builder()
//    }
//    
//    // MARK: - UIViewRepresentable
//    
//    func makeUIView(context: Context) -> UIView {
//        return view
//    }
//    
//    func updateUIView(_ view: UIView, context: Context) {
//        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
//    }
//}
//#endif
