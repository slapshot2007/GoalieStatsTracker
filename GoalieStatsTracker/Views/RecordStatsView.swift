//
//  RecordStatsView.swift
//  GoalieStatsTracker
//
//  Created by Sanya Arora on 9/28/23.
//

import SwiftUI

struct RecordStatsView: View {
    
    static let colorGoal = Color.red
    static let colorSave = Color.green
    static let color8MGoal = Color.purple
    static let color8MSave = Color.mint
    static let colorNeutral = Color.gray
    
    @State private var colorGoalButton : Color = colorNeutral
    @State private var colorSaveButton : Color = colorNeutral
    @State private var color8MGoalButton : Color = colorNeutral
    @State private var color8MSaveButton : Color = colorNeutral
    
    @State var pointsOn12Meter: [CGPoint] = []
    @State var pointsOnGoal: [CGPoint] = []
    
    @State var currentColor: Color = colorNeutral
    
    var draw12MeterCircle: some Gesture {
        SpatialTapGesture()
            .onEnded() { event in
                pointsOn12Meter.append(event.location)
            }
    }
    
    var drawGoalCircle: some Gesture {
        SpatialTapGesture()
            .onEnded() { event in
                pointsOnGoal.append(event.location)
            }
    }

    
    var tapGoalGesture: some Gesture {
        TapGesture()
            .onEnded() {
                withAnimation {
                    colorGoalButton = RecordStatsView.colorGoal
                    colorSaveButton = RecordStatsView.colorNeutral
                    color8MGoalButton = RecordStatsView.colorNeutral
                    color8MSaveButton = RecordStatsView.colorNeutral
                    
                    currentColor = colorGoalButton
                }
            }
    }
    
    var tapSaveGesture: some Gesture {
        TapGesture()
            .onEnded() {
                withAnimation {
                    colorGoalButton = RecordStatsView.colorNeutral
                    colorSaveButton = RecordStatsView.colorSave
                    color8MGoalButton = RecordStatsView.colorNeutral
                    color8MSaveButton = RecordStatsView.colorNeutral
                    
                    currentColor = colorSaveButton
                }
            }
    }
    
    var tapClearGesture: some Gesture {
        TapGesture()
            .onEnded() {
                withAnimation {
                    colorGoalButton = RecordStatsView.colorNeutral
                    colorSaveButton = RecordStatsView.colorNeutral
                    color8MGoalButton = RecordStatsView.color8MGoal
                    color8MSaveButton = RecordStatsView.colorNeutral
                    
                    currentColor = color8MGoalButton
                }
            }
    }
    
    var tap8MeterGesture: some Gesture {
        TapGesture()
            .onEnded() {
                withAnimation {
                    colorGoalButton = RecordStatsView.colorNeutral
                    colorSaveButton = RecordStatsView.colorNeutral
                    color8MGoalButton = RecordStatsView.colorNeutral
                    color8MSaveButton = RecordStatsView.color8MSave
                    
                    currentColor = color8MSaveButton
                }
            }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 40)
                        .foregroundColor(colorGoalButton)
                        .opacity(0.5)
                        .gesture(tapGoalGesture)
                    Text("Goal")
                        .font(.headline)
                }
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 40)
                        .foregroundColor(colorSaveButton)
                        .opacity(0.5)
                        .gesture(tapSaveGesture)
                    Text("Save")
                        .font(.headline)
                }
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 40)
                        .foregroundColor(color8MGoalButton)
                        .opacity(0.5)
                        .gesture(tapClearGesture)
                    Text("8M Goal")
                        .font(.headline)
                }
                Spacer()
                ZStack {
                    Rectangle()
                        .frame(width: 80, height: 40)
                        .foregroundColor(color8MSaveButton)
                        .opacity(0.5)
                        .gesture(tap8MeterGesture)
                    Text("8M Save")
                        .font(.headline)
                }
                Spacer()
            }
            Spacer()
                .frame(height: 50)
            
            ZStack {
                Image("12MeterDiagram")
                    .resizable()
                    .frame( width: 400, height: 240)
                
                ForEach(pointsOn12Meter, id: \.x) { point in
                    ClickedCircle(currentLocation: point, circleColor: currentColor)
                }
            }
            .contentShape(Rectangle())
            .gesture(draw12MeterCircle)
            
            Divider()
            
            ZStack {
                Image("laxGoal")
                    .resizable()
                    .frame(width: 300, height: 350)
                
                ForEach(pointsOnGoal, id: \.x) { point in
                    ClickedCircle(currentLocation: point, circleColor: currentColor)
                }
            }
            .contentShape(Rectangle())
            .gesture(drawGoalCircle)
            
        }
    }
}

struct ClickedCircle: View {
    
    @State var currentLocation: CGPoint
    @State var circleColor: Color

    var body: some View {

        return Circle().fill(circleColor)
            .frame(width: 10, height: 10)
            .position(currentLocation)
    }
}

struct RecordStatsView_Previews: PreviewProvider {
    static var previews: some View {
        RecordStatsView()
    }
}
