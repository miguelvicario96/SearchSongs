//
//  TableViewCell.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(song: String, artist: String){ //Set data proveniente de la vista que contiene la tabla
        textLabel?.text = song
        detailTextLabel?.text = artist
    }
    
}
