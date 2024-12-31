//
//  AddFriendView.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import SwiftUI

struct AddFriendView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var friends: [Friend]
    
    @State private var friendName = ""
    @State private var dailyLimit: Double = 4.0
    
    var body: some View {
        NavigationView {
            Form {
                Section("Friend Details") {
                    TextField("Name", text: $friendName)
                    
                    Stepper(value: $dailyLimit, in: 1...12, step: 0.5) {
                        HStack {
                            Text("Daily Limit:")
                            Text("\(dailyLimit, specifier: "%.1f") hours")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Add Friend")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let newFriend = Friend(
                            name: friendName,
                            screenTimeHours: Double.random(in: 0...6),
                            dailyLimit: dailyLimit
                        )
                        friends.append(newFriend)
                        dismiss()
                    }
                    .disabled(friendName.isEmpty)
                }
            }
        }
    }
}

