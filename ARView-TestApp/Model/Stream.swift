//
//  Stream.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

struct Stream: Decodable {
    let top: [Top]
}

struct Top: Decodable {
    let game: Game
    let viewers: Int
    let channels: Int
}

struct Game: Decodable {
    let name: String
    let logo: Box
}

struct Box: Decodable {
    let large: String
}
