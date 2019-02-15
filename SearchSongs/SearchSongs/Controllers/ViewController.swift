//
//  ViewController.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var artistTextField: UITextField?
    @IBOutlet weak var songTextField: UITextField?
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 10
        searchButton.layer.masksToBounds = true

    }

    @IBAction func searchSong(_ sender: UIButton) {
        SongService.fetchLyrics(artist: artistTextField?.text ?? "", title: songTextField?.text ?? "")
        {(result: Song) in
            DispatchQueue.main.async {
                if result.lyrics == "" {
                    let alert = UIAlertController(title: "Error",
                                                  message: "No se encontro letra",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default)
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                }
            }
            print(result)
        }
    }
}

