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

        artistTextField?.delegate = self
        songTextField?.delegate = self
    }

    @IBAction func searchSong(_ sender: UIButton) {
        let artist = artistTextField?.text?.replacingOccurrences(of: " ", with: "_")
        let title = songTextField?.text?.replacingOccurrences(of: " ", with: "_")
        SongService.fetchLyrics(artist: artist ?? "", title: title ?? "")
        {(result: Song) in
            DispatchQueue.main.async {
                if result.lyrics == "" {
                    let alert = UIAlertController(title: "No se encontro letra",
                                                  message: "",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok",
                                                 style: .default)
                    
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                }
            }
            print(result)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        artistTextField?.resignFirstResponder()
        songTextField?.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
