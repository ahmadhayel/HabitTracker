import SwiftUI
import SwiftData

struct AddHabitSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name = ""
    @State private var reminderEnabled = false
    @State private var reminderTime = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                
                TextField("Habit name", text: $name)
                
                Toggle("Reminder", isOn: $reminderEnabled)
                
                if reminderEnabled {
                    DatePicker(
                        "Time",
                        selection: $reminderTime,
                        displayedComponents: .hourAndMinute
                    )
                }
            }
            .navigationTitle("New Habit")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveHabit()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

extension AddHabitSheet {
    
    func saveHabit() {
        let components = Calendar.current.dateComponents(
            [.hour, .minute],
            from: reminderTime
        )
        
        let habit = Habit(
            name: name,
            icon: "star",
            color: "blue",
            reminderEnabled: reminderEnabled,
            reminderHour: components.hour ?? 8,
            reminderMinute: components.minute ?? 0
        )
        
        context.insert(habit)
        
        NotificationManager.shared.scheduleNotification(for: habit)
        
        dismiss()
    }
}
