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
                .multilineTextAlignment(.center)
                
        }
    }
}

struct unitsTextField_Previews: PreviewProvider {
    static var previews: some View {
        cbdTextField().environmentObject(EdiblyCalc())
    }
}
