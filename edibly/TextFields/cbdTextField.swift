//
//  TwentyOneButton.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct cbdTextField: View {
    
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    
    var body: some View {

            TextField(
                "%",
                text: $ediblyCalc.cbd
            )
            .keyboardType(.numberPad)
            .font(.system(.headline))
            .multilineTextAlignment(.center)
            
            
    }
}

struct cbdTextField_Previews: PreviewProvider {
    static var previews: some View {
        cbdTextField().environmentObject(EdiblyCalc())
    }
}
