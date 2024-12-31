//
//  FriendsListView.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import SwiftUI
import ContactsUI
import Contacts
import UserNotifications

struct FriendsListView: View {
    @State private var friends = [
        Friend(name: "Tori", screenTimeHours: 3.5, dailyLimit: 4.0),
        Friend(name: "Robert", screenTimeHours: 5.2, dailyLimit: 4.0),
        Friend(name: "Scotty", screenTimeHours: 2.8, dailyLimit: 3.5),
        Friend(name: "Claire", screenTimeHours: 4.8, dailyLimit: 4.0)
    ]
    @State private var friendRequests = [FriendRequest]()
    @State private var showingContactPicker = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker("View", selection: $selectedTab) {
                    Text("Friends").tag(0)
                    Text("Requests").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedTab == 0 {
                    // Friends List
                    List(friends) { friend in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(friend.name)
                                    .font(.headline)
                                Spacer()
                                statusIcon(for: friend)
                            }
                            
                            ProgressView(
                                value: min(friend.screenTimeHours, friend.dailyLimit),
                                total: friend.dailyLimit
                            )
                            .tint(friend.isOverLimit ? .red : .blue)
                            
                            HStack {
                                Text("\(Int(friend.screenTimeHours))h \(Int((friend.screenTimeHours.truncatingRemainder(dividingBy: 1)) * 60))m")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Limit: \(Int(friend.dailyLimit))h")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .refreshable {
                        // Update friends data and check limits
                        friends = friends.map { friend in
                            var updatedFriend = friend
                            // Deliberately generate some over-limit cases for testing
                            updatedFriend.screenTimeHours = Double.random(in: 2...6)
                            // Check if they went over limit
                            NotificationManager.shared.checkScreenTimeLimit(friend: updatedFriend)
                            return updatedFriend
                        }
                    }
                } else {
                    // Requests List
                    List {
                        ForEach(friendRequests) { request in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(request.name)
                                    .font(.headline)
                                Text(request.phoneNumber)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                if request.status == .pending {
                                    HStack(spacing: 12) {
                                        Button("Accept") {
                                            // Handle accept
                                        }
                                        .foregroundColor(.blue)
                                        
                                        Button("Decline") {
                                            // Handle decline
                                        }
                                        .foregroundColor(.red)
                                    }
                                    .padding(.top, 4)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Friends")
            .toolbar {
                Button(action: {
                    showingContactPicker = true
                }) {
                    Image(systemName: "person.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showingContactPicker) {
            ContactPickerView(isPresented: $showingContactPicker) { contact in
                handleSelectedContact(contact)
            }
        }
        .onAppear {
            // Request notification permission when app starts
            NotificationManager.shared.requestPermission()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("🔔 Attempting to send test notification...")
                NotificationManager.shared.testImmediateNotification()
            }
            
            // Check pending notifications
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                print("📋 Pending notifications: \(requests.count)")
            }
            
            // Check delivered notifications
            UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
                print("📬 Delivered notifications: \(notifications.count)")
            }
        }
    }
    
    @ViewBuilder
    private func statusIcon(for friend: Friend) -> some View {
        if friend.isOverLimit {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(.red)
        } else {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
        }
    }
    
    private func handleSelectedContact(_ contact: CNContact) {
        guard let phoneNumber = contact.phoneNumbers.first?.value.stringValue else { return }
        
        // This would actually be an API call to your backend
        let isUserInstalled = false // Simulate checking if user has app
        
        if isUserInstalled {
            // Send friend request
            let request = FriendRequest(
                name: "\(contact.givenName) \(contact.familyName)",
                phoneNumber: phoneNumber,
                status: .pending,
                timestamp: Date()
            )
            friendRequests.append(request)
        }
    }
}
