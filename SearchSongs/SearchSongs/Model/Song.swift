//
//  Song.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

struct Song {
    
    var artist: String
    var title: String
    var lyrics: String
    
    static func create(artist: String, title: String, lyrics: String) -> Song?{
        
        return Song(artist: artist, title: title, lyrics: lyrics
        )
    }
}
