//
//  BackgroundLight.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 16.04.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit

class PreviewLight: UIView {

    let pixelWidth = 17
    let pixelHeight = 12
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var img:UIImage = UIImage()
    var draw_width:CGFloat = 17.0
    var draw_height:CGFloat = 12.0
    var minBrushWidth:CGFloat = 12.0/12.0
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 1.0
    var green: CGFloat = 1.0
    var blue: CGFloat = 1.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var isSwiping:Bool!

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let viewSizeWidth: CGFloat = bounds.width
        let viewSizeHeight: CGFloat = bounds.height

        let context = UIGraphicsGetCurrentContext()
        //CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
            UIColor.whiteColor().CGColor)
        
        self.backgroundColor = UIColor.blackColor()

        //appDelegate.img_draw[0].drawInRect(CGRectMake(0, 0, bounds.width, bounds.height))
        
        //CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        if(appDelegate.mode==12){
            
        img = imageWithImage(appDelegate.img_draw[appDelegate.currentFrame], scaledToSize: CGSize(width: 17, height: 12))
    
        for ix in 0...pixelWidth {
            for iy in 0...pixelHeight {
                let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: iy))
                CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                let x_pos : CGFloat = CGFloat(ix)*viewSizeWidth/CGFloat(pixelWidth)
                let y_pos : CGFloat = CGFloat(iy)*viewSizeHeight/CGFloat(pixelHeight)
                let rectangle = CGRectMake(x_pos,y_pos,viewSizeWidth/CGFloat(pixelWidth),viewSizeHeight/CGFloat(pixelHeight))
                CGContextAddRect(context, rectangle)
                CGContextStrokePath(context)
                CGContextFillRect(context, rectangle)
            }
        }
        }
        
        
        //let rectangle = CGRectMake(0,0,viewSizeWidth/17,viewSizeheight/12)
        //CGContextAddRect(context, rectangle)
        //CGContextStrokePath(context)
        
        
        //var path = UIBezierPath(ovalInRect: rect)
        //UIColor.greenColor().setFill()
        //path.fill()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("TouchesBegan")
        if(appDelegate.mode==12){
            //isSwiping    = false
            if let touch = touches.first{
                lastPoint = touch.locationInView(self)
                
                UIGraphicsBeginImageContextWithOptions(CGSize(width: draw_width, height: draw_height), false, 1)
                appDelegate.img_draw[appDelegate.currentFrame].drawInRect(CGRectMake(0, 0, draw_width, draw_height))
                UIGraphicsEndImageContext()
                
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("TouchesMoved")
        if(appDelegate.mode==12){
            NSNotificationCenter.defaultCenter().postNotificationName("reloadCollection", object: nil)
            
            //isSwiping = true;
            if let touch = touches.first{
                let currentPoint = touch.locationInView(self)
                
                let x1 = lastPoint.x/(self.frame.width/draw_width)
                let y1 = lastPoint.y/(self.frame.height/draw_height)
                let x2 = currentPoint.x/(self.frame.width/draw_width)
                let y2 = currentPoint.y/(self.frame.height/draw_height)
                UIGraphicsBeginImageContextWithOptions(CGSize(width: draw_width, height: draw_height), false, 1)
                appDelegate.img_draw[appDelegate.currentFrame].drawInRect(CGRectMake(0, 0, draw_width, draw_height))
                //self.imageView.image?.drawInRect(CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height))
                //CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect(x: 0, y:0, width: 170, height: 120), img_draw2.CGImage)
                CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x1, y1)
                CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x2, y2)
                CGContextSetLineCap(UIGraphicsGetCurrentContext(),CGLineCap.Round)
                CGContextSetLineWidth(UIGraphicsGetCurrentContext(), minBrushWidth)
                var components = CGColorGetComponents(appDelegate.selectedColor.CGColor)
                
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), components[0], components[1], components[2], 1.0)
                CGContextStrokePath(UIGraphicsGetCurrentContext())
                //img = UIGraphicsGetImageFromCurrentImageContext()
                appDelegate.img_draw[appDelegate.currentFrame] = UIGraphicsGetImageFromCurrentImageContext()
                //img_draw2 = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                lastPoint = currentPoint
                
            }
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        print("TouchesEnd")
        if(appDelegate.mode==12){
            NSNotificationCenter.defaultCenter().postNotificationName("reloadCollection", object: nil)
            
            //if(!isSwiping) {
            // This is a single touch, draw a point
            let x1 = lastPoint.x/(self.frame.width/draw_width)
            let y1 = lastPoint.y/(self.frame.height/draw_height)
            UIGraphicsBeginImageContextWithOptions(CGSize(width: draw_width, height: draw_height), false, 1)
            appDelegate.img_draw[appDelegate.currentFrame].drawInRect(CGRectMake(0, 0, draw_width, draw_height))
            //CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect(x: 0, y:0, width: 170, height: 120), img_draw2.CGImage)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), CGLineCap.Round)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), minBrushWidth)
            
            var components = CGColorGetComponents(appDelegate.selectedColor.CGColor)
            
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), components[0], components[1], components[2], 1.0)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x1, y1)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x1, y1)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            //img = UIGraphicsGetImageFromCurrentImageContext()
            appDelegate.img_draw[appDelegate.currentFrame] = UIGraphicsGetImageFromCurrentImageContext()
            //img_draw2 = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            // }
        }
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func getPixelColor(img: UIImage, pos: CGPoint) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(img.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        //let pixelInfo: Int = ((Int(img.size.height) * Int(pos.y)) + Int(pos.x)) * 4
        
        //NSLog("Pixel length: %d", data)
        
        let numberOfColorComponents = 4; // R,G,B, and A
        let x = pos.x;
        let y = pos.y;
        let w = 24;
        let pixelInfo = ((Int(w) * Int(y)) + Int(x)) * numberOfColorComponents;
        
        //NSLog("pixelInfo: %d", pixelInfo)
        
        let r = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        //NSLog("Pixel: %f %f %f %f %f", pos.x, pos.y, r, g, b)
        
        return (r, g, b, a)
    }

}
