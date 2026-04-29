import SwiftUI
import SwiftData

struct AddHabitSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Habit name", text: $name)
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
                        let newHabit = Habit(
                            name: name,
                            icon: "star",
                            color: "blue"
                        )
                        
                        context.insert(newHabit)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}
