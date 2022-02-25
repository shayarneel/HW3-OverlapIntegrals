//
//  Wavefunctions.swift
//  HW3-OverlapIntegrals
//
//  Created by Shayarneel Kundu on 2/17/22.
//

import Foundation
import SwiftUI


///The wavefunction were written donw in spherical coordianates for 1s and 1px. This is beacuse that is the natural set of
///coordiantes to use when solviing SWE for Hydrogen. That, however, becomes super messy when computing overlap
///integrals, so we bnow define functions that switch to cartesian coordinates.
///These definitions are taken from the Coordinate System Conversions subsection of the article in the link below
///https://en.wikipedia.org/wiki/Spherical_coordinate_system

func cartesianPsiOneS(xval: Double, yval: Double, zval: Double) -> Double {
    
    let CartesianCoords = SphericalToCartesian(xval: xval, yval: yval, zval: zval)
    let PsiOneSCartesian = radialPsiOneS(rho: CartesianCoords.0, theta: CartesianCoords.1, phi: CartesianCoords.2)
    
    return PsiOneSCartesian
}

func cartesianPsiTwoPx(xval: Double, yval: Double, zval: Double) -> Double {
        
    let CartesianCoords = SphericalToCartesian(xval: xval, yval: yval, zval: zval)
    let PsiTwoPxCartesian = radialPsiTwoPx(rho: CartesianCoords.0, theta: CartesianCoords.1, phi: CartesianCoords.2)
    
    return PsiTwoPxCartesian
}

///When converting form spherical to radial coordiantes, we need to do some cooridnate transformations. This function does
///the coordinate transofrmations.

func SphericalToCartesian(xval: Double, yval: Double, zval: Double) -> (Double, Double, Double) {
    
    let rho = sqrt(pow(xval,2.0) + pow(yval,2.0) + pow(zval,2.0))
    let theta = atan2(sqrt(pow(xval,2.0) + pow(yval,2.0)),zval)
    let phi = atan2(yval,xval)
    
//    var phi = 0.0
//
//    if (xval > 0){
//        phi = atan(yval/xval)
//    }
//        else if (xval < 0 && yval >= 0){
//            phi = atan(yval/xval) + Double.pi
//        }
//
//        else if (xval < 0 && yval < 0){
//            phi = atan(yval/xval) - Double.pi
//        }
//
//        else if (xval == 0 && yval > 0){
//            phi = Double.pi/2.0
//        }
//
//        else if (xval == 0 && yval < 0){
//            phi = -Double.pi/2.0
//        }

    let Coords = (rho, theta, phi)
    
    return Coords
}




///This is the wavefunciton for 1s orbital
///              exp(- r / a)
///  psi(1s)    =       .......................
///             sqrt(pi * a^3)

func radialPsiOneS(rho: Double, theta: Double, phi: Double) -> Double{
    
    let bohrRadius = 0.5292 //defined in Angstrom
    let coeffPsiOneS = sqrt(Double.pi * pow(bohrRadius,3.0))
    let spatialPsiOneS = exp(-rho/bohrRadius)
    
    let PsiOneSRad = spatialPsiOneS/coeffPsiOneS
    
    return PsiOneSRad
}



///This is the wavefunciton for 1s orbital
///                 1                     r     exp(- r / a)   sin(theta)   cos(phi)
///  psi(1s)   =    ..............................     .....
///           4*sqrt(2*pi * a^3)      a
///

func radialPsiTwoPx(rho: Double, theta: Double, phi: Double) -> Double{
    
    let bohrRadius = 0.5292 //defined in Angstrom
    let coeffPsiTwoPx = 4 * sqrt(2.0 * Double.pi * pow(bohrRadius,3.0))
    let spatialPsiTwoPx = (rho/bohrRadius) * exp(-rho/(2.0*bohrRadius)) * sin(theta) * cos(phi)
    
    let PsiTwoPxRad = spatialPsiTwoPx/coeffPsiTwoPx
    
    return PsiTwoPxRad
}


