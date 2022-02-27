//
//  ediblyCalc.swift
//  edibly
//
//  Created by Adam Reed on 7/7/21.
//

import SwiftUI

struct EdibleCalcModel:Identifiable, Hashable {
    
    var id = UUID()
    var strainName = ""
    var recipeNotes = ""
    var thc = ""
    var cbd = ""
    var weight = ""
    var cupsOfBase = ""
    var unitsInBatch = ""
    var conversionFactor: Float = 70.0
    
    
    var THCinBatch: Double {
        if
            let THCint = Double(thc),
            let WeightInt = Double(weight)
        {
            return THCint * WeightInt * (Double(conversionFactor) * 0.1)
        } else {
            print("Error getting thc in batch")
            return 0
        }
    }

    var CBDinBatch: Double {
        if
            let CBDint = Double(cbd),
            let WeightInt = Double(weight)
        {
            return CBDint * WeightInt * (Double(conversionFactor) * 0.1)
        } else {
            return 0
        }
    }

    var THCinServing: Double {
        if let units = Double(unitsInBatch) {
            return THCinBatch / units
        } else {
            return THCinBatch
        }
    }

    var CBDinServing: Double {
        if let units = Double(unitsInBatch) {
            return CBDinBatch / units
        } else {
            return CBDinBatch
        }
    }

    var THCperTablespoon: Double {
        if let cups = Double(cupsOfBase) {
            return THCinBatch / (cups * 16)
        } else {
            return THCinBatch
        }
    }

    var CBDperTablespoon: Double {
        if let cups = Double(cupsOfBase) {
            return CBDinBatch / (cups * 16)
        } else {
            return CBDinBatch
        }
    }
    
}
