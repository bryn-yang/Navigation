//
//  ContainerView.swift
//  Navigation-SwiftUI
//
//  Created by bryn on 11/30/23.
//

import SwiftUI

enum ContainerNavigation: Hashable {
    case extra
    case sub
}

struct ContainerView: View {
    
    @State private var path: [ContainerNavigation] = []
    @State private var firstInit: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color.gray.opacity(0)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    path.append(.extra)
                }
            }
            .navigationDestination(for: ContainerNavigation.self) { navi in
                switch navi {
                case .extra:
                    ModalExtraView(path: $path)
                        .onDisappear {
                            if path.count < 2 {
                                dismiss()
                            }
                        }
                case .sub:
                    ExtraSubView()
                        .background(.yellow)
                }
            }
            .onChange(of: path) { newValue in
                if newValue.isEmpty {
                    dismiss()
                }
            }
        }
    }
}

#Preview(body: {
    ContainerView()
})
