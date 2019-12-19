//
//  UpdateItemViewController.swift
//  Journey
//
//  Created by Amal Agrawal on 12/9/19.
//  Copyright © 2019 Amal Agrawal. All rights reserved.
//

import UIKit
import AVFoundation

class UpdateItemViewController: UIViewController, UITextViewDelegate {
    
    var audioPlayer = AVAudioPlayer()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: Item!
    
    @IBOutlet weak var entryText: UITextView!
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateAction(_ sender: Any) {
        
        guard let newEntry = entryText.text else  {
            return
        }
        playsound(soundName: "Blop-Mark_DiAngelo-79054334", audioPlayer: &audioPlayer)
        
        item.name = newEntry
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        entryText!.delegate = self
        entryText!.becomeFirstResponder()
        configureEntryData(entry: item)
        
        print(item)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    func configureEntryData(entry: Item) {
        
        guard let text = entry.name else {
            return
        }
        entryText!.text = text
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func playsound(soundName : String, audioPlayer: inout AVAudioPlayer) {
        
        if let sound = NSDataAsset(name: soundName){
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("Error: data in \(soundName) couldn't be played as a sound")
            }
        }else{
            print("The sound did not play!")
        }
    }
    
    
}
