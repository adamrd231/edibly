//
//  TwentyOneButton.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct unitsTextField: View {
    
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    
    var body: some View {

        VStack {
            Text("Units")
            TextField("How many did you make?", text: $ediblyCalc.unitsInBatch)
                .keyboardType(.decimalPad)
                .font(.system(.headline))
                .padding()
                .background(Color.white)
                .multilineTextAlignment(.center)
                .frame(minWidth: 90, idealWidth: 120, maxWidth: .infinity, minHeight: 50, idealHeight: 60, maxHeight: 70, alignment: .center)
        }
    }
}

struct unitsTextField_Previews: PreviewProvider {
    static var previews: some View {
        cbdTextField().environmentObject(EdiblyCalc())
    }
}
