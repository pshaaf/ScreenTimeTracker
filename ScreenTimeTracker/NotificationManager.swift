//
//  NotificationManager.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//


import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("✅ Permission granted")
                DispatchQueue.main.async {
                    self.scheduleDelayedTest()
                }
            } else {
                print("❌ Permission denied")
            }
        }
    }
    
    func scheduleDelayedTest() {
        print("🔔 Scheduling test notification for 5 seconds from now...")
        
        let content = UNMutableNotificationContent()
        content.title = "5 Second Test"
        content.body = "This should appear 5 seconds after launch"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ Test notification scheduled")
            }
        }
    }
    
    func testImmediateNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Immediate Test"
        content.body = "This should appear right away"
        content.sound = .default
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ Test notification sent")
                self.checkNotificationStatus()
            }
        }
    }
    
    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getDeliveredNotifications { notifications in
            print("📱 Delivered notifications count: \(notifications.count)")
            notifications.forEach { notification in
                print("   - \(notification.request.content.title): \(notification.request.content.body)")
            }
        }
    }
    
    func sendPersonalLimitNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Screen Time Limit"
        content.body = "You've exceeded your daily screen time limit"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 2,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ Limit notification scheduled")
                self.checkNotificationStatus()
            }
        }
    }
    
    func checkScreenTimeLimit(friend: Friend) {
        if friend.isOverLimit {
            let percentOver = Int(((friend.screenTimeHours - friend.dailyLimit) / friend.dailyLimit) * 100)
            self.sendFriendLimitNotification(friendName: friend.name, percentOver: percentOver)
        }
    }
    
    private func sendFriendLimitNotification(friendName: String, percentOver: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Friend's Screen Time"
        content.body = "\(friendName) has exceeded their limit by \(percentOver)%"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 2,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print("✅ Friend notification scheduled")
                self.checkNotificationStatus()
            }
        }
    }
}
