//
//  Float.swift
//  edibly
//
//  Created by Adam Reed on 2/26/22.
//

import Foundation

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
