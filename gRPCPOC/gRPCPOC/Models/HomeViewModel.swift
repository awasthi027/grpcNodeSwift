//
//  HomeViewModel.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 03/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {

    @Published var greetingMessage: String = ""

    func greetingMessage() async {

        let message = await GRPCManager.shared.greetingMessage()
        DispatchQueue.main.async {
            self.greetingMessage = message
        }
    }
}
