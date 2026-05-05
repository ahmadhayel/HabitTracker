import SwiftData
import Foundation

@Model
final class HabitLog {
    var completedAt: Date
    var habit: Habit?
    
    init(completedAt: Date = Date()) {
        self.completedAt = completedAt
    }
}
