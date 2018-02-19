//
//  ClasesRealm.swift
//  realmTest
//
//  Created by macbook on 18/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import Foundation
import RealmSwift

class MateriaRealm : Object {
    @objc dynamic var nombre : String = ""
    @objc dynamic var creditos : Int = 0
}

class AlumnoRealm : Object {
    @objc dynamic var nombre : String = ""
    @objc dynamic var promedio : Double = 0.0
    var materias = List <MateriaRealm>()
}


