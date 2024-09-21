//
//  Message.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import Foundation

struct Message: Identifiable {
    let id = UUID()
    let role: Role
    let text: String
    var translation: String? = nil
}

enum Role {
    case sender, receiver
}
