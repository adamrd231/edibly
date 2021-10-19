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

        HStack {
            Text("Cups of Base").font(.title3).bold()
            TextField("Oil, Butter, Etc..", text: $ediblyCalc.cupsOfBase)
                .keyboardType(.numberPad)
                .font(.system(.headline))
                .multilineTextAlignment(.trailing)
                
        }
    }
}

struct unitsTextField_Previews: PreviewProvider {
    static var previews: some View {
        cbdTextField().environmentObject(EdiblyCalc())
    }
}
