//
//  NetworkManager.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

struct NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchGames(completed: @escaping (Stream) -> Void) {
        
        let stringUrl   = "https://api.twitch.tv/kraken/games/top?limit=100"
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("sd4grh0omdj9a31exnpikhrmsu3v46", forHTTPHeaderField: "Client-ID")
        request.addValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, error, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let streams = try decoder.decode(Stream.self, from: data)
                completed(streams)
            } catch {
                print("Error")
            }
        }
        task.resume()
    }
}

