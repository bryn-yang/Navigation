//
//  ModalView.swift
//  Navigation-SwiftUI
//
//  Created by bryn on 11/22/23.
//

import SwiftUI

struct ModalView: View {
    enum ViewType {
        case first
        case second
    }
    
    enum Navigation: Hashable {
        case modalSub
    }
    
    @Environment(\.dismiss) var dismiss
    
    @State var viewType: ViewType = .first
    @State var path: [Navigation] = []
    
    var body: some View {
//        NavigationStack(path: $path) {
        NavigationView {
            ZStack {
                switch viewType {
                case .first:
                    firstView()
                case .second:
                    secondView()
                }
                
                navigationBar()
            }
//            .navigationDestination(for: Navigation.self) { navi in
//                switch navi {
//                case .modalSub: ModalSubView()
//                }
//            }
        }
    }
}

extension ModalView {
    func navigationBar() -> some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .padding()
                })
                
                Spacer()
            }
            Spacer()
        }
    }
    
    func firstView() -> some View {
        VStack(spacing: 30) {
            Text("ModalView - 1")
                .font(.largeTitle)
            
            Button("swipe to Modal2") {
                viewType = .second
            }
        }
    }
    
    func secondView() -> some View {
        VStack(spacing: 30) {
            Text("ModalView - 2")
                .font(.largeTitle)
            
            Button("swipe to Modal1") {
                viewType = .first
            }
            
            Button("ModalSubView") {
                path.append(.modalSub)
            }
        }
    }
}

#Preview {
    ModalView()
}
