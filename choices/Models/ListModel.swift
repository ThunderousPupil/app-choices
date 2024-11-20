//
//  List.swift
//  choices
//
//  Created by liuzehui on 2024/11/19.
//

import Foundation

struct ListModel: Identifiable {
    let id: UUID
    var name: String
    var items: [ListItem]
    let createdAt: Date
    var updatedAt: Date
    
    init(id: UUID = UUID(), name: String, items: [ListItem] = [], createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.items = items
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
