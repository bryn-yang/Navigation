//
//  ExtraView.swift
//  Navigation-SwiftUI
//
//  Created by bryn on 11/22/23.
//

import SwiftUI
import Combine

struct ExtraView: View {
    
    enum Navigation {
        case sub
    }
    
    @State var path: [Navigation] = []
    
    var body: some View {
        // 💥 Crash
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("ExtraView")
                
                Button("subview") {
                    path.append(.sub)
                }
            }
            .navigationDestination(for: Navigation.self) { navi in
                switch navi {
                case .sub: SubView()
                }
            }
        }
    }
}
