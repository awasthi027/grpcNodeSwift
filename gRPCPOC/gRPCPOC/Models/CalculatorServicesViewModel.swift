//
//  CalculatorServicesViewModel.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 05/12/24.
//

import Foundation
import GRPC

class CalculatorServicesViewModel: ObservableObject {

    @Published var sumResult: Int32 = 0
    @Published var fibonacciNumbersStr: String = ""
    @Published var averageOfNumbers: Double = 0
    @Published var maxFromGivenNumber: Int32 = 0

    func addNumber(firstNumber: String,
                   secondNumber: String) async {
        let firstNumberInt = Int32(firstNumber) ?? 0
        let secondNumberInt = Int32(secondNumber) ?? 0
        let calloption = CallOptions(eventLoopPreference: .indifferent)
           // Make the RPC call to the server.
        var addRequest = AddRequest()
        addRequest.firstNumber = firstNumberInt
        addRequest.secondNumber = secondNumberInt
        let sumResponse = try? await GRPCManager.shared.calService?.addNum(addRequest,
                                                             callOptions: calloption)
        guard let result = sumResponse?.sumResult else { return }
        DispatchQueue.main.async {
            self.sumResult = result
        }
    }

    func fibonacciNumbers(fibonacciNumber: String)  {
        self.fibonacciNumbersStr = ""
        let numberInt = Int64(fibonacciNumber) ?? 0
        // Make the RPC call to the server.
        var request = FiboRequest()
        request.num = numberInt


        let call = GRPCManager.shared.calService?.fiboSeries(request)
        Task {
            var responseStream = call?.makeAsyncIterator()
            while let response = try await responseStream?.next() {
                DispatchQueue.main.async {
                    self.fibonacciNumbersStr.append(" \(response.num)")
                }
            }
        }
    }

    func computeAverageGivenNumber(number: String) {
        let numbers = number.components(separatedBy: ",")
        // Create an AsyncStream of ComputeAverageRequest
        let requestStream = AsyncStream<ComputeAverageRequest> { continuation in
            numbers.forEach { number  in
                let numberInt = Int32(number) ?? 0
                var request = ComputeAverageRequest()
                request.number = numberInt
                continuation.yield(request)
            }
            continuation.finish()
        }

        // Create an instance of ExampleServiceClient
        let client = GRPCManager.shared.calService
        // Call the computeAverage method
        Task {
        do {
            let response = try await client?.computeAverage(requestStream)
            guard let result = response?.average else { return }
            DispatchQueue.main.async {
                self.averageOfNumbers = result
            }
        } catch {
           print("Error: \(error)")
        }
        }
    }

    func findMaximumNumber()  {

        let number = "1,8,9,4"
        let numbers = number.components(separatedBy: ",")
        // Create an AsyncStream of ComputeAverageRequest
        let requestStream = AsyncStream<FindMaximumRequest> { continuation in
            numbers.forEach { number  in
                let numberInt = Int32(number) ?? 0
                var request = FindMaximumRequest()
                request.number = numberInt
                continuation.yield(request)
            }
            continuation.finish()
        }
        // Create a client
        let client = GRPCManager.shared.calService
        let call = client?.findMaximum(requestStream)
        Task {
            var responseStream = call?.makeAsyncIterator()
            while let response = try await responseStream?.next() {
                DispatchQueue.main.async {
                    print("response.maximum: \(response.maximum)")
                }
            }
        }
    }

}
