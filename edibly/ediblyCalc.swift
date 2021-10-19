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
    @Published var cupsOfBase = ""
    @Published var unitsInBatch = 1
    @Published var conversionFactor: Float = 70.0
    
    @Published var THCinBatch = 0.0
    @Published var CBDinBatch = 0.0
    @Published var THCinServing = ""
    @Published var CBDinServing = ""
    
    var THCperPortion: Double { get { THCinBatch / (Double(unitsInBatch)) } }
    var CBDperPortion: Double { get { CBDinBatch / (Double(unitsInBatch)) } }
    
    @Published var THCperTeaspoon = 0.0
    @Published var CBDperTeaspoon = 0.0
    
 
    func Calculate() {
        
        let THCint = Double(thc) ?? 0
        let CBDint = Double(cbd) ?? 0
        let WeightInt = Double(weight) ?? 1
        let CupsofBaseInt = Double(cupsOfBase) ?? 1
        // Calculate THC in Total Batch
        let calcTHCinBatch = (THCint * WeightInt ) * Double((conversionFactor) * 0.1)
        THCperTeaspoon = calcTHCinBatch / (CupsofBaseInt * 48)
        THCinBatch = calcTHCinBatch
        
        let calcCBDinBatch = (CBDint * WeightInt ) * Double((conversionFactor) * 0.1)
        CBDperTeaspoon = calcCBDinBatch / (CupsofBaseInt * 48)
        CBDinBatch = calcCBDinBatch
        
//        var thcInBatchanswer = String(Int((floatTHC! * floatWeight! * (floatConversionFactor * 0.1))))
    
    }
}
