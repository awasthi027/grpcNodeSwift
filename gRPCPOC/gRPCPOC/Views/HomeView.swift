//
//  ContentView.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 02/12/24.
//

import SwiftUI

enum HomeNavigationOption: Int {
    case noteList
}

struct HomeView: View {
    
    @ObservedObject var model = HomeViewModel()

    var body: some View {
        VStack {
            Text(self.model.greetingMessage)
                .font(.headline)
            Button {

            } label: {
                NavigationLink(value: HomeNavigationOption.noteList) {
                    Text("Notes List")
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
            case .noteList:
                NotesListView()
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
