//
//  ViewController.swift
//  Tipster
//
//  Created by user on 1/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // TODO: add variables for percentage that will change by the slider
    var hasDecimalAlready = false
    var decimalPlaces = 0
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var groupSizeLabel: UILabel!
    @IBOutlet var smallPercentTipLabel: UILabel!
    @IBOutlet var smallPercentTotalLabel: UILabel!
    @IBOutlet var midPercentTipLabel: UILabel!
    @IBOutlet var midPercentTotalLabel: UILabel!
    @IBOutlet var largePercentTipLabel: UILabel!
    @IBOutlet var largePercentTotalLabel: UILabel!
    
    // TODO: add IBAction for the tipslider
    
    @IBAction func calculatorButtonTapped(_ sender: UIButton) {
        
        print(sender.tag)
        
        if sender.tag == 11 {
            
            totalLabel.text = "0"
            hasDecimalAlready = false
            decimalPlaces = 0
            smallPercentTipLabel.text = "0"
            smallPercentTotalLabel.text = "0"
            midPercentTipLabel.text = "0"
            midPercentTotalLabel.text = "0"
            largePercentTipLabel.text = "0"
            largePercentTotalLabel.text = "0"
        }
        
        else if sender.tag == 10 {
            
            if hasDecimalAlready == false {
                
                totalLabel.text! += String(".")
                hasDecimalAlready = true
            }
        }
        
        else if sender.tag < 10 {
            
            if Int(totalLabel.text!) == 0 {
                
                totalLabel.text = ""
            }
            
            if hasDecimalAlready == true {
                
                decimalPlaces += 1
                
                if decimalPlaces > 2 {
                    return
                }
            }
            
            totalLabel.text! += String(sender.tag)
            
            // Update totals on top beginning with smallest to largest
            
            //TODO: - change the int values to the percent variable that will be changed by the slider
            var tip = quantifyTip(percent: 5)
            let total = Double(totalLabel.text!)
            smallPercentTipLabel.text = String(tip)
            smallPercentTotalLabel.text = String(tip + total!)
            
            tip = quantifyTip(percent: 10)
            midPercentTipLabel.text = String(tip)
            midPercentTotalLabel.text = String(tip + total!)
            
            tip = quantifyTip(percent: 15)
            largePercentTipLabel.text = String(tip)
            largePercentTotalLabel.text = String(tip + total!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Game Methods
    
    func quantifyTip(percent:Int) -> Double {
        
        let percentage = Double(percent) * 0.01
        var totalAmount = Double(totalLabel.text!)
        totalAmount = round(totalAmount! * percentage, toNearest: 0.01)
        
        return totalAmount!
    }
    
}

// MARK: - Additional Methods

func round(_ value: Double, toNearest: Double) -> Double {
    return round(value / toNearest) * toNearest
}


