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
    var body: some View {

        VStack {
            VStack(spacing: 10) {
                TextField("Enter first number", text: self.$firstNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                TextField("Enter second number", text: self.$secondNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)

                Button("Add Number") {
                    Task {
                        await self.model.addNumber(firstNumber: self.firstNumber,
                                                   secondNumber: self.secondNumber)
                    }
                }
                .padding()
                Text("Calculated Sum is: \(self.model.sumResult)")
                    .padding()
            }
            .padding()

            VStack(spacing: 10) {
                TextField("Enter Number", text: self.$fibonacciNumber)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
                Button("Calculate fibonacci series") {
                    self.model.fibonacciNumbers(fibonacciNumber: self.fibonacciNumber)
                }
                .padding()
                Text("Series number are: \(self.model.fibonacciNumbersStr)")
            }
            VStack(spacing: 10) {
                TextField("Enter number to find average Ex. 1,2,3", text: self.$numbers)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
                Button("Get average of numbers") {
                    self.model.computeAverageGivenNumber(number: self.numbers)
                }
                .padding()
                Text("Here are the numbers: \(self.numbers)\nAverage: \(self.model.averageOfNumbers)")
            }

            VStack(spacing: 10) {
                TextField("Enter number", text: self.$numbers)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .padding()
                Button("Find Maximum Number") {
                    self.model.findMaximumNumber()
                }
                .padding()
                Text("Max number \(self.numbers)\nAverage: \(self.model.averageOfNumbers)")
            }

            Spacer()

        }
    }
}

#Preview {
    CalculatorServicesView()
}
