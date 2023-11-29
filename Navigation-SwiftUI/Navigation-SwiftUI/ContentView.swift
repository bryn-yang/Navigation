//
//  ContentView.swift
//  Navigation-SwiftUI
//
//  Created by bryn on 11/22/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    public enum Navigation: Hashable {
        case sub
        case extra
    }
    
    @State var isModalPresented: Bool = false
    @State var isBottomSheetPresented: Bool = false
    @State var path: [Navigation] = []
    @State var text: String = "test"
    
    private var moveToOther = PassthroughSubject<Navigation, Never>()
    
    var body: some View {
        NavigationStack(path: $path) {
            NavigationView {
                VStack(spacing: 30) {
                    Button("Modal") {
                        isModalPresented.toggle()
                    }
                    
                    Button("Sub") {
                        path.append(.sub)
                    }
                    
                    Button("Extra") {
                        path.append(.extra)
                    }
                    
                    Button("BottomSheet") {
                        isBottomSheetPresented.toggle()
                    }
                }
                .navigationDestination(for: Navigation.self, destination: { navi in
                    switch navi {
                    case .sub: SubView()
                    case .extra: ExtraView()
                    }
                })
            }
            .fullScreenCover(isPresented: $isModalPresented, content: {
                ModalView()
            })
            .sheet(isPresented: $isBottomSheetPresented, content: {
                BottomSheetView(moveToOther: moveToOther)
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
            })
            .onReceive(moveToOther.eraseToAnyPublisher(), perform: { navi in
                switch navi {
                case .sub: path.append(.sub)
                case .extra: path.append(.extra)
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
