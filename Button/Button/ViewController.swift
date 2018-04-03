//
//  ViewController.swift
//  Button
//
//  Created by 红鹊豆 on 2018/4/1.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button: ITButton!
    
    @IBOutlet weak var itMarginLabel: UILabel!
    @IBOutlet weak var insetLeftLabel: UILabel!
    @IBOutlet weak var insetRightLabel: UILabel!
    @IBOutlet weak var insetTopLabel: UILabel!
    @IBOutlet weak var insetBottomLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func setOffsetAction(_ sender: UISlider) {
        button.itMargin = CGFloat(sender.value)
        itMarginLabel.text = "\(button.itMargin)"
    }
    
    @IBAction func setInsetLeftAction(_ sender: UISlider) {
        var inset : UIEdgeInsets = button.itInset
        inset.left = CGFloat(sender.value )
        button.itInset = inset
        insetLeftLabel.text = "\(inset.left)"
    }
    
    @IBAction func setInsetRightAction(_ sender: UISlider) {
        var inset : UIEdgeInsets = button.itInset
        inset.right = CGFloat(sender.value )
        button.itInset = inset
        insetRightLabel.text = "\(inset.right)"
    }
    
    @IBAction func setInsetTopAction(_ sender: UISlider) {
        var inset : UIEdgeInsets = button.itInset
        inset.top = CGFloat(sender.value )
        button.itInset = inset
        insetTopLabel.text = "\(inset.top)"
    }
    
    @IBAction func setInsetBottomAction(_ sender: UISlider) {
        var inset : UIEdgeInsets = button.itInset
        inset.bottom = CGFloat(sender.value )
        button.itInset = inset
        insetBottomLabel.text = "\(inset.bottom)"
    }
    
    @IBAction func itAlignmentAction(_ sender: UISegmentedControl) {
        button.itAlignment = ITButton.ITAlignment(rawValue: sender.selectedSegmentIndex)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

