//
//  RedLightPattern.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 18.04.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit

class RedLightPattern: UIView {

    let pixelWidth = 17
    let pixelHeight = 12
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let viewSizeWidth: CGFloat = bounds.width
        let viewSizeHeight: CGFloat = bounds.height
        
        var img:UIImage = UIImage()
        if(appDelegate.mode == 5){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawEllipse(0.7)
                }else{
                    img = drawEllipse(0)
                }
            }else if(appDelegate.smooth){
                img = drawEllipse(appDelegate.counter)
            }else{
                img = drawEllipse(roundToPlaces(appDelegate.counter, places:1))
            }
        }else if(appDelegate.mode == 6){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawRectangle(0.66)
                }else{
                    img = drawRectangle(0)
                }
            }
            else if(appDelegate.smooth){
                img = drawRectangle(appDelegate.counter)
            }else{
                img = drawRectangle(roundToPlaces(appDelegate.counter, places:1))
            }
        }else if(appDelegate.mode == 7){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawLine(0.5)
                }else{
                    img = drawLine(-1)
                }
            }
            else if(appDelegate.smooth){
                img = drawLine(appDelegate.counter)
            }else{
                img = drawLine(roundToPlaces(appDelegate.counter, places:1))
            }
        }else if(appDelegate.mode == 8){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawLineVertical(0.5)
                }else{
                    img = drawLineVertical(-1)
                }
            }
            else if(appDelegate.smooth){
                img = drawLineVertical(appDelegate.counter)
            }else{
                img = drawLineVertical(roundToPlaces(appDelegate.counter, places:1))
            }
        }else if(appDelegate.mode == 9){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawBox(0.5)
                }else{
                    img = drawBox(-1)
                }
            }
            else if(appDelegate.smooth){
                img = drawBox(appDelegate.counter)
            }else{
                img = drawBox(roundToPlaces(appDelegate.counter, places:1))
            }
        }else if(appDelegate.mode == 10){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawBoxVertical(0.5)
                }else{
                    img = drawBoxVertical(-1)
                }
            }
            else if(appDelegate.smooth){
                img = drawBoxVertical(appDelegate.counter)
            }else{
                img = drawBoxVertical(roundToPlaces(appDelegate.counter, places:1))
            }
        }
        
        
        
        
        
        
        let context = UIGraphicsGetCurrentContext()
        //CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
            UIColor.blackColor().CGColor)
        
        self.backgroundColor = UIColor.blackColor()
        
        
        

        //CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        for ix in 0...pixelWidth-1 {
            for iy in 0...pixelHeight-1 {
                if(appDelegate.mode == 0){
                    CGContextSetRGBFillColor(context, appDelegate.red
                        , appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                }else if(appDelegate.mode == 1){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            CGContextSetRGBFillColor(context, appDelegate.red
                                , appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                        }else{
                            CGContextSetRGBFillColor(context, appDelegate.red
                                , appDelegate.green, appDelegate.blue, 0)
                        }
                    }else if(appDelegate.smooth){
                        CGContextSetRGBFillColor(context, appDelegate.red
                            , appDelegate.green, appDelegate.blue, appDelegate.brigtness - appDelegate.counter)
                    }else{
                        CGContextSetRGBFillColor(context, appDelegate.red
                        , appDelegate.green, appDelegate.blue, appDelegate.brigtness - roundToPlaces(appDelegate.counter,places: 1))
                    }
                }else if(appDelegate.mode == 2){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            CGContextSetRGBFillColor(context, appDelegate.red
                                , appDelegate.green-1, appDelegate.blue-1, appDelegate.brigtness)
                        }else{
                            CGContextSetRGBFillColor(context, appDelegate.red
                                , appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                        }
                    }else if(appDelegate.smooth){
                        CGContextSetRGBFillColor(context, appDelegate.red
                            , appDelegate.green - appDelegate.counter, appDelegate.blue - appDelegate.counter, appDelegate.brigtness)
                    }else{
                        CGContextSetRGBFillColor(context, appDelegate.red
                            , appDelegate.green - roundToPlaces(appDelegate.counter, places: 1), appDelegate.blue - roundToPlaces(appDelegate.counter, places: 1), appDelegate.brigtness)
                    }
                }else if(appDelegate.mode == 3){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            CGContextSetRGBFillColor(context, appDelegate.red-1
                                , appDelegate.green, appDelegate.blue-1, appDelegate.brigtness)
                        }else{
                            CGContextSetRGBFillColor(context, appDelegate.red
                                , appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                        }
                    }else if(appDelegate.smooth){
                        CGContextSetRGBFillColor(context, appDelegate.red - appDelegate.counter
                            , appDelegate.green, appDelegate.blue - appDelegate.counter, appDelegate.brigtness)
                    }else{
                        CGContextSetRGBFillColor(context, appDelegate.red - roundToPlaces(appDelegate.counter, places: 1)
                            , appDelegate.green, appDelegate.blue - roundToPlaces(appDelegate.counter, places: 1), appDelegate.brigtness)
                    }
                }else if(appDelegate.mode == 4){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            CGContextSetRGBFillColor(context, appDelegate.red-1
                                , appDelegate.green-1, appDelegate.blue, appDelegate.brigtness)
                        }else{
                            CGContextSetRGBFillColor(context, appDelegate.red
                                , appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                        }
                    }else if(appDelegate.smooth){
                        CGContextSetRGBFillColor(context, appDelegate.red - appDelegate.counter
                            , appDelegate.green - appDelegate.counter, appDelegate.blue, appDelegate.brigtness)
                    }else{
                        CGContextSetRGBFillColor(context, appDelegate.red - roundToPlaces(appDelegate.counter, places: 1)
                            , appDelegate.green - roundToPlaces(appDelegate.counter, places: 1), appDelegate.blue, appDelegate.brigtness)
                    }
                }else if(appDelegate.mode == 5){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                    
                    //NSLog("pixel %d %d", ix, iy)
                    //NSLog("image %f", img.size.width)
                
                }else if(appDelegate.mode == 6){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                }else if(appDelegate.mode == 7){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                }else if(appDelegate.mode == 8){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                }else if(appDelegate.mode == 9){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                }else if(appDelegate.mode == 10){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                }/*else{
                //CGContextSetRGBFillColor(context, appDelegate.red, appDelegate.green, appDelegate.blue, CGFloat(appDelegate.brigtness-CGFloat(1.0/((CGFloat(ix)*appDelegate.counter)))))
                    CGContextSetRGBFillColor(context, appDelegate.red, appDelegate.green, appDelegate.blue, appDelegate.brigtness)
                    
                    if(CGFloat(iy)<6.0 + sqrt(50.0*appDelegate.counter-pow((CGFloat(ix)-8.0),2.0)) && CGFloat(iy)>=6.0){
                    
                    CGContextSetRGBFillColor(context, appDelegate.red, appDelegate.green, appDelegate.blue, 0.5)
                    
                    
                    }
                    
                    if(CGFloat(iy)>6.0 - sqrt(50.0*appDelegate.counter-pow((CGFloat(ix)-8.0),2.0)) && CGFloat(iy)<=6.0){
                        
                        CGContextSetRGBFillColor(context, appDelegate.red, appDelegate.green, appDelegate.blue, 0.5)
                        
                        
                    }
                    
                //NSLog("Test %f",(5.0 + sqrt(10.0-pow((CGFloat(ix)-10.0),2.0))))
                    
                }*/
                if(iy==0){
                    //CGContextSetRGBFillColor(context, 255, 0, 0, 255)
                }
                let x_pos : CGFloat = CGFloat(ix)*viewSizeWidth/CGFloat(pixelWidth)
                let y_pos : CGFloat = CGFloat(iy)*viewSizeHeight/CGFloat(pixelHeight)
                let rectangle = CGRectMake(x_pos,y_pos,viewSizeWidth/CGFloat(pixelWidth),viewSizeHeight/CGFloat(pixelHeight))
                CGContextAddRect(context, rectangle)
                CGContextStrokePath(context)
                CGContextFillRect(context, rectangle)
            }
        }

        UIGraphicsEndImageContext()

        //let rectangle = CGRectMake(10,10,170,120)
        //CGContextDrawImage(context, rectangle,  drawEllipse(roundToPlaces(appDelegate.counter, places:1)).CGImage)
        

        
        //let rectangle = CGRectMake(0,0,viewSizeWidth/17,viewSizeheight/12)
        //CGContextAddRect(context, rectangle)
        //CGContextStrokePath(context)
        
        
        //var path = UIBezierPath(ovalInRect: rect)
        //UIColor.greenColor().setFill()
        //path.fill()
    }
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func drawLine(value:CGFloat) -> UIImage {
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: -1, y: (Int)((value)*11), width: 19, height: 1)
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: -1, y: (Int)((value)*11), width: 19, height: 1)
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
            let context = UIGraphicsGetCurrentContext()
        
            let rectangle = CGRect(x: -10, y: (Int)((value)*110), width: 190, height: 12)
        
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
        
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }
    
    func drawBox(value:CGFloat) -> UIImage {
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            var rectangle:CGRect!
            if(appDelegate.counterUp){
                rectangle = CGRect(x: -1, y: 0, width: 19, height: (Int)((value)*12))
            }else{
                rectangle = CGRect(x: -1, y: 0, width: 19, height: (Int)((value)*12))
            }
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            //let rectangle = CGRect(x: -1, y: (Int)((value)*11), width: 19, height: 1)
            
            
            var rectangle:CGRect!
            if(appDelegate.counterUp){
                rectangle = CGRect(x: -1, y: 0, width: 19, height: (Int)((value)*12))
            }else{
                rectangle = CGRect(x: -1, y: 0, width: 19, height: (Int)((value)*12))
            }
            
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            var rectangle:CGRect!
            if(appDelegate.counterUp){
                rectangle = CGRect(x: -10, y: 0, width: 190, height: (Int)(((value)*122.5)+7.5))
            }else{
                rectangle = CGRect(x: -10, y: 0, width: 190, height: (Int)(((value)*122.5)+7.5))
            }
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }

    func drawBoxVertical(value:CGFloat) -> UIImage {
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            var rectangle:CGRect!
            if(appDelegate.counterUp){
                rectangle = CGRect(x: 0, y: -1, width: (Int)((value)*17), height: 14)
            }else{
                rectangle = CGRect(x: 0, y: -1, width: (Int)((value)*17), height: 14)
            }
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            //let rectangle = CGRect(x: -1, y: (Int)((value)*11), width: 19, height: 1)
            
            
            var rectangle:CGRect!
            if(appDelegate.counterUp){
                rectangle = CGRect(x: 0, y: -1, width: (Int)((value)*17), height: 19)
            }else{
                rectangle = CGRect(x: 0, y: -1, width: (Int)((value)*17), height: 19)
            }
            
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            var rectangle:CGRect!
            if(appDelegate.counterUp){
                rectangle = CGRect(x: 0, y: -10, width: (Int)(((value)*172.5)+7.5), height: 190)
            }else{
                rectangle = CGRect(x: 0, y: -10, width: (Int)(((value)*172.5)+7.5), height: 190)
            }
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }
    
    func drawLineVertical(value:CGFloat) -> UIImage {
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)((value)*16), y: -1, width: 1, height: 14)
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)((value)*16), y: -1, width: 1, height: 14)
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)((value)*160), y: -10, width: 10, height: 140)
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }

    
    func drawRectangle(value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let rectangle = CGRect(x: 85-(value+0.05)*85, y: 60-(value+0.05)*85, width: value*170, height: value*170)
        
        CGContextSetLineWidth(context, 0)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextAddRect(context, rectangle)
        CGContextDrawPath(context, .FillStroke)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
    }
    
    func drawEllipse(value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let rectangle = CGRect(x: 85-(value+0.05)*85, y: 60-(value+0.05)*85, width: value*170, height: value*170)
        
        CGContextSetLineWidth(context, 0)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextAddEllipseInRect(context, rectangle)
        CGContextDrawPath(context, .FillStroke)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
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
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        //NSLog("Pixel: %f %f %f %f %f", pos.x, pos.y, r, g, b)
        
        return (r, g, b, a)
    }
    
    func roundToPlaces(value:CGFloat, places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return CGFloat(round(Double(value) * divisor) / divisor)
    }
    
    

}
