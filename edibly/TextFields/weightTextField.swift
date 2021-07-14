//
//  TwentyOneButton.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct weightTextField: View {
    
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    
    var body: some View {
        VStack {
            Text("Weight")
            TextField(
                "Grams",
                text: $ediblyCalc.weight
            )
            .keyboardType(.decimalPad)
            .font(.system(.headline))
            .multilineTextAlignment(.center)
            
        }
    }
}

struct weightTextField_Previews: PreviewProvider {
    static var previews: some View {
        thcTextField().environmentObject(EdiblyCalc())
    }
}
