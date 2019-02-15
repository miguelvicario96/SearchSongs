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
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.cornerRadius = 10
        searchButton.layer.masksToBounds = true

        artistTextField?.delegate = self
        songTextField?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 8, delay: 0.1, options:
            [.autoreverse, .curveEaseInOut, .repeat], animations: {

            self.cloud3.center.x -= self.view.bounds.width / 1.6
            self.cloud4.center.x += self.view.bounds.width / 1.6
        },
            completion: nil
        )
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
                let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
                detailView.modalPresentationStyle = .overFullScreen
                self.present(detailView, animated: true, completion: nil)
                detailView.lyricsTextView.text = result.lyrics
                
                self.artistTextField?.text = ""
                self.songTextField?.text = ""
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
