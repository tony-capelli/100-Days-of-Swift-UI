//
//  OptionalAnimation.swift
//  Flashzilla
//
//  Created by Tony Capelli on 30/01/23.
//

import Foundation
import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}
