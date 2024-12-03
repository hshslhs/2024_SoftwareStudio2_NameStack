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
    var organization: String
    var school: String
    var URL: String
    var memo: String
    @Relationship(deleteRule: .nullify)
    var tags: [NameTag] = [NameTag]()
    var createdAt: Date


    init(id: UUID = UUID(),name: String, phoneNumber: String, mail: String, organization: String, school: String, URL: String, memo: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.mail = mail
        self.organization = organization
        self.school = school
        self.URL = URL
        self.memo = memo
        self.createdAt = Date.now
    }
}

@Model
class NameTag {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var color: String

    init(id: UUID = UUID(), content: String, color : String) {
        self.id = id
        self.name = content
        self.color = color
    }
}
