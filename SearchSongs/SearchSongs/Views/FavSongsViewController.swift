//
//  FavSongsViewController.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit
import RealmSwift

class FavSongsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favButton: UIButton!

    var realm: Realm!   //Realm Configuration
    let realmManager = RealmManager()
    var favSongs = [FavSongs]() //Array contenedor de las favSongs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiConfiguration()
        
        self.tableView.dataSource = self    //TableView conforma protocolo DataSource
        self.tableView.delegate = self  //TableView conforma protocolo Delegate
        
        //Registo TableViewCell
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        realm = try! Realm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllObjects() //Obtiene los datos de Realm
        self.tableView.reloadData()
    }

    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)    //Dismiss view
    }
    
    func getAllObjects() {
        if let objects = realmManager.getObjects(type: FavSongs.self) {
            for element in objects {
                if let favSong = element as? FavSongs {
                    favSongs.append(favSong)    //Agrega los objetos al array
                }
            }
        }
    }
    
    func uiConfiguration() {
        favButton.layer.cornerRadius = 10   //Configuración de botón favButton
        favButton.layer.masksToBounds = true
    }
}

extension FavSongsViewController: UITableViewDataSource {   //Informacion a la Tabla
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.setData(song: favSongs[indexPath.row].title,
                     artist: favSongs[indexPath.row].artist)
        
        return cell //Pintado de celdas
    }
}

extension FavSongsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailView.modalPresentationStyle = .overFullScreen
        self.present(detailView, animated: true, completion: nil)   //Presentación modal de view DetailView
        
        //Inserción de datos en view siguiente
        detailView.artistLabel.text = favSongs[indexPath.row].artist
        detailView.songLabel.text = favSongs[indexPath.row].title
        detailView.lyricsTextView.text = favSongs[indexPath.row].lyrics
        detailView.favButton.isHidden = true
        
        tableView.deselectRow(at: indexPath, animated: true)    //Deselect row
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {    //Eliminado de información
            realmManager.deleteObject(objs: favSongs[indexPath.row])
            favSongs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
