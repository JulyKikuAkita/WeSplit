//
//  ContentView.swift
//  WeSplit
//
//  Created by Ifang Lee on 9/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercenttage = 2 //table index
    @State private var saleTaxPercenttage = "8.63" //percentage

    let tipPercentages = [10, 15, 20, 25, 0]

    var totoalTax: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let salesTaxPercent = (Double(saleTaxPercenttage) ?? 0 ) / 100

        let salesTaxAmount = orderAmount * salesTaxPercent
        return salesTaxAmount
    }

    var totoalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercenttage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue + totoalTax
        return grandTotal
    }

    var totoalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0
        let amountPerPerson = totoalAmount / peopleCount
        return amountPerPerson
    }

    // if 0% tip, change tip text to red
    var noTip : Bool {
        tipPercentages[tipPercenttage] == 0 ? true : false
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.decimalPad)

//                    Picker("Number of people", selection: $numberOfPeole){
//                        ForEach(2 ..< 100){
//                            Text("\($0) people")
//                        }
//                    }

                    HStack{
                        Text("Sales Tax% ")
                        Spacer()
                        TextField("Sales Tax Percentage", text: $saleTaxPercenttage)
                            .keyboardType(.decimalPad)
                    }
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercenttage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header:Text("Total tax")) {
                    Text("$\(totoalTax, specifier: "%.2f")")
                        .foregroundColor(noTip ? .red : .black)
                }

                Section(header:Text("Total amount")) {
                    Text("$\(totoalAmount, specifier: "%.2f")")
                }

                Section(header:Text("Amount per person")) {
                    Text("$\(totoalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
