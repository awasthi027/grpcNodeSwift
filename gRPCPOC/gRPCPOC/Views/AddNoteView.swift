//
//  AddNoteView.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import SwiftUI

struct AddNoteView: View {
    @ObservedObject var model = AddNoteModel()

    @State private var noteTitle: String = ""
    @State private var noteDescription: String = ""

    var body: some View {

        VStack {
            VStack {
                TextField("Enter note title", text: self.$noteTitle)
                TextField("Enter note description", text: self.$noteDescription)
            }
            .padding()
            Button("Add Note") {
                Task {
                    var newNode = Note()
                    newNode.title = self.noteTitle
                    newNode.content = self.noteDescription
                    await self.model.addNote(newNode: newNode)
                }
            }
            Spacer()
            Text("Id: \(self.model.addedNewNote.id)\nTitle: \(self.model.addedNewNote.title)\nDecription: \(self.model.addedNewNote.content)")

        }
    }
}

#Preview {
    AddNoteView()
}
