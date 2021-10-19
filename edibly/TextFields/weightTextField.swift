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
        HStack {
            Text("Weight of Flower").font(.title3).bold()
            TextField(
                "Grams",
                text: $ediblyCalc.weight
            )
            .keyboardType(.numberPad)
            .font(.system(.headline))
            .multilineTextAlignment(.trailing)
            
        }
    }
}

struct weightTextField_Previews: PreviewProvider {
    static var previews: some View {
        thcTextField().environmentObject(EdiblyCalc())
    }
}
