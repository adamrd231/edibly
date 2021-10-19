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
            .font(.title3)
            .multilineTextAlignment(.trailing)
            
            
    }
}

struct cbdTextField_Previews: PreviewProvider {
    static var previews: some View {
        cbdTextField().environmentObject(EdiblyCalc())
    }
}
