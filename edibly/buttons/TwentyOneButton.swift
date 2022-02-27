//
//  TwentyOneButton.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
//

import SwiftUI

struct TwentyOneButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(minWidth: 150, idealWidth: 200, maxWidth: 250, minHeight: 50, idealHeight: 55, maxHeight: 60, alignment: .center)
                .foregroundColor(Color.theme.darkGreen)
            Text("Agreed, and I'm 21+.")
                .font(.system(.callout))
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct TwentyOneButton_Previews: PreviewProvider {
    static var previews: some View {
        TwentyOneButton()
    }
}
