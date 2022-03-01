//
//  Color.swift
//  edibly
//
//  Created by Adam Reed on 2/25/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    
    
}

struct ColorTheme {
    let background  = Color("background")
    let darkGreen  = Color("darkGreen")
    let darkGreenOpacity  = Color("darkGreenOpacity")
    let lightGreen = Color("lightGreen")
    let lightGreenOpacity = Color("lightGreenOpacity")
    let secondaryText = Color("secondaryText")
    let formTitleColor = Color("formTitleColor")
    let blackColor = Color("blackColor")
}
