import SwiftData
import Foundation

@Model
final class Habit {
    var name: String
    var icon: String
    var color: String
    var createdAt: Date

    var reminderEnabled: Bool
    var reminderHour: Int
    var reminderMinute: Int

    @Relationship(deleteRule: .cascade)
    var logs: [HabitLog] = []

    init(name: String,
         icon: String,
         color: String,
         createdAt: Date = Date(),
         reminderEnabled: Bool = false,
         reminderHour: Int = 8,
         reminderMinute: Int = 0) {

        self.name = name
        self.icon = icon
        self.color = color
        self.createdAt = createdAt
        self.reminderEnabled = reminderEnabled
        self.reminderHour = reminderHour
        self.reminderMinute = reminderMinute
    }
}
