//
//  ScreenTimeManager.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import Foundation
import SwiftUI

class ScreenTimeManager: ObservableObject {
    @Published var screenTimeHours: Double = 0
    @Published var dailyLimit: Double = 4.0
    
    private var timer: Timer?
    
    init() {
        // Initial fetch
        fetchScreenTime()
        
        // Set up periodic updates
        startMonitoring()
    }
    
    func startMonitoring() {
        // Update every 30 seconds (you can adjust this interval)
        timer?.invalidate() // Clear any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.incrementScreenTime()
        }
    }
    
    func fetchScreenTime() {
        // Simulate some initial usage (between 0-6 hours)
        screenTimeHours = Double.random(in: 0...6)
    }
    
    private func incrementScreenTime() {
        // Add a small random amount (0-5 minutes) to simulate ongoing usage
        let additionalMinutes = Double.random(in: 0...5) / 60
        screenTimeHours += additionalMinutes
    }
    
    // Clean up timer when the manager is deallocated
    deinit {
        timer?.invalidate()
    }
}
