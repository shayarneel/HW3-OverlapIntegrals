//
//  ContentView.swift
//  Shared
//
//  Created by Shayarneel Kundu on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var calculatorOverlap = CalculateOverlap()
    
    @State var guessesString = ""
    
    @State var xminString = ""
    @State var xmaxString = ""
    @State var yminString = ""
    @State var ymaxString = ""
    @State var zminString = ""
    @State var zmaxString = ""
    
    @State var spacingString = ""
    
    @State var intvalString = ""
    
    @State var leftPsiString = ""
    @State var rightPsiString = ""
    
    var orbitals = ["1s", "2px"]
    
    var body: some View {
        
        VStack{
        
            VStack{
                Text("Guesses")
                TextField("Large value", text: $guessesString)
                    .frame(width: 100)
            } .padding()
            
            VStack{
                Text("Distance")
                TextField("In Angstrom", text: $spacingString)
                    .frame(width: 100)
            } .padding()
            
            VStack{
                Text("Limits for X")
                HStack{
                    TextField("X minimum", text: $xminString)
                        .frame(width: 80)
                    TextField("X maximum", text: $xmaxString)
                        .frame(width: 80)
                }
                
                Text("Limits for Y")
                HStack{
                    TextField("Y minimum", text: $yminString)
                        .frame(width: 80)
                    TextField("Y maximum", text: $ymaxString)
                        .frame(width: 80)
                }
                
                Text("Limits for Z")
                HStack{
                    TextField("Z minimum", text: $zminString)
                        .frame(width: 80)
                    TextField("Z maximum", text: $zmaxString)
                        .frame(width: 80)
                }
            }.padding()
            
            VStack{
                Text("Left Wavefunctiom")
                Picker("", selection: $leftPsiString){
                    ForEach(orbitals, id: \.self){
                        Text($0)
                    }
                }.frame(width: 100)
            }.padding()
            
            VStack{
                Text("Rught Wavefunctiom")
                Picker("", selection: $rightPsiString){
                    ForEach(orbitals, id: \.self){
                        Text($0)
                    }
                }.frame(width: 100)
            }.padding()
            
            VStack{
                Text("Overlap Integral")
                TextField("In Angstrom", text: $intvalString)
                    .frame(width: 100)
            } .padding()
            

        }
        
        Button("Integrate", action: self.calcualte)
    }
    
    
    
    func calcualte(){
        
        var psiLeft = cartesianPsiOneS
        var psiRight = cartesianPsiOneS
        
        if(leftPsiString == "1s"){
            psiLeft = cartesianPsiOneS
        } else{
            psiLeft = cartesianPsiTwoPx
        }
        
        if(rightPsiString == "1s"){
            psiRight = cartesianPsiOneS
        } else{
            psiRight = cartesianPsiTwoPx
        }
        
        let xmin = Double(xminString)!
        let xmax = Double(xmaxString)!
        let ymin = Double(yminString)!
        let ymax = Double(ymaxString)!
        let zmin = Double(zminString)!
        let zmax = Double(zmaxString)!
        
        let spacing = Double(spacingString)!
        
        let iterations = Int(guessesString)!
        
        let integral = calculatorOverlap.monteCarloInt(leftWavefunction: psiLeft, rightWavefunction: psiRight, xmin: xmin, xmax: xmax, ymin: ymin, ymax: ymax, zmin: zmin, zmax: zmax, spacing: spacing, iterations: iterations)
        
        
        intvalString = String(integral)
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
