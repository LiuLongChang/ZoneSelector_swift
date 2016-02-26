//
//  KitTool.swift
//  TheCode
//
//  Created by 刘隆昌 on 16/2/25.
//  Copyright © 2016年 刘隆昌. All rights reserved.
//

import UIKit


extension UIView {
    
    
    func CGRectGetCenter(rect:CGRect)->CGPoint{
        var pt : CGPoint = CGPointMake(0, 0)
        pt.x = CGRectGetMidX(rect)
        pt.y = CGRectGetMidY(rect)
        return pt
    }
    
    
    func CGRectMoveToCenter(rect:CGRect,center:CGPoint)->CGRect{
        
        var newRect : CGRect = CGRectZero
        newRect.origin.x = center.x - CGRectGetMidX(rect)
        newRect.origin.y = center.y - CGRectGetMidY(rect)
        newRect.size = rect.size
        return newRect
        
    }
    
    
    func origin()->CGPoint{
        return self.frame.origin
    }
    
    func setOrigin(aPoint:CGPoint){
        
        var newFrame = self.frame
        newFrame.origin = aPoint
        self.frame = newFrame
        
    }
    
    func size()->CGSize{
        return self.frame.size;
    }
    
    func setSize(aSize:CGSize){
        var newFrame = self.frame
        newFrame.size = aSize
        self.frame =  newFrame
    }
    
    
    
    func bottomRight()->(CGPoint){
        
        let x : CGFloat = self.frame.origin.x + self.frame.size.width
        let y : CGFloat = self.frame.origin.y + self.frame.size.height
        return CGPointMake(x, y)
        
    }
    
    func bottomLeft()->(CGPoint){
        
        let x : CGFloat = self.frame.origin.x
        let y : CGFloat = self.frame.origin.y + self.frame.size.height
        return CGPointMake(x, y)
        
    }
    
    func topRight()->(CGPoint){
        
        let x : CGFloat = self.frame.origin.x + self.frame.size.width
        let y : CGFloat = self.frame.origin.y
        return CGPointMake(x, y)
        
    }
    
    
    func height()->CGFloat{
        return self.frame.size.height
    }
    
    func setHeight(newHeight:CGFloat){
        var newFrame = self.frame
        newFrame.size.height = newHeight
        self.frame = newFrame
    }
    
    
    func width()->CGFloat{
        return self.frame.size.width
    }
    
    func setWidth(newWidth:CGFloat){
        var newFrame = self.frame
        newFrame.size.width = newWidth
        self.frame = newFrame
    }
    
    
    
    func top()->CGFloat{
        return self.frame.origin.y
    }
    
    func setTop(newTop:CGFloat){
        var newFrame = self.frame
        newFrame.origin.y = newTop
        self.frame = newFrame
    }
    
    
    
    func left()->CGFloat{
        return self.frame.origin.x
    }
    
    func setLeft(newLeft:CGFloat){
        var newFrame = self.frame
        newFrame.origin.x = newLeft
        self.frame = newFrame
    }
    
    
    
    func bottom()->CGFloat{
        return self.frame.origin.y+self.frame.size.height
    }
    
    func setBottom(newBottom:CGFloat){
        var newFrame = self.frame
        newFrame.origin.y = newBottom - self.frame.size.height
        self.frame = newFrame
    }
    
    
    
    
    
    func right()->CGFloat{
        return self.frame.origin.x+self.frame.size.width
    }
    
    func setRight(newRight:CGFloat){
        var newFrame = self.frame
        var delta = newRight - (self.frame.origin.x + self.frame.size.width)
        newFrame.origin.x += delta
        self.frame = newFrame
    }
    
    
    
    
    
}




class KitTool: NSObject {

    
    
    
    
}
