import SwiftUI

struct HabitRowView: View {
    
    let habit: Habit
    
    var body: some View {
        HStack(spacing: 12) {
            
            Image(systemName: habit.icon)
                .font(.title2)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.2))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                
                Text("🔥 0 streak")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "checkmark.circle")
                    .font(.title2)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 4)
    }
}
