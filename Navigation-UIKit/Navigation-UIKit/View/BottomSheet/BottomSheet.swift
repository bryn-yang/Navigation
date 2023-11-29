//
//  BottomSheet.swift
//  Navigation-UIKit
//
//  Created by bryn on 11/27/23.
//

import UIKit

class BottomSheet: UIViewController {

    private let contentVC: BottomSheetContentVC
    private let dimmerView = UIView()
    private let bottomSheetView = UIView()
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    private var height: CGFloat = UIScreen.main.bounds.width * 300 / 375
    
    init(contentVC: BottomSheetContentVC) {
        self.contentVC = contentVC
        super.init(nibName: nil, bundle: nil)
        contentVC.bottomSheetDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showBottomSheet()
    }
    
    private func setUI() {
        view.backgroundColor = .clear
        dimmerView.backgroundColor = .black.withAlphaComponent(0.6)
        dimmerView.alpha = 0.6
        
        addChild(contentVC)
        bottomSheetView.addSubview(contentVC.view)
        contentVC.didMove(toParent: self)
        
        bottomSheetView.backgroundColor = .black
        bottomSheetView.layer.cornerRadius = 20
        bottomSheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setLayout() {
        view.addSubview(dimmerView)
        view.addSubview(bottomSheetView)
        
        dimmerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let topConst = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        
        bottomSheetView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(topConst)
        }
        
        self.view.layoutIfNeeded()
        
        contentVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setTapGesture() {
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(dimmerViewTapped(_:)))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
    }
    
    private func showBottomSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let statusBarHeight: CGFloat = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
        let topConstant = safeAreaHeight - statusBarHeight - height
        
        bottomSheetView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(topConstant)
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideBottomSheetAndGoBack(compleetion: (() -> Void)? = nil) {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        let topConstant = safeAreaHeight + bottomPadding
        
        bottomSheetView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(topConstant)
            make.bottom.equalToSuperview().offset(topConstant)
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmerView.alpha = 0.0
            self.view.layoutIfNeeded()
        }, completion: {_ in
            guard self.presentingViewController != nil else { return }
            self.dismiss(animated: true, completion: compleetion)
        })
    }
    
    @objc
    private func dimmerViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheetAndGoBack()
    }
}

extension BottomSheet: BottomSheetDelegate {
    func dismissButtonTapped(completion: (() -> Void)?) {
        hideBottomSheetAndGoBack(compleetion: completion)
    }
}
