//
//  NodeDetailsViewModel.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import Foundation

class NodeDetailsViewModel: ObservableObject {

    @Published var addedNewNote: Note = Note()

    func editNote(newNode: Note) async  {
        guard let note = await GRPCManager.shared.editNote(newNode: newNode) else { return }
        DispatchQueue.main.async {
            self.addedNewNote = note
        }
    }
    
    func deleteNode(nodeId: String) async  {
        await GRPCManager.shared.deleteNote(nodeId: nodeId)
        DispatchQueue.main.async {
            self.addedNewNote =  Note()
        }
    }
}
