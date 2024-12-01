//
//  Model.swift
//  NameStack
//
//  Created by 이주헌 on 11/30/24.
//

import SwiftUI
import SwiftData
 
@Model
class Card {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var phoneNumber: String
    var mail: String
    var position: String
    var memo: String
    @Relationship(deleteRule: .nullify, inverse: \NameTag.post)
    var comments: [NameTag] = [NameTag]()
    var createdAt: Date


    init(id: UUID = UUID(), name: String, phoneNumber: String, mail: String, position: String, memo: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.mail = mail
        self.position = position
        self.memo = memo
        self.createdAt = Date.now
    }
}

@Model
class NameTag {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var color: Color
    
    @Relationship
    var post: Card?
  
    init(id: UUID = UUID(), content: String) {
        self.id = id
        self.name = content
        self.color = Color.white
    }
}
