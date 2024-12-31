//
//  ContentView.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import SwiftUI

struct ContentView: View {
   @StateObject private var screenTimeManager = ScreenTimeManager()
   @State private var showingLimitPicker = false
   @State private var selectedHours = 4
   @State private var selectedMinutes = 0
   
   var progress: Double {
       return min(screenTimeManager.screenTimeHours / screenTimeManager.dailyLimit, 1.0)
   }
   
   var body: some View {
       TabView {
           // First Tab - Screen Time Ring
           ScrollView {
               Spacer()
                   .frame(height: 100)
               
               VStack {
                   ZStack {
                       // Background ring
                       Circle()
                           .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                           .frame(width: 250, height: 250)
                       
                       // Progress ring
                       Circle()
                           .trim(from: 0, to: CGFloat(progress))
                           .stroke(progress >= 1.0 ? Color.red : Color.blue, lineWidth: 20)
                           .frame(width: 250, height: 250)
                           .rotationEffect(.degrees(-90))
                           .animation(.linear, value: progress)
                       
                       // Time display
                       VStack {
                           Text("\(Int(screenTimeManager.screenTimeHours))h \(Int((screenTimeManager.screenTimeHours.truncatingRemainder(dividingBy: 1)) * 60))m")
                               .font(.title)
                               .bold()
                           Text("of")
                               .font(.subheadline)
                           Text("\(Int(screenTimeManager.dailyLimit))h \(Int((screenTimeManager.dailyLimit.truncatingRemainder(dividingBy: 1) * 60)))m")
                               .font(.headline)
                       }
                   }
                   .padding()
                   
                   Button(action: {
                       selectedHours = Int(screenTimeManager.dailyLimit)
                       selectedMinutes = 0
                       showingLimitPicker = true
                   }) {
                       Label("Set Daily Limit", systemImage: "clock.arrow.circlepath")
                           .foregroundColor(.blue)
                           .padding()
                           .background(Color.blue.opacity(0.1))
                           .cornerRadius(10)
                   }
                   .padding(.top, 20)
                   
                   Spacer()
                       .frame(height: 100)
               }
           }
           .refreshable {
               screenTimeManager.fetchScreenTime()
               // Check if over limit
               if screenTimeManager.screenTimeHours > screenTimeManager.dailyLimit {
                   NotificationManager.shared.sendPersonalLimitNotification()
               }
           }
           .sheet(isPresented: $showingLimitPicker) {
               NavigationView {
                   VStack {
                       Text("Set Daily Screen Time Limit")
                           .font(.headline)
                           .padding()
                       
                       HStack {
                           Picker("Hours", selection: $selectedHours) {
                               ForEach(0...12, id: \.self) { hour in
                                   Text("\(hour)h").tag(hour)
                               }
                           }
                           .pickerStyle(.wheel)
                           .frame(width: 100)
                           
                           Picker("Minutes", selection: $selectedMinutes) {
                               ForEach([0, 15, 30, 45], id: \.self) { minute in
                                   Text("\(minute)m").tag(minute)
                               }
                           }
                           .pickerStyle(.wheel)
                           .frame(width: 100)
                       }
                   }
                   .toolbar {
                       ToolbarItem(placement: .cancellationAction) {
                           Button("Cancel") {
                               showingLimitPicker = false
                           }
                       }
                       ToolbarItem(placement: .confirmationAction) {
                           Button("Save") {
                               let newLimit = Double(selectedHours) + Double(selectedMinutes) / 60.0
                               screenTimeManager.dailyLimit = newLimit
                               showingLimitPicker = false
                           }
                       }
                   }
               }
               .presentationDetents([.height(300)])
           }
           .tabItem {
               Image(systemName: "clock")
               Text("My Time")
           }
           
           // Second Tab - Friends List
           FriendsListView()
               .tabItem {
                   Image(systemName: "person.2")
                   Text("Friends")
               }
       }
       .onAppear {
           // Request notification permission when app starts
           NotificationManager.shared.requestPermission()
       }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
       ContentView()
   }
}
