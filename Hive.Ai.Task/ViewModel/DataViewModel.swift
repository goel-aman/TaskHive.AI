//
//  DataViewModel.swift
//  Hive.Ai.Task
//
//  Created by aman on 15/04/24.
//

import Foundation

protocol DataServices {
    func reloadData()
}

class DataViewModel {
    private let manager = NetworkManager()
    var dataDelegate: DataServices?
    var data: QueryResponse = QueryResponse(batchcomplete: "", query: Query(pages: [ : ])) {
        didSet {
            self.dataDelegate?.reloadData()
        }
    }
    
    func fetchData(_ query: String) {
        let searchUrl = "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=\(query)&gsrlimit=10&prop=pageimages%7Cextracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
        Task {
            do {
                let songsResponse: QueryResponse = try await manager.getSearchData(from: searchUrl)
                self.data = songsResponse
                print(songsResponse)
            } catch {
                print(error)
            }
        }
    }
}

