//
//  NotesListView.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import SwiftUI

enum NotesListOption: Int {
    case addNote
}

struct NotesListView: View {

   @StateObject var viewModel = NotesViewModel()

    var body: some View {
        VStack {
            List(viewModel.list, id: \.id) { item in
                NavigationLink(value: item) {
                    ContentViewRow(model: item)
                }
            }
            .listStyle(.plain)
            .padding(.horizontal, 20)
            .onAppear {
                Task {
                    await self.viewModel.notesList()
                }
            }
            Button {
              
            } label: {
                NavigationLink(value: NotesListOption.addNote) {
                    Text("Add Note")
                }
            }
            Spacer()
        }
        .navigationBarTitle("Notes List", displayMode: .inline)
        .navigationDestination(for: NotesListOption.self) { content in
            AddNoteView()
        }
    }
}

struct ContentViewRow: View {
    let model: Note
    var body: some View {
        Text("Title: \(model.title)")
    }
}
