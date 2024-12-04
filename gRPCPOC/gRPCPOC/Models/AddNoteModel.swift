//
//  AddNoteModel.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import Foundation

class AddNoteModel: ObservableObject {

    @Published var addedNewNote: Note = Note()

    func addNote(newNode: Note) async  {
        guard let note = await GRPCManager.shared.addNote(newNode: newNode) else { return }
        DispatchQueue.main.async {
            self.addedNewNote = note
        }
    }
}
