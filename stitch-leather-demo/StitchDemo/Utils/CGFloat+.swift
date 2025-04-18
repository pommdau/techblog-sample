//
//  CGFloat+.swift
//  StitchDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/18.
//

import Foundation

extension CGFloat {
    /// 度 -> Radian
    var degreesToRadians: CGFloat {
        self * .pi / 180
    }
}
