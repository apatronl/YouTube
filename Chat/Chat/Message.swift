//
//  Message.swift
//  Chat
//
//  Created by Ale Patrón on 4/3/24.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let role: Role
    let text: String
}

enum Role {
    case sender, receiver
}
