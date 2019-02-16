//
//  ViewController.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/14/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var artistTextField: UITextField?
    @IBOutlet weak var songTextField: UITextField?
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var cloud4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favButton.layer.cornerRadius = 5
        favButton.layer.masksToBounds = true
        
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let artist = artistTextField?.text?.replacingOccurrences(of: " ", with: "_")
        let title = songTextField?.text?.replacingOccurrences(of: " ", with: "_")
        SongService.fetchLyrics(artist: artist ?? "", title: title ?? "")
        {(result: Song) in
            DispatchQueue.main.async {
                if result.lyrics == "" {
                    self.showAlert()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                } else {
                let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
                detailView.modalPresentationStyle = .overFullScreen
                self.present(detailView, animated: true, completion: nil)
                
                detailView.artistLabel.text = self.artistTextField?.text?.capitalized
                detailView.songLabel.text = self.songTextField?.text?.capitalized
                detailView.lyricsTextView.text = result.lyrics
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                self.artistTextField?.text = ""
                self.songTextField?.text = ""
                }
            }
        }
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        let favSongsView = FavSongsViewController(nibName: "FavSongsViewController", bundle: nil)
        favSongsView.modalTransitionStyle = .flipHorizontal
        self.present(favSongsView, animated: true, completion: nil)
        
        artistTextField?.text = ""
        songTextField?.text = ""
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        artistTextField?.resignFirstResponder()
        songTextField?.resignFirstResponder()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No se encontro letra",
                                      message: "",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
