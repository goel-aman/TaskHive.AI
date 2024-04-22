//
//  SearchData.swift
//  Hive.Ai.Task
//
//  Created by aman on 15/04/24.
//

import Foundation

struct Page: Codable {
    let pageid: Int
    let ns: Int
    let title: String
    let index: Int
    let thumbnail: Thumbnail?
    let pageimage: String?
    let extract: String
}

struct Thumbnail: Codable {
    let source: String
    let width: Int
    let height: Int
}

struct QueryResponse: Codable {
    let batchcomplete: String
    let query: Query
}

struct Query: Codable {
    let pages: [String: Page]
}
