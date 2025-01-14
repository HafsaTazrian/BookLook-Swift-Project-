//
//  AuthorBook.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import Foundation

struct AuthorBook: Identifiable, Decodable {
    let id: Int
    let title: String
    let author: String
    let coverImageURL: URL?
    var starRating: Double?
    var genres: [String]?
    var description: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case author = "artistName"
        case coverImageURL = "artworkUrl100"
        case starRating = "averageUserRating" // Use the correct key as per iTunes API
        case genres = "genres"
        case releaseDate = "releaseDate"
        case description = "description"
    }

}
struct AuthorBookResponse: Decodable {
    let results: [AuthorBook]
}
