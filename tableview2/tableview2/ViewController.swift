//
//  ViewController.swift
//  tableview2
//
//  Created by macbook on 12/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arregloEmojis : [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarEmojis()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func cargarEmojis(){
        var emoji = Emoji(figura: "🍋", descripcion: "Limón", seleccionado: false)
        arregloEmojis.append(emoji)
        emoji = Emoji(figura: "🚀", descripcion: "Nave", seleccionado: false)
        arregloEmojis.append(emoji)
        emoji = Emoji(figura: "🍪", descripcion: "Galleta", seleccionado: false)
        arregloEmojis.append(emoji)
        emoji = Emoji(figura: "🦄", descripcion: "Unicornio", seleccionado: false)
        arregloEmojis.append(emoji)
        emoji = Emoji(figura: "🧟‍♂️", descripcion: "Zombie", seleccionado: false)
        arregloEmojis.append(emoji)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloEmojis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        cell.emojiLabel.text = arregloEmojis[indexPath.row].figura
        cell.descripcionLabel.text = arregloEmojis[indexPath.row].descripcion
        if arregloEmojis[indexPath.row].seleccionado {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Borrar") { (action, indexPath) in
            self.arregloEmojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let shareAction = UITableViewRowAction(style: .default, title: "Compartir") { (action, indexPath) in
            let defaultText = "Estamos en el ios Lab 👨🏻‍💻👩🏻‍💻"
            let defaultImage = UIImage(named: "disco")
            let shareActivity = UIActivityViewController(activityItems: [defaultText,defaultImage], applicationActivities: [])
            self.present(shareActivity, animated: true , completion: nil)
        }
        
        shareAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        return [deleteAction, shareAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //prender bandera de seleccionado
        arregloEmojis[indexPath.row].seleccionado = !arregloEmojis[indexPath.row].seleccionado
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    


}

