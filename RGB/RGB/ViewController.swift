//
//  ViewController.swift
//  RGB
//
//  Created by macbook on 09/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewColor: UIView!
    
    var red : Double = 0.5
    var green : Double = 0.5
    var blue : Double = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    }
    
    @IBAction func rojo(_ sender: UISlider) {
        print(sender.value)
        viewColor.backgroundColor = UIColor(red: CGFloat(sender.value), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        
    }
    
    @IBAction func verde(_ sender: UISlider) {
    
    }
    
    @IBAction func azul(_ sender: UISlider) {
    
    }
    
}

