//
//  AddressPickView.swift
//  TheCode
//
//  Created by 刘隆昌 on 16/2/22.
//  Copyright © 2016年 刘隆昌. All rights reserved.
//

import UIKit

let navigationViewHeight : Double = 44.0
let pickViewViewHeight : Double = 200.0
let buttonWidth : Double = 60.0
let windowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)


let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height

typealias AdressBlock = (province:NSString,city:NSString,town:NSString)->Void


class AddressPickView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    
    var pickerDic  : NSDictionary?
    var provinceArray : NSArray?
    var selectedArray : NSArray?
    var cityArray : NSArray?
    var townArray : NSArray?
    var bottomView : UIView? //包括导航视图和地址选择视图
    var pickView : UIPickerView? //地址选择视图
    var navigationView : UIView? //上面的导航视图
    
    
    var block : AdressBlock?
    
    private static let _shareInstance = AddressPickView()
    
    
    class func getShareInstance()->AddressPickView{
        
        
        _shareInstance.showBottomV()
        
        return _shareInstance
        
        
    }
    
    
    func showBottomView(){
        
        
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        self.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        self.addTapGestureRecognizerToSelf()
        self.getPickerData()
        self.createView()
        
    }
    

    
    func getPickerData(){
        
        let path = NSBundle.mainBundle().pathForResource("Address", ofType: "plist")
        self.pickerDic = NSDictionary(contentsOfFile: path!)
        self.provinceArray = self.pickerDic?.allKeys
        
        let array = self.pickerDic?.allKeys as! NSArray
        
        self.selectedArray = self.pickerDic?.objectForKey(array[0] as! String) as! NSArray
        if (self.selectedArray!.count > 0){
            self.cityArray = self.selectedArray?.objectAtIndex(0).allKeys
        }
        
        if(self.cityArray!.count > 0){
            self.townArray = self.selectedArray?.objectAtIndex(0).objectForKey((self.cityArray?.objectAtIndex(0))!) as! [String]
        }
        
        
        
    }
    
    
    
    
    
    func addTapGestureRecognizerToSelf(){
        
        self.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "hiddenBottomView")
        self.addGestureRecognizer(tap)
        
    }
    
    func createView(){
        
        
        bottomView = UIView(frame: CGRectMake(0,CGFloat(screenHeight), CGFloat(screenWidth),CGFloat(navigationViewHeight+pickViewViewHeight)))
        self.addSubview(bottomView!)
        
        navigationView = UIView(frame: CGRectMake(0,0,CGFloat(screenWidth),CGFloat(navigationViewHeight)))
        navigationView?.backgroundColor = UIColor.lightGrayColor()
        bottomView?.addSubview(navigationView!)
        let tapNavigationView = UITapGestureRecognizer(target: self, action: nil)
        navigationView?.addGestureRecognizer(tapNavigationView)
        let buttonTitleArray = ["取消","确定"]
        
        
        
        for index in 0...(buttonTitleArray.count-1) {
            let button = UIButton(type: .System)
            button.frame = CGRectMake(CGFloat(Double(index)*(Double(screenWidth)-buttonWidth)),0, CGFloat(buttonWidth),CGFloat(navigationViewHeight))
            button.setTitle(buttonTitleArray[index], forState: .Normal)
            navigationView?.addSubview(button)
            button.tag = index
            button.addTarget(self, action: "tapButton:", forControlEvents: .TouchUpInside)
        }
        
        
        self.pickView = UIPickerView(frame: CGRectMake(0, CGFloat(navigationViewHeight),CGFloat(screenWidth), CGFloat(pickViewViewHeight)))
        self.pickView?.backgroundColor = UIColor.whiteColor()
        pickView?.dataSource = self
        pickView?.delegate = self
        bottomView?.addSubview(self.pickView!);
        
    }
    
    
    
    
    
    func tapButton(button:UIButton){
        
        if(button.tag == 1){
            let index0 = self.pickView?.selectedRowInComponent(0)
            let province = self.provinceArray?.objectAtIndex(index0!) as! NSString
            
            
            let index1 = self.pickView?.selectedRowInComponent(1)
            let city = self.cityArray?.objectAtIndex(index1!) as! NSString
            
            let index2 = self.pickView?.selectedRowInComponent(2)
            let town = self.townArray?.objectAtIndex(index2!) as! NSString
            
            self.block?(province: province,city: city,town: town)
            
            
        }
        self.hiddenBottomView()
        
    }
    
    
    func showBottomV(){
        
        
        self.backgroundColor = UIColor.clearColor()
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.bottomView?.setTop(screenHeight - CGFloat(navigationViewHeight) - CGFloat(pickViewViewHeight) )
            self.backgroundColor = windowColor
            
            }) { (finished) -> Void in
                
        }
        
        
    }
    
    func hiddenBottomView(){
        
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.backgroundColor = windowColor
            self.bottomView?.setTop(screenHeight)
            
            }) { (finished) -> Void in
            
                self.removeFromSuperview()
                
        }
        
        
        
    }
    
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return (provinceArray?.count)!
        }else if(component == 1){
            return (cityArray?.count)!
        }else{
            return townArray!.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(16.0)
        if(component == 0){
            label.text = self.provinceArray?.objectAtIndex(row) as? String
        }else if(component == 1){
            label.text = self.cityArray?.objectAtIndex(row) as? String
        }else{
            label.text = self.townArray?.objectAtIndex(row) as? String
        }
        return label
    }
    
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let pickViewWidth = screenWidth/3
        return pickViewWidth
    }
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (component == 0) {
            
            
            let str = self.provinceArray?.objectAtIndex(row) as? String
            self.selectedArray = self.pickerDic?.objectForKey(str!) as! NSArray
            if(self.selectedArray?.count > 0){
                
                self.cityArray = self.selectedArray?.objectAtIndex(0).allKeys
                
            }else{
                self.cityArray = nil
            }
            
            
            
            if(self.cityArray?.count > 0){
                
                let str = self.cityArray?.objectAtIndex(0)
                self.townArray  = (self.selectedArray?.objectAtIndex(0) as! NSDictionary).objectForKey(str!) as! NSArray
            }else{
                self.townArray = nil
            }
            
        }
        
        pickerView.selectedRowInComponent(1)
        pickerView.reloadComponent(1)
        pickerView.selectedRowInComponent(2)
        
        if(component == 1){
            if(self.selectedArray?.count > 0 && self.cityArray?.count > 0){
                self.townArray = (self.selectedArray?.objectAtIndex(0) as! NSDictionary).objectForKey(self.cityArray?.objectAtIndex(row) as! String) as! NSArray
                
            }else{
                self.townArray = nil
            }
            pickerView.selectRow(1, inComponent: 2, animated: true)
            
        }
        pickerView.reloadComponent(2)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
}
