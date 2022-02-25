//
//  BoundingBox.swift
//  HW3-OverlapIntegrals
//
//  Created by Shayarneel Kundu on 2/17/22.
//

import Foundation
import SwiftUI

class BoundingBox: NSObject {
    
    
    /// calculateVolume
    ///
    /// - Parameters:
    ///   - xmin: leftmost x coordinate of box
    ///   - xmax: rightmost x coordinate of box
    ///   - ymin: leftmost y coordinate of box
    ///   - ymax: rightmost y coordinate of box
    ///   - zmin: leftmost z coordinate of box
    ///   - zmax: rightmost z coordinate of box
    /// - Returns: returns the volume of a box
    func calculateVolume(xmin: Double, xmax: Double, ymin: Double, ymax: Double, zmin: Double, zmax: Double) -> Double {
        
        let volume = (xmax - xmin) * (ymax - ymin) * (zmax - zmin)
        return volume
        
    }
    
}
