//
//  ContentView.swift
//  Drawing
//
//  Created by Tony Capelli on 29/09/22.
//

import SwiftUI

struct Flower: Shape{
    var petalOffset = -20.0
    var petalWidth = 100.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8){
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        return path
    }
    
}

struct forma: Shape {
    var amount: Double
    
    var animatableData: Double{
        get{ amount }
        set{ amount = newValue }
        
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + amount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - amount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

struct freccia: InsettableShape {
    var distanza: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY - distanza))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + distanza))
        path.addLine(to: CGPoint(x: distanza, y: rect.height * 0.33))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + distanza))
        path.addLine(to: CGPoint(x: rect.maxX - distanza, y: rect.height * 0.33))
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.distanza += amount
        return arrow
    }

}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var isFilled = false
    @State private var amount = 20.0
    
    var vistaTrapezio: some View{
        forma(amount: amount)
            .frame(width: 200, height: 100)
            .onTapGesture{
                withAnimation{
                    amount = Double.random(in: 20...70)
                }
            }
    }
    
    var body: some View {
        freccia(distanza: 100)
            .strokeBorder(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        NavigationView{
                VStack{
            if isFilled {
                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    .fill(.red, style: FillStyle(eoFill: true))
                    .transition(.opacity)
            } else {
                Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    .stroke(.red, lineWidth: 1)
                    .transition(.opacity)
            }
            
            Text("\(petalOffset, specifier: "%.2f")")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal,.bottom])
            
            Text("\(petalWidth, specifier: "%.2f")")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
        }
        .toolbar{
            ToolbarItem(placement: .bottomBar){
                Button{
                    withAnimation{
                        isFilled.toggle()
                    }
                } label : {
                    Image(systemName: "pencil")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
