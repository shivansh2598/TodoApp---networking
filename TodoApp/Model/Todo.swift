//
//  Todo.swift
//  TodoApp
//
//  Created by Shivansh Sinha on 15/07/21.
//

import Foundation

//Use codable, which helps in prebuilt code for jsondecoding. Make sure field names are consistent
struct Todos : Codable {
    let items : Array<Todo>
}

struct Todo : Codable {
    let item : String
    let priority : Int
}
