//
//  EdiblyView.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct EdiblyView: View {
    
    // Edible calculator object for running program
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    
    // Variable for presenting other views
    enum ActiveSheet: Identifiable {
        case first, second
        
        var id: Int {
            hashValue
        }
    }
    
    @State var activeSheet: ActiveSheet?
    
    
    var body: some View {
        ZStack {
            Color(.systemGray6).edgesIgnoringSafeArea([.top,.bottom])
            VStack(alignment: .center) {
                
                Button(action: {
                    activeSheet = .second
                }) {
                    Text("?").font(.system(.largeTitle)).bold().foregroundColor(Color("MainColor"))
                }.sheet(item: $activeSheet) { item in
                    switch item {
                    case .first:
                        ContentView()
                    case .second:
                        ExplanationSheet()
                    }
                }
                
                HStack {
                    VStack {
                        Text("THC")
                        thcTextField()
                    }
                    VStack {
                        Text("CBD")
                        cbdTextField()
                    }
                }
                weightTextField()
                unitsTextField()
                VStack {
                    
                    Slider(value: $ediblyCalc.conversionFactor, in: 0...100, step: 1
                    
                    ).accentColor(Color("DarkMainColor"))
                    
                    Text("Conversion Factor: \(ediblyCalc.conversionFactor.clean)")
                }
                
                HStack {
                    Button(action: {
                        ediblyCalc.Calculate()
                    }) {
                        CalculateButton()
                    }
                    
                }.padding()
                
                VStack {
                    HStack {
                        VStack {
                            Text("THC mg in Batch:")
                            Text("\(ediblyCalc.THCinBatch)mg").bold()
                        }
                        
                        VStack {
                            Text("CBD mg in Batch:")
                            Text("\(ediblyCalc.CBDinBatch)mg").bold()
                        }
                    }
                    
                    VStack {
                        Text("Total Cannabinoids per serving")
                        Text("\(ediblyCalc.THCinServing)mg THC").bold()
                        Text("\(ediblyCalc.CBDinServing)mg CBD").bold()
                    }.padding()
                }
            }.padding().padding(.leading).padding(.trailing)
            
        }
        .onAppear(perform: {
            activeSheet = .first
        })
    }
        
}

struct EdiblyView_Previews: PreviewProvider {
    static var previews: some View {
        EdiblyView().environmentObject(EdiblyCalc())
    }
}


extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
