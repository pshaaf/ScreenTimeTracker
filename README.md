# ScreenTimeTracker 📱⌛️

Welcome to **ScreenTimeTracker**—the iOS app that helps you stay accountable for your daily screen time. **Notify your friends whenever you exceed your daily limit**—because sometimes, a little friendly nudge is all it takes to keep you on track. 

---

## Table of Contents
- [Key Features](#key-features)
- [Architecture Overview](#architecture-overview)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

---

## Key Features

1. **Daily Screen Time Monitoring**  
   - Keep a close watch on your hours and minutes spent in front of the screen. ⏰  
   - Set a daily limit—go beyond it, and your friends will find out!

2. **Real-Time Friend Notifications**  
   - **Exceed your daily limit?** Your friends get an alert! 🏃‍♂️🚨  
   - Cultivate digital mindfulness through social accountability.

3. **Easy Limit Customization**  
   - Use the in-app picker to set how many hours and minutes you allow yourself.  
   - Bump up or reduce the limit anytime you want. 🎯

4. **Pull-to-Refresh**  
   - Quickly refresh to update your screen time and your friends’ usage.  
   - Get immediate insights into who’s over limit (or who’s still safe). 🔄

5. **Contact Picker Integration**  
   - Add friends straight from your iOS contacts.☎️  
   - Send friend requests and see if they have the app, all in one place.

6. **Built-In Notifications**  
   - Automatic alerts when you pass your own daily limit.  
   - Instant notifications when your friends overshoot their screen time, too. ⚠️

---

## Architecture Overview

ScreenTimeTracker uses a SwiftUI-based architecture, leaning on an MVVM pattern:

- **Models**:  
  - `Friend`, `FriendRequest` store names, hours used, daily limits, plus statuses for requests.  
  - `ScreenTimeManager` performs background updates and simulates new screen time usage.

- **Views**:  
  - `ContentView` holds the primary navigation tabs: *My Time* & *Friends*.  
  - `FriendsListView` displays your friends’ usage and any pending requests.  
  - `AddFriendView`, `ContactPickerView`, and others break down the UI into easy-to-reuse pieces.

- **Services / Managers**:  
  - `NotificationManager` handles user permissions, scheduling notifications, and sending real-time alerts.  
  - Firebase is configured in `ScreenTimeTrackerApp` to support analytics and potential cloud-based functionality.

This layered approach ensures a clean, modular codebase that’s easy to maintain and expand. ⚙️

---

## Tech Stack

- **Language:** Swift (SwiftUI)
- **Frameworks & APIs:**  
  - **SwiftUI** for the user interface.  
  - **ContactsUI** to pick and manage contacts.  
  - **UserNotifications** for local notifications.  
  - **Firebase** for app initialization and potential backend services.
- **Tools:**  
  - Xcode 14+  
  - iOS 16+ compatibility  

---

## Installation

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/YourUsername/ScreenTimeTracker.git](https://github.com/pshaaf/ScreenTimeTracker
   cd ScreenTimeTracker
   ```
2. **Open in Xcode**  
   - Double-click `ScreenTimeTracker.xcodeproj` or the `.xcworkspace` if you’re managing dependencies.  
3. **Configure Firebase (Optional)**  
   - Place a valid `GoogleService-Info.plist` in the project’s root if using real Firebase functionality.  
4. **Build & Run**  
   - Choose an iOS simulator or physical device.  
   - Press **Cmd + R** to launch the app. 🎉

---

## Usage

1. **Monitoring & Progress Ring**  
   - Launch the app, and head to **My Time** to see your total screen hours.  
   - A circular progress ring shows how close you are to your limit. Circle turns red if you’re over! 🔴  

2. **Setting Your Daily Limit**  
   - Tap **Set Daily Limit** to pick hours/minutes. Keep it realistic… or aim high!  
   - If you go over, you and your friends get a handy notification. No more hiding behind the screen! 🙈

3. **Friends & Accountability**  
   - Switch to **Friends** to see a list of pals and their screen usage.  
   - If someone exceeds their limit, you’ll get an alert—instant digital intervention! 🤝

4. **Requests & Contact Picker**  
   - Invite people from your contacts (the phonebook icon in the top-right corner).  
   - Pending requests appear in the **Requests** tab, allowing you to accept or decline.  

5. **Pull-to-Refresh**  
   - Swipe down on the list to refresh. The app simulates updated usage for you and your friends.  
   - Real-time accountability, boosted! 💪

---

## Project Structure

```
ScreenTimeTracker/
├── ScreenTimeTrackerApp.swift     // Sets up Firebase and app environment
├── ContentView.swift              // Main UI with tab navigation
├── FriendsListView.swift          // Displays friend list & friend requests
├── AddFriendView.swift            // Let’s you add new friends
├── ContactPickerView.swift        // Contacts integration
├── Friend.swift                   // Model for a friend
├── FriendRequest.swift            // Model for friend requests
├── ScreenTimeManager.swift        // Tracks and updates screen time
├── NotificationManager.swift      // Manages all notifications
└── ...
```
- **ScreenTimeTrackerApp**: Initializes Firebase and lays out the app scene.  
- **ContentView**: Main container with tab-based navigation.  
- **NotificationManager**: A one-stop shop for local notifications.  

---

## Contributing

Want to add new features or improve the user experience? Here’s how:

1. **Fork** the repository.  
2. **Create** a new branch for your features or fixes.  
3. **Commit** your changes with clear, descriptive messages.  
4. **Open a Pull Request**, and let me know what you’ve done!

Let’s build the ultimate screen-time accountability app together. 🚀

---

## License

This project is released under the [MIT License](LICENSE). Please review the license for details on usage, modification, and distribution. ☑️

---

**Thank you for trying out ScreenTimeTracker!**  
Protect your time, stay accountable, and enlist your friends to keep you in check! If you have any questions or suggestions, feel free to open an issue on GitHub. Happy tracking! ✨
