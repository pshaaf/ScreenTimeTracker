//
//  FriendRequest.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import Foundation

enum FriendRequestStatus {
    case pending
    case accepted
    case declined
    case notInstalled  // For contacts who don't have the app yet
}

struct FriendRequest: Identifiable {
    let id = UUID()
    let name: String
    let phoneNumber: String
    var status: FriendRequestStatus
    var timestamp: Date
}
