//
//  SongService.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

class SongService {
    
    static var urlSession = URLSession(configuration: .default)
    
    static func fetchLyrics(artist: String, title: String, onSuccess: @escaping (Song) -> Void){
        let artistEncoded = artist.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let titleEncoded = title.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = URL(string: "https://api.lyrics.ovh/v1/\(artistEncoded!)/\(titleEncoded!)")
        
        let dataTask = urlSession.dataTask(with: url!){data, response, error in
            if error == nil{
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
                if statusCode == 200{
                    guard let json = parseData(data: data!) else { return }
                    let song = songFrom(artist: artist, title: title, lyrics: json)
                    onSuccess(song)
                } else {
                    let song = Song.create(artist: artist, title: title, lyrics: "")
                    onSuccess(song!)
                }
            }
        }
        dataTask.resume()
    }
    
    static func parseData(data: Data) -> NSDictionary?{
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
        return json
    }
    
    static func songFrom(artist: String, title: String, lyrics: NSDictionary) -> Song {
        let result = lyrics["lyrics"] as! String
        let song = Song.create(artist: artist, title: title, lyrics: result)
        
        return song!
    }
}

