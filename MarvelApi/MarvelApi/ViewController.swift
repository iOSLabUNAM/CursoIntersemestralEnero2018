//
//  ViewController.swift
//  MarvelApi
//
//  Created by macbook on 15/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var mySuperHeroes : [SuperHero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInteractive).async {
            self.requestWS()
        }
    }
    
    func requestWS(){
        let parameters : Parameters = [
            "ts": 1,
            "apikey": "f8a2d5522ca5c023e32cd10478b814a7",
            "hash" : "027ba2a734e16c9246144100ee5fceb9"
        ]
        Alamofire.request("https://gateway.marvel.com:443/v1/public/characters", parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("🧞‍♂️")
                //print(json["data"]["results"][0]["name"])
                for (index,subJson):(String, JSON) in json["data"]["results"] {
                    let name = subJson["name"].stringValue
                    let description = subJson["description"].stringValue
                    let imageLink = subJson["thumbnail"]["path"].stringValue + "." + subJson["thumbnail"]["extension"].stringValue
                    let superHero = SuperHero(name: name, description: description, imageLink: imageLink, image: nil)
                    self.mySuperHeroes.append(superHero)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            //caso exitoso
            case .failure(let error):
                print("fallido")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySuperHeroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "superCell", for: indexPath) as! SuperTableViewCell
        cell.titleLabelCell.text = mySuperHeroes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.name = mySuperHeroes[indexPath.row].name
            destinationVC.descripcion = mySuperHeroes[indexPath.row].description
        }
    }


}

