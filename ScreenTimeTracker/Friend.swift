//
//  Friend.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import Foundation

struct Friend: Identifiable {
    let id = UUID()
    let name: String
    var screenTimeHours: Double
    var dailyLimit: Double
    
    var percentageOfLimit: Double {
        (screenTimeHours / dailyLimit) * 100
    }
    
    var isOverLimit: Bool {
        screenTimeHours > dailyLimit
    }
}
