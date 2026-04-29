import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @Query private var habits: [Habit]
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habits) { habit in
                    Text(habit.name)
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitSheet()
            }
        }
    }
}
