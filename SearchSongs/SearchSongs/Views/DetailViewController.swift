//
//  DetailViewController.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var lyricsView: UIView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    
    var realm: Realm! //Realm Configuration
    let realmManager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        uiConfiguration()
        realm = try! Realm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lyricsTextView.setContentOffset(.zero, animated: true)  //Scroll hasta arriba
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)    //Dismiss view
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        
        let id = realmManager.incrementID() //Guardado de información
        let newFavSong = FavSongs(id: id,
                                  artist: artistLabel.text ?? "",
                                  title: songLabel.text ?? "",
                                  lyrics: lyricsTextView.text ?? "")
        
        realmManager.saveObjects(objs: newFavSong)
        
        let alert = UIAlertController(title: "Canción guardada",
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default)
        
        alert.addAction(okAction)
        self.present(alert, animated: true) //Presentación de alerta
    }
    
    func uiConfiguration() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        lyricsView.layer.cornerRadius = 10  //Configuración de lyricView
        lyricsView.layer.masksToBounds = true
        
        favButton.layer.cornerRadius = 10   //Configuración de botón favButton
        favButton.layer.masksToBounds = true
        
        backButton.layer.cornerRadius = 10  //Configuración de botón backButton
        backButton.layer.masksToBounds = true
        
        lyricsTextView.isEditable = false   //Configuración lyricsTextView
        
        lyricsTextView.flashScrollIndicators()  //Scroll Indicator
    }
}
