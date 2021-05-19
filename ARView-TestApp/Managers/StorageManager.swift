//
//  PersistenceManager.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import Foundation

enum StorageManager {

    static private let defaults = UserDefaults.standard
    enum Keys { static let stream = "stream" }
    
    static func retrieveData(completed: @escaping (Stream) -> Void) {
        guard let streamData = defaults.object(forKey: Keys.stream) as? Data else { return }

        do {
            let decoder = JSONDecoder()
            let streams = try decoder.decode(Stream.self, from: streamData)
            completed(streams)
        } catch {
            print("error")
        }
    }

    static func save(stream: Stream) {
        do {
            let encoder = JSONEncoder()
            let encodedStrems = try encoder.encode(stream)
            defaults.set(encodedStrems, forKey: Keys.stream)
            return
        } catch {
            print("error")
        }
    }
}
