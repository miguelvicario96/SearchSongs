//
//  RealManager.swift
//  SearchSongs
//
//  Created by Miguel Vicario on 2/15/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation
import  RealmSwift

class RealmManager {    //Clase con funciones hechas para utilizar Realm
    let realm = try? Realm()
    
    //Borrar tabla
//    func deleteDatabase() {
//        try! realm?.write({
//            realm?.deleteAll()
//        })
//    }
    
    //Borrar objecto
    func deleteObject(objs : Object) {
        try? realm!.write ({
            realm?.delete(objs)
        })
    }
    
    //Guardar objetos
    func saveObjects(objs: Object) {
        try? realm!.write ({
            // If update = false, adds the object
            realm?.add(objs, update: false)
        })
    }
    
    //Editar Objetos
//    func editObjects(objs: Object) {
//        try? realm!.write ({
//            // If update = true, objects that are already in the Realm will be
//            // updated instead of added a new.
//            realm?.add(objs, update: true)
//        })
//    }
    
    //Devuelve un array como Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm!.objects(type)
    }
    
    func incrementID() -> Int {
        return (realm!.objects(FavSongs.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
