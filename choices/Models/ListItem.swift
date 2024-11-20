import Foundation

struct ListItem: Identifiable {
    let id: UUID
    var title: String
    var note: String?
    let createdAt: Date
    var updatedAt: Date
    
    init(id: UUID = UUID(), title: String, note: String? = nil, createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.title = title
        self.note = note
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
