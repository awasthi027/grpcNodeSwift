//
//  NotesViewModel.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import Foundation

class NotesViewModel: ObservableObject {

    @Published var list: [Note] = []
    
    func notesList() async {
       let items = await GRPCManager.shared.listOfNotes()
        DispatchQueue.main.async {
            self.list = items
        }
    }
}
