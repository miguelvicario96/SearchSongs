//
//  DetailViewController.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var lyricsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lyricsView.layer.cornerRadius = 10
        lyricsView.layer.masksToBounds = true
        
        favButton.layer.cornerRadius = 10
        favButton.layer.masksToBounds = true
        
        backButton.layer.cornerRadius = 10
        backButton.layer.masksToBounds = true
       
        lyricsTextView.flashScrollIndicators()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
