//
//  Stream.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

struct Stream: Codable {
    let top: [Top]
}

struct Top: Codable {
    let game: Game
    let viewers: Int
    let channels: Int
}

struct Game: Codable {
    let name: String
    let box: Box
}

struct Box: Codable {
    let large: String
}
