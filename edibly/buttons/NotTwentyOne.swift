//
//  NotTwentyOne.swift
//  edibly
//
//  Created by Adam Reed on 6/30/21.
import SwiftUI

struct NotTwentyOneButton: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(minWidth: 150, idealWidth: 200, maxWidth: 250, minHeight: 50, idealHeight: 55, maxHeight: 60, alignment: .center)
                .foregroundColor(Color.theme.lightGreen)
            Text("Honestly, I'm not 21.")
                .font(.system(.callout))
                .foregroundColor(.white)
                .bold()
                
        }
    }
}

struct NotTwentyOneButton_Previews: PreviewProvider {
    static var previews: some View {
        NotTwentyOneButton()
    }
}
