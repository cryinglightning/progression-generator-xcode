//
//  ViewController.swift
//  progression-generator
//
//  Created by Henry Long on 17/04/2018.
//  Copyright © 2018 cryinglightning. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var keyBtn: UIButton!
    @IBOutlet weak var keyPkr: UIPickerView!
    @IBOutlet weak var genBtn: UIButton!
    @IBOutlet weak var seqPkr: UIPickerView!
    
    
    let keys = [["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#"], ["major", "minor"]]
    
    let seq = ["I IV V I": [0, 3, 4, 0], "I iii V I": [0, 2, 4, 0], "I V vi IV": [0, 4, 5, 3], "I vi IV V": [0, 5, 3, 4], "I, IV, V, IV": [0, 3, 4, 3]]
    
    var keyLetterIndex = 0
    var scale = [0, 2, 4, 5, 7, 9, 11]
    var tonic = "major"
    var keyTonic = [0, 1, 1, 0, 0, 1, 1]
    let majMin = ["", "m"]
    var progBase = [0, 4, 5, 3]
    var keyProg = "E B C#m A"
    
    override func viewDidLoad() {
        
        keyPkr.delegate = self
        keyPkr.dataSource = self
        
        seqPkr.delegate = self
        seqPkr.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        var countcomps: Int = keys.count
        if pickerView == seqPkr {
            countcomps = 1
        }
        return countcomps
    }
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows: Int = keys[component].count
        if pickerView == seqPkr {
            countrows = seq.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == keyPkr {
            return keys[component][row]
        }
        else {
            return Array(seq.keys)[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == keyPkr {
            if component == 0 {
                keyLetterIndex = row
            }
            else {
                tonic = keys[1][row]
                if tonic == "major" {
                    keyTonic = [0, 1, 1, 0, 0, 1, 1]
                    scale = [0, 2, 4, 5, 7, 9, 11]
                }
                else if tonic == "minor" {
                    keyTonic = [1, 1, 0, 1, 1, 0, 0]
                    scale = [0, 2, 3, 5, 7, 8, 10]
                }
            }
        }
        else {
            progBase = Array(seq.values)[row]
        }
        
        func prog(n: Int) -> Int {
            return scale[progBase[n]]
        }
        
        func tonicFn(n: Int) -> Int {
            return keyTonic[progBase[n]]
        }
        
        keyProg = keys[0][(keyLetterIndex + prog(n: 0)) % keys[0].count] + majMin[(tonicFn(n: 0)) % keyTonic.count] + " " + keys[0][(keyLetterIndex + prog(n: 1)) % keys[0].count] + majMin[(tonicFn(n: 1)) % keyTonic.count] + " " + keys[0][(keyLetterIndex + prog(n: 2)) % keys[0].count] + majMin[(tonicFn(n: 2)) % keyTonic.count] + " " + keys[0][(keyLetterIndex + prog(n: 3)) % keys[0].count] + majMin[(tonicFn(n: 3)) % keyTonic.count]
    }

    @IBAction func pressGen(_ sender: UIButton) {
        genBtn.setTitle(keyProg, for: .normal)
        }
    
}


