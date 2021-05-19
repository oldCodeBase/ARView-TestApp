//
//  NetworkManager.swift
//  ARView-TestApp
//
//  Created by Ibragim Akaev on 19/05/2021.
//

import UIKit

final class NetworkManager {
    
    let cache         = NSCache<NSString, UIImage>()
    static let shared = NetworkManager()
    private init() {}
    
    func fetchGames(completed: @escaping (Result<Stream, CustomError>) -> Void) {
        let stringUrl   = "https://api.twitch.tv/kraken/games/top?limit=100"
        guard let url = URL(string: stringUrl) else { return }
        
        var request = URLRequest(url: url)
        request.addValue("sd4grh0omdj9a31exnpikhrmsu3v46", forHTTPHeaderField: "Client-ID")
        request.addValue("application/vnd.twitchtv.v5+json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, error, _) in
            guard let data = data else {
                completed(.failure(.unableToComplete))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let streams = try decoder.decode(Stream.self, from: data)
                completed(.success(streams))
            } catch {
                completed(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey    = NSString(string: urlString)
        if let image    = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}


enum CustomError: String, Error {
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
}

