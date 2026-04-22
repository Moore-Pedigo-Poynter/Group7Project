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
    
    var password = "" //Stores existing password string
    var tempPassword = "" //Stores when hiding password
    var listVC: ListViewController? //List view controller object
    
    @IBAction func editedPassField(_ sender: Any) {
        // Because we allow the user to edit their password directly, we have
        // to revalidate it each time it's changed. We hide the save button if
        // their password is invalid
        savePass.isEnabled = (!passField.text!.isEmpty && (passField.text!.count >= 8))
    }
    
    
    @IBAction func generateButton(_ sender: Any) {
        // These strings let us generate random valid characters. The symbols
        // may need to be altered if some aren't typically allowed in passwords
        let caps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lowers = "abcdefghijklmnopqrstuvwxyz"
        let nums = "0123456789"
        let symbols = "!@#$%^&*()/,.<>;:'\"{}-+"
        var allValidChars = ""
        var passArray = [Character]()
        
        // Ensures we have a valid input for length
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
        
        // We do the above code for every valid type
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
        
        // If the length is valid, we continue generating until the password
        // is full-length
        if length < 8 {
            passwordLengthField.text = "Too short!"
            return
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
        
        // We use either asterisks or the characters depending on if we're wanting
        // it to be shown
        if showPass.isOn {
            passField.text = password
        }
        else {
            passField.text = String(repeating: "*", count: password.count)
        }
        
        // Because our password is already validated, we can always enable the
        // save button when it's generated
        savePass.isEnabled = true
    }
    
    @IBAction func shownChanged(_ sender: Any) {
        // Updates the password's readability
        if showPass.isOn {
            passField.text = password
        }
        else {
            tempPassword = password //Stores existing password
            passField.text = String(repeating: "*", count: password.count)
        }
    }
    
    @IBAction func savePassButton(_ sender: Any) {
        // Sends the password property to the list in the other VC
        dismiss(animated: true)
        let text = password //Set text to currently generated password
        listVC?.passwordList.append(text) //optional chainning
        listVC?.passwordTableView.reloadData()
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
