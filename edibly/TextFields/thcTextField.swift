//
//  TwentyOneButton.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct thcTextField: View {
    
    @EnvironmentObject var ediblyCalc: EdiblyCalc
    
    var body: some View {

            TextField(
                "%",
                text: $ediblyCalc.thc
            )
            
            .font(.system(.headline))
            .multilineTextAlignment(.center)
            
            
    }
}

struct thcTextField_Previews: PreviewProvider {
    static var previews: some View {
        thcTextField().environmentObject(EdiblyCalc())
    }
}
