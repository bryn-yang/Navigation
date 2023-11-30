//
//  ModalExtraView.swift
//  Navigation-SwiftUI
//
//  Created by bryn on 11/30/23.
//

import SwiftUI

struct ModalExtraView: View {
    @Binding var path: [ContainerNavigation]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("ExtraView")
            
            Button("subview") {
                path.append(.sub)
            }
        }
    }
}
