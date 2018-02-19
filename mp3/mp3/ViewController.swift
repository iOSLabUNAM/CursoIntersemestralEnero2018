//
//  ViewController.swift
//  mp3
//
//  Created by macbook on 12/01/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    var reproductor = AVAudioPlayer()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let rutaAudio = Bundle.main.path(forResource: "Go", ofType: "mp3") {
            do {
                let ruta = URL(fileURLWithPath: rutaAudio)
                try reproductor = AVAudioPlayer(contentsOf: ruta)
                timeSlider.maximumValue = Float(reproductor.duration)
            } catch {
                print("ocurrio un error al abrir la cancion")
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stop(_ sender: UIBarButtonItem) {
    
    }
    
    @IBAction func play(_ sender: UIBarButtonItem) {
        reproductor.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimeSlider), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimeSlider(){
        
    }
    
    @IBAction func pause(_ sender: UIBarButtonItem) {
        reproductor.pause()
    }
    
    @IBAction func changeTimeSlider(_ sender: UISlider) {
        
    }
    
    @IBAction func changeVolumeSlider(_ sender: UISlider) {
        
    }
    
}

