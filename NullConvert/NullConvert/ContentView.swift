//
//  ContentView.swift
//  NullConvert
//
//  Created by Adam Lyon on 5/12/25.
//

import SwiftUI

enum PressureOptions: String, CaseIterable {
    case torr = "torr",
         mtorr = "mTorr",
         bar = "barg",
         psi = "psig",
         pascals = "pa",
         kilopascals = "kPa"
}

struct ContentView: View {
    // let conversionDict: [PressureOptions: Double] =
    // [.torr: 1000.0,
    //  .mtorr: 1.0,
    //  .bar: 750061.673,
    //  .psi: 51714.9,
    //  .pascals: 7.50062,
    //  .kilopascals: 7500.62]
    
    @State private var inputPressure : Double = 0
    @State private var inputPressureSelection : PressureOptions = .torr
    @State private var outputPressureSelection : PressureOptions = .kilopascals
    
    @FocusState private var textFieldFocused : Bool
    
    
    func getConversionUnitValue(unit: PressureOptions) -> Double {
        switch unit {
        case .torr:
            return 1000.0

        case .mtorr:
            return 1.0

        case .bar:
            return 750061.673

        case .psi:
            return 51714.9

        case .pascals:
            return 7.50062

        case .kilopascals:
            return 7500.62
        }
    }

    var inputToMilliTorr : Double {
        //let inputConversionFactor = conversionDict[inputPressureSelection]
        //let inputToMilliTorr = inputPressure * inputConversionFactor! // Force unwrap cause I know it is there

        let inputConversionFactor = getConversionUnitValue(unit: inputPressureSelection)
        let inputToMilliTorr = inputPressure * inputConversionFactor
        return inputToMilliTorr
    }
    
    var convertedPressure : Double {
        
        // let outputConversionFactor = conversionDict[outputPressureSelection]
        // let milliTorrToOutput = inputToMilliTorr / (outputConversionFactor!)

        let outputConversionFactor = getConversionUnitValue(unit: outputPressureSelection)
        let milliTorrToOutput = inputToMilliTorr / outputConversionFactor
        return milliTorrToOutput
    }
    
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Input Pressure", value: $inputPressure, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($textFieldFocused)
                    Picker("Units", selection: $inputPressureSelection) {
                        ForEach(PressureOptions.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output") {
                    Picker("Units", selection: $outputPressureSelection) {
                        ForEach(PressureOptions.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Converted Value") {
                    Text("\(convertedPressure.formatted(.number.precision(.fractionLength(2)))) \(outputPressureSelection.rawValue)")
                }
            }
            .navigationTitle("NullConvert")
            .toolbar {
                if textFieldFocused {
                    Button("Done") {
                        textFieldFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
