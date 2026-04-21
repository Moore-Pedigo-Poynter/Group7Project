//
//  ViewController.swift
//  Group7Project
//
//  Created by Pedigo, Charles L. on 4/18/26.
//  Edited by Xander J. Moore on 4/21/26.
//

import UIKit

class PassViewController: UIViewController {

    @IBOutlet weak var capsEnabled: UISwitch!
    @IBOutlet weak var lowersEnabled: UISwitch!
    @IBOutlet weak var numsEnabled: UISwitch!
    @IBOutlet weak var symbolsEnabled: UISwitch!
    @IBOutlet weak var passwordLengthField: UITextField!
    @IBOutlet weak var showPass: UISwitch!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var savePass: UIButton!
    
    var password = ""
    
    @IBAction func editedPassField(_ sender: Any) {
        savePass.isEnabled = !passField.text!.isEmpty
    }
    
    
    @IBAction func generateButton(_ sender: Any) {
        let caps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowers = "abcdefghijklmnopqrstuvwxyz"
        let nums = "0123456789"
        let symbols = "!@#$%^&*()/,.<>;:'\"{}-+"
        var allValidChars = ""
        password = ""
        var passArray = [Character]()
        
        guard let length = Int(passwordLengthField.text ?? "") else {
            return
        }
        
        // Ensure we have at least one of each specified type
        if capsEnabled.isOn {
            let char = caps.randomElement() ?? "A"
            passArray.append(char)
            // We make our later generation a little simpler so we can reference one
            // string instead of all 4 again
            allValidChars += caps
        }
        
        if lowersEnabled.isOn {
            let char = lowers.randomElement() ?? "a"
            passArray.append(char)
            allValidChars += lowers
        }
        
        if numsEnabled.isOn {
            let char = nums.randomElement() ?? "0"
            passArray.append(char)
            allValidChars += nums
        }
        
        if symbolsEnabled.isOn {
            let char = symbols.randomElement() ?? "!"
            passArray.append(char)
            allValidChars += symbols
        }
        
        if length < 8 {
            passwordLengthField.text = "Too short!";
        }
        else {
            for _ in 0..<(length - passArray.count) {
                // Generate a random valid symbol
                passArray.append(allValidChars.randomElement() ?? "a")
            }
        }
        
        // Shuffle up the order of the characters and set it to the string
        passArray.shuffle()
        
        password = String(passArray)
        
        if showPass.isOn {
            passField.text = password
        }
        else {
            passField.text = String(repeating: "*", count: password.count)
        }
        
        savePass.isEnabled = true
    }
    
    @IBAction func shownChanged(_ sender: Any) {
        if showPass.isOn {
            passField.text = password
        }
        else {
            passField.text = String(repeating: "*", count: password.count)
        }
    }
    
    @IBAction func savePassButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
