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
                .frame(minWidth: 150, idealWidth: 200, maxWidth: 250, minHeight: 50, idealHeight: 55, maxHeight: 60, alignment: .center)
                .foregroundColor(Color("MainColor"))
            Text("Calculate")
                .font(.system(.title2))
                .foregroundColor(.white)
                .bold()
        }
    }
}

struct CalculateButton_Previews: PreviewProvider {
    static var previews: some View {
        CalculateButton()
    }
}
