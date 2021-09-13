//
//  ContentView.swift
//  WeSplit
//
//  Created by Ifang Lee on 9/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var metricSelection = 0

    enum metrics: String, CaseIterable { case celsius, fahrenheit, kelvin}
    let temperateMetrics = metrics.allCases.map {$0.rawValue}

    var resultFromCelsius: Double {
        let userInput = Double(input) ?? 0
        let userSelectedMetric = metrics(rawValue: temperateMetrics[metricSelection])
        switch userSelectedMetric {
        case .fahrenheit:
            let toFahrenheit = 32 + userInput * 9 / 5
            return toFahrenheit
        case .kelvin:
            let toKelvin = 273.15 + userInput
            return toKelvin
        default:
            return userInput
        }
    }

    var resultFromFahrenheit: Double {
        let userInput = Double(input) ?? 0
        let userSelectedMetric = metrics(rawValue: temperateMetrics[metricSelection])
        switch userSelectedMetric {
        case .celsius:
            let toCelsius = (userInput - 32) * 5 / 9
            return toCelsius
        case .kelvin:
            let toKelvin = 273.15 + (userInput - 32) * 5 / 9
            return toKelvin
        default:
            return userInput
        }
    }

    var resultFromKelvin: Double {
        let userInput = Double(input) ?? 0
        let userSelectedMetric = metrics(rawValue: temperateMetrics[metricSelection])
        switch userSelectedMetric {
        case .celsius:
            let toCelsius = userInput - 273.15
            return toCelsius
        case .fahrenheit:
            let toFahrenheit = 32 + (userInput - 273.15) * 9 / 5
            return toFahrenheit
        default:
            return userInput
        }
    }


    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("Input")) {
                    TextField("temperate", text: $input)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Convering to?")) {
                    Picker("metrics:", selection: $metricSelection) {
                        ForEach(0 ..< metrics.allCases.count) {
                            Text("\(self.temperateMetrics[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header:Text("result")) {
                    Text("\(input) celsius to \(temperateMetrics[metricSelection]): \(resultFromCelsius, specifier: "%.2f")")
                    Text("\(input) fahrenheit to \(temperateMetrics[metricSelection]): \(resultFromFahrenheit, specifier: "%.2f")")
                    Text("\(input) kelvin to \(temperateMetrics[metricSelection]): \(resultFromKelvin, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("Convert Temperature")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
