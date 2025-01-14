//
//  Genre.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI

import Foundation

// Define your Genre model if needed
struct Genre: Identifiable, Hashable {
    let id: String // Typically, the name can serve as a unique ID
    let name: String
}
