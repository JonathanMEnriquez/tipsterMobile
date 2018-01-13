//
//  ViewController.swift
//  Tipster
//
//  Created by user on 1/10/18.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // TODO: add variables for percentage and people present that will change by the slider 
    var hasDecimalAlready = false
    var decimalPlaces = 0
    var percentage = 5
    //var incrementer: Double?
    var partySize = 1
    
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var groupSizeLabel: UILabel!
    @IBOutlet var smallPercentTipLabel: UILabel!
    @IBOutlet var smallPercentTotalLabel: UILabel!
    @IBOutlet var midPercentTipLabel: UILabel!
    @IBOutlet var midPercentTotalLabel: UILabel!
    @IBOutlet var largePercentTipLabel: UILabel!
    @IBOutlet var largePercentTotalLabel: UILabel!
    @IBOutlet var smallHeader: UILabel!
    @IBOutlet var midHeader: UILabel!
    @IBOutlet var largeHeader: UILabel!
    
    
    // TODO: add IBAction for the tipslider
    
    //TipSlider Function
    
    @IBAction func tipSliderChanged(_ sender: UISlider) {
        
        self.percentage = Int(sender.value)
        
        smallHeader.text = String(percentage) + "%"
        midHeader.text = String(percentage + 5) + "%"
        largeHeader.text = String(percentage + 10) + "%"
        
        updateAllLabels()
    }
    
    // Party Size Slider Function
    
    @IBAction func partySizeSliderMoved(_ sender: UISlider) {
        
        self.partySize = Int(sender.value)
        groupSizeLabel.text = "Group Size:" + String(Int(partySize))
        
        updateAllLabels()
        
    }
    
    
    
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
            
            updateAllLabels()
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
        let totalAmount = Double(totalLabel.text!)
        if totalAmount == nil {
            print ("No value in label in quantifytip method")
            return percentage
        }
        let tip = myRound(totalAmount! * percentage)
        
        return tip
    }
    
    func updateAllLabels() {
        
        var myTip = quantifyTip(percent: self.percentage)
        let currTotal = Double(totalLabel.text!)
        var updateTotal:Double = currTotal!
        var strTotal = ""
        var strTip = ""
        if currTotal == nil {
            print("No total")
            return
        }
        
        updateTotal += myTip
        updateTotal = myRound(updateTotal / Double(self.partySize))
        strTotal = String(describing: updateTotal)
        strTotal = addZeroIfNeeded(numString: strTotal)
        strTip = String(myTip)
        strTip = addZeroIfNeeded(numString: strTip)
        
        smallPercentTipLabel.text = strTip
        smallPercentTotalLabel.text = strTotal
        
        myTip = quantifyTip(percent: self.percentage + 5)
        updateTotal = currTotal!
        updateTotal += myTip
        updateTotal = myRound(updateTotal / Double(self.partySize))
        strTotal = String(describing: updateTotal)
        strTotal = addZeroIfNeeded(numString: strTotal)
        strTip = String(myTip)
        strTip = addZeroIfNeeded(numString: strTip)
        midPercentTipLabel.text = strTip
        midPercentTotalLabel.text = strTotal
        myTip = quantifyTip(percent: percentage + 10)
        updateTotal = currTotal!
        updateTotal += myTip
        updateTotal = myRound(updateTotal / Double(self.partySize))
        strTotal = String(describing: updateTotal)
        strTotal = addZeroIfNeeded(numString: strTotal)
        strTip = String(myTip)
        strTip = addZeroIfNeeded(numString: strTip)
        largePercentTipLabel.text = strTip
        largePercentTotalLabel.text = strTotal
    }
    
    func addZeroIfNeeded(numString: String) -> String {

        var num = numString
        
        let offset = num.count - 3
        
        let index2 = num.index(num.startIndex, offsetBy: offset)
        
        if num[index2] != "." {
            num += "0"
        }
        return num
    }
    
}

// MARK: - Additional Methods

func myRound(_ value: Double) -> Double {
    return round(value / 0.01) * 0.01
}



