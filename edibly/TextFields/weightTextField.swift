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
            .padding()
            .background(Color.white)
            .multilineTextAlignment(.center)
            .frame(minWidth: 90, idealWidth: 120, maxWidth: .infinity, minHeight: 50, idealHeight: 60, maxHeight: 70, alignment: .center)
        }
    }
}

struct weightTextField_Previews: PreviewProvider {
    static var previews: some View {
        thcTextField().environmentObject(EdiblyCalc())
    }
}
