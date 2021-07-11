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
 
    func Calculate() {
        
        if thc == "" || weight == "" || unitsInBatch == "" {
            return
        } else {
            let floatTHC = Float(thc)
            let floatWeight = Float(weight)
            let floatConversionFactor = Float(conversionFactor)
            let floatUnits = Float(unitsInBatch)
            
            var thcInBatchanswer = String(Int((floatTHC! * floatWeight! * (floatConversionFactor * 0.1))))
            THCinBatch = thcInBatchanswer
            
            var thcInServinganswer = String(Int((floatTHC! * floatWeight! * (floatConversionFactor * 0.1)) / floatUnits!))
            THCinServing = thcInServinganswer
        }
        
        if cbd == "" || weight == "" || unitsInBatch == "" {
            return
        } else {
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
