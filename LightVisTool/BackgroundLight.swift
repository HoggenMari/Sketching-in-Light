//
//  BackgroundLight.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 16.04.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit

class BackgroundLight: UIView {

    let pixelWidth = 17
    let pixelHeight = 12
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let viewSizeWidth: CGFloat = bounds.width
        let viewSizeHeight: CGFloat = bounds.height

        let context = UIGraphicsGetCurrentContext()
        //CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
            UIColor.blackColor().CGColor)
        
        self.backgroundColor = UIColor.blackColor()

        
        //CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        for ix in 0...pixelWidth {
            for iy in 0...pixelHeight {
                CGContextSetRGBFillColor(context, appDelegate.red
                    , appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                let x_pos : CGFloat = CGFloat(ix)*viewSizeWidth/CGFloat(pixelWidth)
                let y_pos : CGFloat = CGFloat(iy)*viewSizeHeight/CGFloat(pixelHeight)
                let rectangle = CGRectMake(x_pos,y_pos,viewSizeWidth/CGFloat(pixelWidth),viewSizeHeight/CGFloat(pixelHeight))
                CGContextAddRect(context, rectangle)
                CGContextStrokePath(context)
                CGContextFillRect(context, rectangle)
            }
        }
        //let rectangle = CGRectMake(0,0,viewSizeWidth/17,viewSizeheight/12)
        //CGContextAddRect(context, rectangle)
        //CGContextStrokePath(context)
        
        
        //var path = UIBezierPath(ovalInRect: rect)
        //UIColor.greenColor().setFill()
        //path.fill()
    }
    

}
