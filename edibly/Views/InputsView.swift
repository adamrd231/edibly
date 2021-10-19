//
//  InputsView.swift
//  edibly
//
//  Created by Adam Reed on 9/10/21.
//

import SwiftUI
import GoogleMobileAds

struct InputsView: View {
    
    // Edible calculator object for running program
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    // Store Manager object for making in app purchases
    @StateObject var storeManager: StoreManager
    
    @State var activeSheet: ActiveSheet?
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case resultsView, decarbView
        
        var id: Int {
            hashValue
        }
    }
    
    var body: some View {
        
        ZStack {
            // Add an image here to show in the background.
            
            List {
                Section(header: Text("Cannabinoids")) {
                    HStack {
                        Text("THC").bold().font(.title3)
                        thcTextField()
                    }
                    
                    HStack {
                        Text("CBD").bold().font(.title3)
                        cbdTextField()
                    }
                }
                
                Section(header: Text("Decarboxylation")) {
                    // Slider and conversion Factor
                    Slider(value: $ediblyCalc.conversionFactor, in: 0...100, step: 1
                    )
                        .accentColor(Color("DarkMainColor"))
                    HStack {
                        Text("Conversion Factor: \(ediblyCalc.conversionFactor.clean)")
                        Button(action: {
                            activeSheet = .decarbView
                        }) {
                            Text("?")
                                .bold()
                                .foregroundColor(Color("MainColor"))
                        }
                    }
                }
                
                Section(header: Text("Dosage Variables")) {
                    weightTextField()
                    unitsTextField()
                }
               
                Section(header: HStack {
                    Text("Calculate")
                }) {
                    
                    Button(action: {
                        // Calculate using the given inputs
                        ediblyCalc.Calculate()
                        
                        // Update the active sheet to the results view
                        activeSheet = .resultsView
                    }) { CalculateButton() }
                }
                
            }
            .sheet(item: $activeSheet) { item in
                switch item {
                case .resultsView:
                    ResultsView(storeManager: storeManager)
                case .decarbView:
                    DecarbExplanationQuestionMarkView()
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}


struct InputsView_Previews: PreviewProvider {
    static var previews: some View {
        InputsView(storeManager: StoreManager()).environmentObject(EdiblyCalc())
    }
}
