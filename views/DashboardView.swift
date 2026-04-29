import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @Query private var habits: [Habit]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    Text(habit.name)
                }
            }
            .navigationTitle("Habit Tracker")
        }
    }
}
