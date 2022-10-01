//
//  ContentView.swift
//  UnitConversion
//
//  Created by Tony Capelli on 11/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.00
    @State private var unitInput: Dimension = UnitTemperature.celsius
    @State private var unitOutput: Dimension = UnitTemperature.celsius
    @State private var selectedUnit = 0
    @FocusState private var isFocussed: Bool
    
    var converterType = ["Temperature", "Distance", "Time", "Volume"]
    
    var unitType = [
            [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
            [UnitLength.meters, UnitLength.kilometers,
             UnitLength.inches, UnitLength.feet, UnitLength.yards, UnitLength.miles],
            [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds],
            [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
        ]

    var result: String {
        var inputValue = Measurement(value: input, unit: unitInput).converted(to: unitOutput)
        return inputValue.formatted()
    }
    
    
    var body: some View {
        NavigationView{
            Form{
                
                Section("Che tipo di conversione vuoi fare?"){
                    Picker("Seleziona l'unità", selection: $selectedUnit){
                        ForEach(0..<converterType.count){
                            Text("\(converterType[$0])")
                        }
                    }
                }
                
                Section("Inserisci il valore che vuoi convertire"){
                    TextField("", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocussed)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(Font.system(size: 60, design: .default))
                    
                    Picker("input Unit", selection: $unitInput){
                        ForEach(unitType[selectedUnit], id: \.self){
                            Text(MeasurementFormatter().string(from: $0).capitalized)
                        }
                    }.pickerStyle(.segmented)
            
                }
                
                Section ("Seleziona in che unità vuoi convertire"){
                    Picker("Conversione", selection: $unitOutput){
                        ForEach(unitType[selectedUnit], id: \.self){
                            Text(MeasurementFormatter().string(from: $0).capitalized)
                        }
                    }.pickerStyle(.segmented)
                }

                Section("Risultato conversione"){
                    Text("\(result)")
                }
            }
            .navigationTitle("Conversione da \(MeasurementFormatter().string(from: unitInput)) in \(MeasurementFormatter().string(from: unitOutput))")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Button("Done"){
                        isFocussed = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
