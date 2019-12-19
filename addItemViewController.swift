//
//  addItemViewController.swift
//  Journey
//
//  Created by Amal Agrawal on 12/9/19.
//  Copyright © 2019 Amal Agrawal. All rights reserved.
//

import UIKit
import AVFoundation

class addItemViewController: UIViewController, UITextViewDelegate {

    var audioPlayer = AVAudioPlayer()
    
    
    @IBOutlet var itemEntryTextView: UITextView?
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveContact(_ sender: Any) {
        
    
        if (itemEntryTextView?.text.isEmpty)! || itemEntryTextView?.text == "Type anything..."{
            print("No Data")
            
            let alert = UIAlertController(title: "Please Type Something", message: "Your entry was left blank.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default) { action in
                
            })
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let newEntry = Item(context: context)
            newEntry.name = itemEntryTextView?.text!
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            dismiss(animated: true, completion: nil)
            
            playsound(soundName: "Magic Wand Noise-SoundBible.com-375928671", audioPlayer: &audioPlayer)

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemEntryTextView?.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

        
