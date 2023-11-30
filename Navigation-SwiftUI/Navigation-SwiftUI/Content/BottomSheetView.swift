//
//  BottomSheetView.swift
//  Navigation-SwiftUI
//
//  Created by bryn on 11/22/23.
//

import SwiftUI
import Combine

struct BottomSheetView: View {
    @Environment(\.dismiss) var dismiss
    private var moveToOther: PassthroughSubject<ContentView.Navigation, Never>
    
    init(moveToOther: PassthroughSubject<ContentView.Navigation, Never>) {
        self.moveToOther = moveToOther
    }
    
    var body: some View {
        VStack(spacing: 30, content: {
            Text("타이틀")
                .font(.title)
            
            Text("추가 링크")
            
            HStack(spacing: 40, content: {
                Button("확인(Sub로 이동)") {
                    moveToOther.send(.sub)
                    dismiss()
                }
                
                Button("확인(Extra로 이동)") {
                    moveToOther.send(.extra)
                    dismiss()
                }
            })
            .padding()
            
            Button("닫기") {
                dismiss()
            }
        })
    }
}

#Preview {
    BottomSheetView(moveToOther: .init())
}
