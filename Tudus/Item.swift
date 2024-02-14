//
//  Item.swift
//  Tudus
//
//  Created by Daniil Malewicz on 2/13/24.
//

import Foundation
import SwiftData

@Model
final class Item: Identifiable {
    var id: String
    var todo: String

    init(todo: String) {
        id = UUID().uuidString
        self.todo = todo
    }
}
