//
//  CalculateOverlap.swift
//  HW3-OverlapIntegrals
//
//  Created by Shayarneel Kundu on 2/17/22.
//


import Foundation
import SwiftUI

class CalculateOverlap: NSObject, ObservableObject{
    
    @Published var intVal = 0.0 //This stores the value of the integral


    func monteCarloInt(leftWavefunction: (_: Double, _: Double, _: Double) -> Double, rightWavefunction: (_: Double, _: Double, _: Double) -> Double, xmin: Double, xmax: Double, ymin: Double, ymax: Double, zmin: Double, zmax: Double, spacing: Double, iterations: Int) -> Double {
        
        var leftPsi = 0.0
        var rightPsi = 0.0
        var psiBarPsi : [Double] = []
        
        let offset = spacing/2
        
        
        for _ in 1...iterations {
            
            //choosing random points to evlauate the function at
            let currentx = Double.random(in: xmin...xmax)
            let currenty = Double.random(in: ymin...ymax)
            let currentz = Double.random(in: zmin...zmax)
            
            //Since only two atoms, we assume they are separated along the x-axis only
            leftPsi = leftWavefunction(currentx - offset, currenty, currentz)
            rightPsi = rightWavefunction(currentx + offset, currenty, currentz)
            
            let prob = leftPsi * rightPsi
            
            psiBarPsi.append(prob)
        }
        
        // need to use avg value theorem I = Vol * Avg
        let bbox = BoundingBox()
        let vol = bbox.calculateVolume(xmin: xmin, xmax: xmax, ymin: ymin, ymax: ymax, zmin: zmin, zmax: zmax)
        
        let avg = calculateAverage(data: psiBarPsi)
        let intVal = vol * avg
        
        return intVal
    }


    //This computes the average
    func calculateAverage(data: [Double]) -> Double {
        
        var sum = 0.0
        
        for num in data{
            sum += num
        }
        
        let average = sum/Double(data.count)
        return average
    }
    

}
