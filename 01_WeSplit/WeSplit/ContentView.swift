//
//  ContentView.swift
//  WeSplit
//
//  Created by Adam Lyon on 5/9/25.
//

import SwiftUI

enum TipSelectionType: String, CaseIterable {
    case preselected, custom
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var tipSelectionType : TipSelectionType = .preselected
    @FocusState private var textFieldFocused : Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var validatedTipPercentage: Int {
        max(0, min(tipPercentage, 100))
    }
    
    var tipTotal : Double {
        let tipSelection = Double(validatedTipPercentage)
        let tipTotal = checkAmount / 100 * tipSelection
        return tipTotal
    }
    
    var tipString : String {
        let tipTotalString = tipTotal.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
        let formattedTipString = "Tip Total: \(tipTotalString)"
        return formattedTipString
    }
    
    var checkTotal : Double {
        //Calculate total check
        let grandTotal = checkAmount + tipTotal
        return grandTotal
    }
    
    var totalPerPerson : Double {
        //Calc total per person
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = checkTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Check Amount") {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($textFieldFocused)
                }
                
                Section("Number of People") {
                    Picker("", selection: $numberOfPeople) {
                        ForEach(2..<11) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("", selection: $tipSelectionType) {
                        ForEach(TipSelectionType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    switch tipSelectionType {
                    case .preselected:
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    case .custom:
                        TextField("Tip Percentage", value: $tipPercentage, format: .percent)
                            .keyboardType(.decimalPad)
                            .focused($textFieldFocused)
                            .onChange(of: tipPercentage) {
                                tipPercentage = max(0, min(tipPercentage, 100))
                            }
                            
                    }
                }
                
                Section("Tip Total") {
                    Text(tipString)
                }
                
                Section("Check Total") {
                    Text(checkTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                }
            }
            .navigationTitle("WeSplit")
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
