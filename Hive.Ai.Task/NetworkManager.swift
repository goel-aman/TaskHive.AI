//
//  NetworkManager.swift
//  Hive.Ai.Task
//
//  Created by aman on 15/04/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

class NetworkManager {
    func getSearchData(from url: String) async throws -> QueryResponse {
        guard let url = URL(string: url) else {
            throw DataError.invalidURL
        }
    
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw DataError.invalidResponse
        }
        
        return try JSONDecoder().decode(QueryResponse.self, from: data)
    }
}
