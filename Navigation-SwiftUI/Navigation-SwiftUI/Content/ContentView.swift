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
    @State var isExtraPresented: Bool = false
    @State var path: [Navigation] = []
    @State var text: String = "test"
    
    private var moveToOther = PassthroughSubject<Navigation, Never>()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 30) {
                Button("Modal") {
                    isModalPresented.toggle()
                }
                
                Button("Sub") {
                    path.append(.sub)
                }
                
                Button("BottomSheet") {
                    isBottomSheetPresented.toggle()
                }
                
                Button("Extra(💥)") {
                    path.append(.extra)
                }
                
                Button("NavigationStack 위에 NavigationStack") {
                    withOutAnimation {
                        isExtraPresented.toggle()
                    }
                }
            }
            .navigationDestination(for: Navigation.self, destination: { navi in
                switch navi {
                case .sub: SubView()
                case .extra: ExtraView()
                }
            })
        }
        .onChange(of: path, perform: {
            print("contentView path: \($0)")
        })
        .fullScreenCover(isPresented: $isExtraPresented, content: {
            ContainerView()
                .setBackgroundClear()
        })
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

extension View {
    func withOutAnimation(action: @escaping () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            action()
        }
    }
}

#Preview {
    ContentView()
}
