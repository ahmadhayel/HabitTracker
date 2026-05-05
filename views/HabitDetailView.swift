import SwiftUI
import SwiftData

struct HabitDetailView: View {
    
    let habit: Habit
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            
            // Header
            Section {
                HStack(spacing: 16) {
                    
                    Image(systemName: habit.icon)
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color.blue.opacity(0.2))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(habit.name)
                            .font(.title2.bold())
                        
                        Text("🔥 \(currentStreak()) day streak")
                            .foregroundColor(.orange)
                        
                        Text("✅ \(habit.logs.count) completions")
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            // History
            Section("History") {
                if habit.logs.isEmpty {
                    Text("No completions yet.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(sortedLogs()) { log in
                        Text(
                            log.completedAt.formatted(
                                date: .abbreviated,
                                time: .omitted
                            )
                        )
                    }
                }
            }
            
            // Delete
            Section {
                Button(role: .destructive) {
                    deleteHabit()
                } label: {
                    Label("Delete Habit", systemImage: "trash")
                }
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Functions
extension HabitDetailView {
    
    func deleteHabit() {
        context.delete(habit)
        dismiss()
    }
    
    func sortedLogs() -> [HabitLog] {
        habit.logs.sorted {
            $0.completedAt > $1.completedAt
        }
    }
    
    func currentStreak() -> Int {
        let calendar = Calendar.current
        
        let uniqueDates = Array(
            Set(
                habit.logs.map {
                    calendar.startOfDay(for: $0.completedAt)
                }
            )
        ).sorted(by: >)
        
        guard !uniqueDates.isEmpty else { return 0 }
        
        var streak = 0
        var currentDate = calendar.startOfDay(for: Date())
        
        for date in uniqueDates {
            if calendar.isDate(date, inSameDayAs: currentDate) {
                streak += 1
                currentDate = calendar.date(
                    byAdding: .day,
                    value: -1,
                    to: currentDate
                )!
            } else if date < currentDate {
                break
            }
        }
        
        return streak
    }
}
