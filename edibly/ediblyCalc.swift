//
//  ediblyCalc.swift
//  edibly
//
//  Created by Adam Reed on 7/7/21.
//

import SwiftUI

class EdiblyCalc: ObservableObject, Identifiable {
    
    @Published var thc = ""
    @Published var cbd = ""
    @Published var weight = ""
    @Published var unitsInBatch = ""
    @Published var conversionFactor: Float = 70.0
    
    @Published var THCinBatch = ""
    @Published var CBDinBatch = ""
    @Published var THCinServing = ""
    @Published var CBDinServing = ""
    
    @Published var showedTwentyOneModal = false
 
    func Calculate() {
        
        if weight == "" || unitsInBatch == "" {
            return
        } else {
            if thc == "" {
                thc = "0"
            }
            let floatTHC = Float(thc)
            let floatWeight = Float(weight)
            let floatConversionFactor = Float(conversionFactor)
            let floatUnits = Float(unitsInBatch)
            
            var thcInBatchanswer = String(Int((floatTHC! * floatWeight! * (floatConversionFactor * 0.1))))
            THCinBatch = thcInBatchanswer
            
            var thcInServinganswer = String(Int((floatTHC! * floatWeight! * (floatConversionFactor * 0.1)) / floatUnits!))
            THCinServing = thcInServinganswer
        }
        
        if weight == "" || unitsInBatch == "" {
            return
        } else {
            if cbd == "" {
                cbd = "0"
            }
            
            let floatCBD = Float(cbd)
            let floatWeight = Float(weight)
            let floatConversionFactor = Float(conversionFactor)
            let floatUnits = Float(unitsInBatch)
            
            var cbdInBatchanswer = String(Int((floatCBD! * floatWeight! * (floatConversionFactor * 0.1))))
            CBDinBatch = cbdInBatchanswer
            
            var cbdInServinganswer = String(Int((floatCBD! * floatWeight! * (floatConversionFactor * 0.1)) / floatUnits!))
            CBDinServing = cbdInServinganswer
        }
        
        
        
        
        
      
     
    }
    
    
}
