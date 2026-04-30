import SwiftUI
import SwiftData

struct HabitRowView: View {
    
    let habit: Habit
    
    @Environment(\.modelContext) private var context
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: habit.icon)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(habit.name)
                    .font(.headline)
                
                Text("🔥 \(currentStreak()) streak")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                completeToday()
            } label: {
                Image(systemName: isCompletedToday() ? "checkmark.circle.fill" : "checkmark.circle")
                    .font(.title2)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Functions
extension HabitRowView {
    
    func completeToday() {
        let calendar = Calendar.current
        
        let alreadyDone = habit.logs.contains {
            calendar.isDateInToday($0.completedAt)
        }
        
        if alreadyDone { return }
        
        let newLog = HabitLog()
        newLog.habit = habit
        
        context.insert(newLog)
    }
    
    func isCompletedToday() -> Bool {
        let calendar = Calendar.current
        
        return habit.logs.contains {
            calendar.isDateInToday($0.completedAt)
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
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate)!
            } else if date < currentDate {
                break
            }
        }
        
        return streak
    }
}
