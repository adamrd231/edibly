//
//  CalculateButton.swift
//  edibly
//
//  Created by Adam Reed on 7/11/21.
//

import SwiftUI

struct CalculateButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("MainColor"))
            Text("Calculate")
                .font(.system(.title3))
                .foregroundColor(.white)
                .bold()
        }.frame(width: 250, height: 50, alignment: .center)
    }
}

struct CalculateButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculateButton()
    }
}
