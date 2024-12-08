//
//  NoteDetailsView.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import Foundation
import SwiftUI

struct NoteDetailsView: View {
    @State var content: Note
    @ObservedObject var model = NodeDetailsViewModel()

    var body: some View {
        VStack {

            VStack {
                TextField("Enter note title", text: self.$content.title)
                    .textFieldStyle(.roundedBorder)
                TextField("Enter note description", text:  self.$content.content)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            Button("Edit Note") {
                Task {
                    await self.model.editNote(newNode: self.content)
                }
            }
            Button("Delete Note") {
                Task {
                    await self.model.deleteNode(nodeId: self.content.id)
                }
            }
            Spacer()
        }
        .padding()

    }
}
