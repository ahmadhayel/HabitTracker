import SwiftUI
import SwiftData

@main
struct HabitTrackerApp: App {
    
    init() {
        NotificationManager.shared.requestPermission()
    }
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
        }
        .modelContainer(for: [Habit.self, HabitLog.self])
    }
}
