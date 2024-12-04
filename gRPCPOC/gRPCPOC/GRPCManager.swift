//
//  GRPCManager.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 02/12/24.
//

import Foundation
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf

class GRPCManager {

    private let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    static let shared = GRPCManager()
    private let client: NoteServiceAsyncClient?

    //"127.0.0.1:3500"
    // Making connection to local host
    private init() {
        let channel = ClientConnection(configuration: .default(target: ConnectionTarget.hostAndPort("127.0.0.1", 3500),
                                                               eventLoopGroup: group))
        self.client = NoteServiceAsyncClient(channel: channel)
    }

    func greetingMessage() async -> String {

        let calloption = CallOptions(eventLoopPreference: .indifferent)
           // Make the RPC call to the server.
        var greetingInput = GreetingInput()
        greetingInput.name = "Ashish Awasthi"
        let greetingMessage = try? await self.client?.greeting(greetingInput,
                                                      callOptions: calloption)
        guard let message = greetingMessage?.message else { return "" }
        return message
    }

    func listOfNotes() async -> [Note] {
        let calloption = CallOptions(eventLoopPreference: .indifferent)
           // Make the RPC call to the server.
        let notesList = try? await self.client?.getNotes(Empty(), callOptions: calloption)
        guard let notes = notesList?.notes else { return [] }
        return notes
    }

    func addNote(newNode: Note) async -> Note? {
        let calloption = CallOptions(eventLoopPreference: .indifferent)
           // Make the RPC call to the server.
        let addNode = try? await self.client?.addNote(newNode,
                                                      callOptions: calloption)
        guard let note = addNode else { return nil }
        return note
    }

    func editNote(newNode: Note) async -> Note? {
        let calloption = CallOptions(eventLoopPreference: .indifferent)
           // Make the RPC call to the server.
        let addNode = try? await self.client?.editNote(newNode,
                                                      callOptions: calloption)
        guard let note = addNode else { return nil }
        return note
    }
}
