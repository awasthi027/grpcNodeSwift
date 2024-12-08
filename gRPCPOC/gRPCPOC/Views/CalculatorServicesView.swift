//
//  CalculatorServicesView.swift
//  gRPCPOC
//
//  Created by Ashish Awasthi on 05/12/24.
//

import SwiftUI

struct CalculatorServicesView: View {

    @ObservedObject var model = CalculatorServicesViewModel()
    @State private var firstNumber: String = ""
    @State private var secondNumber: String = ""
    @State private var fibonacciNumber: String = ""
    @State private var numbers: String = ""
    @State private var findMaximumNumber: String = ""
    @State private var enterNumbers: String = ""

    var body: some View {

        VStack {
            VStack(spacing: 8) {
                TextField("Enter first number", text: self.$firstNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .frame(maxHeight: 20)
                TextField("Enter second number", text: self.$secondNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxHeight: 20)
                Button("Add Number") {
                    Task {
                        await self.model.addNumber(firstNumber: self.firstNumber,
                                                   secondNumber: self.secondNumber)
                    }
                }
                .frame(maxHeight: 20)
                Text("Sample gRPC Method\nCalculated Sum is: \(self.model.sumResult)")
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxHeight: 20)
            }
            .padding()

            VStack(spacing: 8) {
                TextField("Enter Number", text: self.$fibonacciNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Button("Calculate fibonacci series") {
                    self.model.fibonacciNumbers(fibonacciNumber: self.fibonacciNumber)
                }
                Text("Server Stream example, Server will give one by one Number\nHere are series number: \(self.model.fibonacciNumbersStr)")
                    .fixedSize(horizontal: false, vertical: true)
            }
            VStack(spacing:  8) {
                TextField("Enter number to find average Ex. 1,2,3", text: self.$numbers)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Button("Get average of numbers") {
                    self.model.computeAverageGivenNumber(number: self.numbers)
                }
                .frame(maxHeight: 20)
                if self.model.averageOfNumbers > 0 {
                    Text("Client Stream, Client write one by number to get average\nHere are the numbers: \(self.numbers)\nAverage: \(self.model.averageOfNumbers)")
                    .fixedSize(horizontal: false, vertical: true)
                }
            }

            VStack(spacing: 8) {
                TextField("Enter number Ex. 5,6,3,2,1,8", text: self.$enterNumbers)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Button("Find Maximum Number") {
                    self.model.findMaximumNumber(number: self.enterNumbers)
                }
                Text("Client and Server Stream Example, Client will write one by one number and server get keep giving max number from geted numbers")
                    .fixedSize(horizontal: false, vertical: true)
                .fixedSize(horizontal: false, vertical: true)
                List(self.model.maxFromGivenNumbers, id: \.self) { item in
                    Text(item)
                }
                .listStyle(.plain)
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    CalculatorServicesView()
}
