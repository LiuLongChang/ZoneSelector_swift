//
//  ViewController.swift
//  TheCode
//
//  Created by 刘隆昌 on 16/2/22.
//  Copyright © 2016年 刘隆昌. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        label = UILabel(frame: CGRectMake(0,150,screenWidth,50))
        label.backgroundColor = UIColor.redColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "显示地址选择器"
        self.view.addSubview(label)
        
        label.userInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: "showAddressPickView")
        label.addGestureRecognizer(tap)
        
        
        
    }

    func showAddressPickView(){
        
        
        
        let addressPickView = AddressPickView.getShareInstance()
        self.view.addSubview(addressPickView)
        addressPickView.block = {(province: NSString,city: NSString,town: NSString)->Void in
            
            self.label.text = NSString(format: "%@ %@ %@", province,city,town) as String
            
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

