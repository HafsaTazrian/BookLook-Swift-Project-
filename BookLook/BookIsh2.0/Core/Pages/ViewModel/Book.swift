//
//  Book.swift
//  BookIsh2.0
//
//  Created by Rakibul Nasib on 14/11/23.
//

import Foundation

struct Book: Identifiable, Decodable, Hashable {
    var id: Int
    var title: String
    var author: String
    var coverImageURL: URL?
    var averageRating: Double?
    var genres: [String]?
    var description: String?
    var releaseDate: String?
    


    private enum CodingKeys: String, CodingKey {
        case id = "trackId"         // Use the correct key as per iTunes API
        case title = "trackName"    // Use the correct key as per iTunes API
        case author = "artistName"  // Use the correct key as per iTunes API
        case coverImageURL = "artworkUrl100" // Use the correct key as per iTunes API
        case averageRating = "averageUserRating" // Use the correct key as per iTunes API
        case genres = "genres"
        case releaseDate = "releaseDate"
        case description = "description"
        
    }
    
//    enum ReleaseDateState {
//        case available(Date)
//        case unavailable
//
//        var text: String {
//            switch self {
//            case .available(let date):
//                return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
//            case .unavailable:
//                return "Release date not available."
//            }
//        }
//    }
}
