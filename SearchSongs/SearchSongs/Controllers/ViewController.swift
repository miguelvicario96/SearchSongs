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
        
        favButton.layer.cornerRadius = 5    //Configuración de botón favButton
        favButton.layer.masksToBounds = true
        
        searchButton.layer.cornerRadius = 10 //Configuración de botón searchButton
        searchButton.layer.masksToBounds = true

        artistTextField?.delegate = self
        songTextField?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) { //Animación de Nubes
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 8, delay: 0.1, options:
            [.autoreverse, .curveEaseInOut, .repeat], animations: {

            self.cloud3.center.x -= self.view.bounds.width / 1.6
            self.cloud4.center.x += self.view.bounds.width / 1.6
        },
            completion: nil
        )
    }

    @IBAction func searchSong(_ sender: UIButton) { //Fetch de los datos de la API
        UIApplication.shared.isNetworkActivityIndicatorVisible = true   //Indicador de carga true
        SongService.fetchLyrics(artist: artistTextField?.text ?? "", title: songTextField?.text ?? "")
        {(result: Song) in
            DispatchQueue.main.async {  //Resultados
                if result.lyrics == "" {    //En caso de que devuelva un objeto sin lyrics mandar alerta
                    self.showAlert()    //Manda a llamar la alerta
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false //Indicador de carga flase
                } else {
                let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
                detailView.modalPresentationStyle = .overFullScreen
                self.present(detailView, animated: true, completion: nil) //Presentación modal de view DetailView
                
                //Inserción de datos en view siguiente
                detailView.artistLabel.text = self.artistTextField?.text?.capitalized
                detailView.songLabel.text = self.songTextField?.text?.capitalized
                detailView.lyricsTextView.text = result.lyrics
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                self.artistTextField?.text = "" //Limpia textfields
                self.songTextField?.text = ""
                }
            }
        }
    }
    
    @IBAction func favAction(_ sender: UIButton) {
        let favSongsView = FavSongsViewController(nibName: "FavSongsViewController", bundle: nil)
        favSongsView.modalTransitionStyle = .flipHorizontal
        self.present(favSongsView, animated: true, completion: nil) //Presentación modal de view FavSongs
        
        artistTextField?.text = "" //Limpia textfields
        songTextField?.text = ""
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {  //Dismiss keyboard con TapRecognizer
        artistTextField?.resignFirstResponder()
        songTextField?.resignFirstResponder()
    }
    
    func showAlert() {  //Función de alerta
        let alert = UIAlertController(title: "No se encontro letra",
                                      message: "",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok",style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: UITextFieldDelegate { //Delegate de TextField para el dismiss con el botón de Intro
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
