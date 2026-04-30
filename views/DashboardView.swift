import SwiftUI
import SwiftData

struct DashboardView: View {
    
    @Query(sort: \Habit.createdAt, order: .reverse)
    private var habits: [Habit]
    
    @State private var showAddHabit = false
    
    var body: some View {
        NavigationStack {
            
            Group {
                if habits.isEmpty {
                    ContentUnavailableView(
                        "No Habits Yet",
                        systemImage: "list.bullet.clipboard",
                        description: Text("Tap + to add your first habit.")
                    )
                } else {
                    List {
                        ForEach(habits) { habit in
                            NavigationLink {
                                HabitDetailView(habit: habit)
                            } label: {
                                HabitRowView(habit: habit)
                            }
                        }
                    }
                    .listStyle(.plain)
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

#Preview {
    DashboardView()
}
