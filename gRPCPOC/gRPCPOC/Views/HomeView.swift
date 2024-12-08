//
//  ContentView.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 02/12/24.
//

import SwiftUI

enum HomeNavigationOption: Int {
    case noteService
    case calculatorService
}

struct HomeView: View {
    
    @ObservedObject var model = HomeViewModel()

    var body: some View {
        VStack {
            Text(self.model.greetingMessage)
                .font(.headline)
            Button { } label: {
                NavigationLink(value: HomeNavigationOption.noteService) {
                    Text("Notes Service Requests")
                }
            }
            Button {} label: {
                NavigationLink(value: HomeNavigationOption.calculatorService) {
                    Text("Calculator Service Requests")
                }
            }
        }
        .padding()
        .onAppear() {
            Task {
                await self.model.greetingMessage()
            }
        }
        .navigationDestination(for: HomeNavigationOption.self) { item in
            switch item {
            case .noteService:
                NotesListView()
            case .calculatorService:
                CalculatorServicesView()
            }
        }
        .navigationDestination(for: Note.self) { item in
            NoteDetailsView(content: item)
        }
        .navigationBarTitle("Home", displayMode: .inline)
        .navigationViewStyle(.automatic)
    }
}

#Preview {
    HomeView()
}
