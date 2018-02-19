//
//  ViewController.swift
//  realmTest
//
//  Created by macbook on 18/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var promedioTextField: UITextField!
    
    @IBOutlet weak var matItalianoSwitch: UISwitch!
    @IBOutlet weak var matFrancesSwitch: UISwitch!
    @IBOutlet weak var resultadosTextView: UITextView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func guardarAlumno(_ sender: UIButton) {
        if nombreTextField.text != "" && promedioTextField.text != "" {
            let nombre = nombreTextField.text!
            guard let promedio = Double(promedioTextField.text!) else {return}
            let materias : List<MateriaRealm> = List<MateriaRealm>()
            if matItalianoSwitch.isOn {
                let italiano = MateriaRealm()
                italiano.nombre = "Italiano"
                italiano.creditos = 100
                materias.append(italiano)
            }
            if matFrancesSwitch.isOn {
                let frances = MateriaRealm()
                frances.nombre = "Frances"
                frances.creditos = 105
                materias.append(frances)
            }
            let alumno = AlumnoRealm()
            alumno.nombre = nombre
            alumno.promedio = promedio
            alumno.materias = materias
            
            try! realm.write {
                realm.add(alumno)
            }
        }
    }
    
    @IBAction func filPorNombre(_ sender: UIButton) {
        if nombreTextField.text != "" {
            let nombre = nombreTextField.text!
            let alumnosQuery = realm.objects(AlumnoRealm.self).filter("nombre == %@",nombre)
            var texto = ""
            for alumno in alumnosQuery {
                texto += "nombre: \(alumno.nombre) \n"
                texto += "promedio: \(alumno.promedio) \n"
                for materia in alumno.materias {
                    texto += "materia: \(materia.nombre) creditos: \(materia.creditos) \n"
                }
                texto += "\n"
            }
            resultadosTextView.text = texto
        }
    }
    
    @IBAction func filPorPromedio(_ sender: UIButton) {
        if promedioTextField.text != "" {
            guard let promedio = Double(promedioTextField.text!) else {return}
            let alumnosQuery = realm.objects(AlumnoRealm.self).filter("promedio >= %@",promedio)
            var texto = ""
            for alumno in alumnosQuery {
                texto += "nombre: \(alumno.nombre) \n"
                texto += "promedio: \(alumno.promedio) \n"
                for materia in alumno.materias {
                    texto += "materia: \(materia.nombre) creditos: \(materia.creditos) \n"
                }
                texto += "\n"
            }
            resultadosTextView.text = texto
        }
    }
    
    @IBAction func filPorMateria(_ sender: UIButton) {
        let alumnosQuery = realm.objects(AlumnoRealm.self).filter("ANY materias.nombre == %@","Italiano")
        var texto = ""
        for alumno in alumnosQuery {
            texto += "nombre: \(alumno.nombre) \n"
            texto += "promedio: \(alumno.promedio) \n"
            for materia in alumno.materias {
                texto += "materia: \(materia.nombre) creditos: \(materia.creditos) \n"
            }
            texto += "\n"
        }
        resultadosTextView.text = texto
    }
    
    
    
    
    
    
    
}

