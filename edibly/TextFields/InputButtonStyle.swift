//
//  TwentyOneButton.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct InputButtonStyle: View {
    
    @State private var thc = ""
    
    var body: some View {

            TextField(
                "Enter flower name",
                text: $thc
            )
            .font(.system(.headline))
            .padding()
            .background(Color.white)
            .frame(minWidth: 200, idealWidth: 250, maxWidth: .infinity, minHeight: 50, idealHeight: 60, maxHeight: 70, alignment: .center)
            
            

        
        
    }
}

struct InputButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        InputButtonStyle()
    }
}
