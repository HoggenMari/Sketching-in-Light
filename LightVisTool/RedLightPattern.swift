//
//  RedLightPattern.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 18.04.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit
import Darwin

class RedLightPattern: UIView {

    let pixelWidth = 17
    let pixelHeight = 12
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var img:UIImage = UIImage()

    var draw_width:CGFloat = 17.0
    var draw_height:CGFloat = 12.0
    var minBrushWidth:CGFloat = 12.0/12.0

    var lightSequence = Array<UIImage>()
    var sequenceCounter: Int = 0
    var lastRecCounterInc: CGFloat = 0.0
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 1.0
    var green: CGFloat = 1.0
    var blue: CGFloat = 1.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var isSwiping:Bool!
    
    var charImage: [UIImage] = [
        UIImage(named: "char_A.png")!,
        UIImage(named: "char_B.png")!,
        UIImage(named: "char_C.png")!,
        UIImage(named: "char_D.png")!,
        UIImage(named: "char_E.png")!,
        UIImage(named: "char_F.png")!,
        UIImage(named: "char_G.png")!,
        UIImage(named: "char_H.png")!,
        UIImage(named: "char_I.png")!,
        UIImage(named: "char_J.png")!,
        UIImage(named: "char_K.png")!,
        UIImage(named: "char_L.png")!,
        UIImage(named: "char_M.png")!,
        UIImage(named: "char_N.png")!,
        UIImage(named: "char_O.png")!,
        UIImage(named: "char_P.png")!,
        UIImage(named: "char_Q.png")!,
        UIImage(named: "char_R.png")!,
        UIImage(named: "char_S.png")!,
        UIImage(named: "char_T.png")!,
        UIImage(named: "char_U.png")!,
        UIImage(named: "char_V.png")!,
        UIImage(named: "char_W.png")!,
        UIImage(named: "char_X.png")!,
        UIImage(named: "char_Y.png")!,
        UIImage(named: "char_Z.png")!,
        UIImage(named: "char_0.png")!,
        UIImage(named: "char_1.png")!,
        UIImage(named: "char_2.png")!,
        UIImage(named: "char_3.png")!,
        UIImage(named: "char_4.png")!,
        UIImage(named: "char_5.png")!,
        UIImage(named: "char_6.png")!,
        UIImage(named: "char_7.png")!,
        UIImage(named: "char_8.png")!,
        UIImage(named: "char_9.png")!,
        
    ]
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
                
        let viewSizeWidth: CGFloat = bounds.width
        let viewSizeHeight: CGFloat = bounds.height
        
        appDelegate.viewSizeWidth = viewSizeWidth
        appDelegate.viewSizeHeight = viewSizeHeight
        
        //print("test")

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
                img = drawLine(appDelegate.counter)
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
                img = drawLineVertical(appDelegate.counter)
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
                img = drawBoxVertical(appDelegate.counter)
            }
        }else if(appDelegate.mode == 11){
            if(appDelegate.notification){
                if(appDelegate.counterUp){
                    img = drawText(0)
                }else{
                    img = drawText(1)
                }
            }
            else if(appDelegate.smooth){
                img = drawText(appDelegate.counter)
            }else{
                img = drawText(appDelegate.counter)
            }
        }else if(appDelegate.mode == 12){
            if(appDelegate.play){
                if(appDelegate.notification){
                    if(appDelegate.counterUp){
                        img = imageWithImage(drawImageSequence(0), scaledToSize: CGSize(width: 17, height: 12))
                    }else{
                        img = imageWithImage(drawImageSequence(1), scaledToSize: CGSize(width: 17, height: 12))
                    }
                }else{
                    //print(appDelegate.drawFrames)
                    if(appDelegate.drawFrames>1){
                        img = imageWithImage(drawImageSeqInterpolate(appDelegate.counter), scaledToSize: CGSize(width: 17, height: 12))
                    }
                }
            }else{
                img = imageWithImage(appDelegate.img_draw[appDelegate.currentFrame], scaledToSize: CGSize(width: 17, height: 12))
            }
            //if(!appDelegate.record && sequenceCounter>0){
            //    img = drawRecord(appDelegate.counter)
            //}
        }else if(appDelegate.mode == 13){
            img = drawImage(0)
        }        
        
        
        
        
        
        let context = UIGraphicsGetCurrentContext()
        //CGContextSetLineWidth(context, 1)
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
                }else if(appDelegate.mode == 11){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                }else if(appDelegate.mode == 12){
                    if(appDelegate.play){
                        let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                        CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                    }else{
                        let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: iy))
                        CGContextSetRGBFillColor(context, appDelegate.red * r, appDelegate.green * g, appDelegate.blue * b, appDelegate.brigtness * a)
                        
                        //let intCol = interpolateRGBColorFrom(UIColor.redColor(), end: UIColor.blueColor(), endWithFraction: 0.5)
                        //let c1 = CGColorGetComponents(intCol.CGColor)
                        //CGContextSetRGBFillColor(context, c1[0], c1[1], c1[2], c1[3])
                        
                    }
                    /*if(appDelegate.recordCounter != lastRecCounterInc){
                        lightSequence.append(img)
                        sequenceCounter++
                        lastRecCounterInc = appDelegate.recordCounter
                    }*/
                }else if(appDelegate.mode == 13){
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
                                
                let rectangle = CGRectMake(round(x_pos),round(y_pos),round(viewSizeWidth/CGFloat(pixelWidth)),round(viewSizeHeight/CGFloat(pixelHeight)))
                
                CGContextAddRect(context, rectangle)

                if(appDelegate.mode==12 && !appDelegate.play){
                    //CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
                    CGContextStrokePath(context)
                }else{
                    //CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
                }
                //CGContextStrokePath(context)
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
            
            let rectangle = CGRect(x: -1, y: (Int)(0.9+(value)*11), width: 19, height: 1)
            
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
    
    func drawImageSeqInterpolate(value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        
        if(appDelegate.notification){
            
            CGContextSetAlpha(context, 1)
            if(value==0){
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[0].CGImage)
            }else{
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[appDelegate.drawFrames-1].CGImage)
            }
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
        }else if(!appDelegate.smooth){
            
            var num = Int((value)*CGFloat(appDelegate.drawFrames))
            
            CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
        }else{
        
        var num = Int((value)*CGFloat(appDelegate.drawFrames))
        var num2: Int
        
        var timer = CGFloat(appDelegate.counter - CGFloat(Int((value)*CGFloat(appDelegate.drawFrames)))*CGFloat(1/CGFloat(appDelegate.drawFrames))) * CGFloat(appDelegate.drawFrames)
        
        if(appDelegate.counterUp){
            if(num<appDelegate.drawFrames-1){
                num2 = num + 1
            }else{
                num2 = num
            }
        }else{
            if(num>0){
                num2 = num - 1
            }else{
                num2 = 0
            }
        }
        
        //var num2 = (value)
        
        //CGContextSetBlendMode(context, CGBlendMode.Difference)
            
        if(appDelegate.counterUp){
            
            print("CounterUP: ")
            print(num)
            print(value)

            //if(num != num2){
                for ix in 0...pixelWidth-1 {
                    for iy in 0...pixelHeight-1 {
                    
                        if(num2<appDelegate.drawFrames && num2>=0 && num<appDelegate.drawFrames && num>=0){
                        let (r, g, b, a) = getPixelColor(appDelegate.img_draw[num], pos: CGPoint(x: ix,y: 11-iy))
                        let (r1, g1, b1, a1) = getPixelColor(appDelegate.img_draw[num2], pos: CGPoint(x: ix,y: 11-iy))

                        let interpol = interpolateRGBColorFrom(UIColor(red: r, green: g, blue: b, alpha: a), end: UIColor(red: r1, green: g1, blue: b1, alpha: a1), endWithFraction: pow(timer,1))
                        
                        let c1 = CGColorGetComponents(interpol.CGColor)
                        
                        CGContextSetRGBFillColor(context, appDelegate.red * c1[0], appDelegate.green * c1[1], appDelegate.blue * c1[2], appDelegate.brigtness * c1[3])
                        

                        let rectangle = CGRectMake(CGFloat(ix),CGFloat(iy),CGFloat(1),CGFloat(1))
                        if(appDelegate.mode==12){
                            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
                        }else{
                            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                        }
                        CGContextAddRect(context, rectangle)
                        //CGContextStrokePath(context)
                        CGContextFillRect(context, rectangle)
                        }
                    }
                }
            //}else{
            //    CGContextSetAlpha(context, 1)
            //    CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
            //}
        }else{
            //if(num != num2){
            
            print("CounterDown: ")
            print(num)
            print(value)

                for ix in 0...pixelWidth-1 {
                    for iy in 0...pixelHeight-1 {
                        
                        if(num2<appDelegate.drawFrames && num2>=0 && num<appDelegate.drawFrames && num>=0){
                        let (r, g, b, a) = getPixelColor(appDelegate.img_draw[num2], pos: CGPoint(x: ix,y: 11-iy))
                        let (r1, g1, b1, a1) = getPixelColor(appDelegate.img_draw[num], pos: CGPoint(x: ix,y: 11-iy))
                        
                        let interpol = interpolateRGBColorFrom(UIColor(red: r, green: g, blue: b, alpha: a), end: UIColor(red: r1, green: g1, blue: b1, alpha: a1), endWithFraction: pow(timer,1))
                        
                        let c1 = CGColorGetComponents(interpol.CGColor)
                        
                        CGContextSetRGBFillColor(context, appDelegate.red * c1[0], appDelegate.green * c1[1], appDelegate.blue * c1[2], appDelegate.brigtness * c1[3])
                        
                        
                        let rectangle = CGRectMake(CGFloat(ix),CGFloat(iy),CGFloat(1),CGFloat(1))
                        if(appDelegate.mode==12){
                            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
                        }else{
                            CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
                        }
                        CGContextAddRect(context, rectangle)
                        //CGContextStrokePath(context)
                        CGContextFillRect(context, rectangle)
                        }
                    }
                }
           // }else{
           //     CGContextSetAlpha(context, 1)
           //     CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
           // }
        }
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        }
    
    //print("NUMBER: "+String(num)+" "+String(num2)+" "+String((1-timer)+timer))
    return img;
    }

    
    func drawImageSequence(value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        if(appDelegate.notification){
            
            CGContextSetAlpha(context, 1)
            if(value==0){
            CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[0].CGImage)
            }else{
            CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[appDelegate.drawFrames-1].CGImage)
            }
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
        }else if(!appDelegate.smooth){
           
        var num = Int((value)*CGFloat(appDelegate.drawFrames))
            
        CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
            
        img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            
        }else{
        var num = Int((value)*CGFloat(appDelegate.drawFrames))
        var num2: Int
        
        var timer = CGFloat(appDelegate.counter - CGFloat(Int((value)*CGFloat(appDelegate.drawFrames)))*CGFloat(1/CGFloat(appDelegate.drawFrames))) * CGFloat(appDelegate.drawFrames)
        
        if(appDelegate.counterUp){
            if(num<appDelegate.drawFrames-1){
                num2 = num + 1
            }else{
                num2 = num
            }
        }else{
            if(num>0){
                num2 = num - 1
            }else{
                num2 = 0
            }
        }
        
        //var num2 = (value)
        
        //CGContextSetBlendMode(context, CGBlendMode.Difference)
        
        if(appDelegate.counterUp){
            if(num != num2){
                CGContextSetAlpha(context, 1-pow((timer-0.25),5))
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
                CGContextSetAlpha(context, pow((timer),2))
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num2].CGImage)
            }else{
                CGContextSetAlpha(context, 1)
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
            }
        }else{
            if(num != num2){
                CGContextSetAlpha(context, 1-pow(((1-timer)-0.25),5))
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
                CGContextSetAlpha(context, pow((1-timer),2))
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num2].CGImage)
            }else{
                CGContextSetAlpha(context, 1)
                CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
            }
        }
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        }
        
        
        //print("NUMBER: "+String(num)+" "+String(num2)+" "+String((1-timer)+timer))
        return img;
    }
    
    
    func drawRecord(value:CGFloat) -> UIImage {
        
        var img:UIImage!
    
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
        let context = UIGraphicsGetCurrentContext()
            
        //let rectangle = CGRect(x: -1, y: (Int)((value)*11), width: 19, height: 1)
        
        
        var i: UIImage
        if(Int(value*(CGFloat(sequenceCounter)-1))<0){
            i = lightSequence[0]
        }else if(Int(value*(CGFloat(sequenceCounter)-1))>=sequenceCounter){
            i = lightSequence[sequenceCounter-1]
        }else{
            i = lightSequence[Int(value*(CGFloat(sequenceCounter)-1))]
        }
        
        CGContextTranslateCTM(context, 0, 12);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), i.CGImage)
        
        //var rectangle:CGRect!
        //if(appDelegate.counterUp){
        //    rectangle = CGRect(x: -1, y: 0, width: 19, height: (Int)((value)*12))
        //}else{
        //    rectangle = CGRect(x: -1, y: 0, width: 19, height: (Int)((value)*12))
        //}
            
            
        /*CGContextSetLineWidth(context, 0)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextAddRect(context, rectangle)
        CGContextDrawPath(context, .FillStroke)*/
            
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
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
                rectangle = CGRect(x: 0, y: -1, width: (Int)(0.7+(value)*17), height: 19)
            }else{
                rectangle = CGRect(x: 0, y: -1, width: (Int)(0.7+(value)*17), height: 19)
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
    
    
    func drawText(value:CGFloat) -> UIImage {
        
        //NSLog("value: %f", value)
        //NSLog("Text: %d", appDelegate.text.characters.count)
        //NSLog("Character: %d", Array(arrayLiteral: appDelegate.text)[0])

        
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)(0.5+(value)*16), y: -1, width: 1, height: 14)
            
            //let image : UIImage = UIImage(named:"char_B.png")!
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            //CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16), y: 12-5, width: 4, height: 5), charImage[0].CGImage)
            
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16)+5, y: 12-5, width: 4, height: 5), charImage[1].CGImage)
            
            if(value==0){
            var i = 0;
            var len:CGFloat = CGFloat(appDelegate.text.characters.count-3) * -5
            for ch in appDelegate.text.utf8 {
                print(ch.hashValue-65)
                var i_x:Int = 5*i
                if(ch.hashValue<91 && ch.hashValue>64){
                    CGContextDrawImage(context, CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-65].CGImage)
                }else if(ch.hashValue<58 && ch.hashValue>47){
                    CGContextDrawImage(context, CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-22].CGImage)
                }
                i += 1
            }
            }
            
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)(0.5+(value)*16), y: -1, width: 1, height: 14)
            
            //let image : UIImage = UIImage(named:"char_B.png")!
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            //CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16), y: 12-5, width: 4, height: 5), charImage[0].CGImage)
            
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16)+5, y: 12-5, width: 4, height: 5), charImage[1].CGImage)
            
            var i = 0;
            var len:CGFloat = CGFloat(appDelegate.text.characters.count-3) * -5
            for ch in appDelegate.text.utf8 {
                print(ch.hashValue-65)
                var i_x:Int = (Int)((value) * len)+5*i
                if(ch.hashValue<91 && ch.hashValue>64){
                    CGContextDrawImage(context, CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-65].CGImage)
                }else if(ch.hashValue<58 && ch.hashValue>47){
                    CGContextDrawImage(context, CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-22].CGImage)
                }
                i += 1
            }
            
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)(0.5+(value)*16), y: -1, width: 1, height: 14)
            
            //let image : UIImage = UIImage(named:"char_B.png")!
            
            CGContextSetLineWidth(context, 0)
            CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
            CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
            CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
            //CGContextAddRect(context, rectangle)
            CGContextDrawPath(context, .FillStroke)
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16), y: 12-5, width: 4, height: 5), charImage[0].CGImage)
            
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16)+5, y: 12-5, width: 4, height: 5), charImage[1].CGImage)
            
            var i = 0;
            var len:CGFloat = CGFloat(appDelegate.text.characters.count-3) * -5
            
            var duration:CGFloat = CGFloat(value%(1/len) * len * -1);
            
            print(duration)
            
            for ch in appDelegate.text.utf8 {
                print(ch.hashValue-65)
                var i_x:Int = (Int)((value) * len)+5*i
                if(ch.hashValue<91 && ch.hashValue>64){
                    CGContextSetAlpha(context, duration*2)
                    CGContextDrawImage(context, CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-65].CGImage)
                    CGContextSetAlpha(context, 1-duration*1.2)
                    CGContextDrawImage(context, CGRect(x: i_x+1, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-65].CGImage)
                }else if(ch.hashValue<58 && ch.hashValue>47){
                    CGContextSetAlpha(context, duration*2)
                    CGContextDrawImage(context, CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-22].CGImage)
                    CGContextSetAlpha(context, 1-duration*1.2)
                    CGContextDrawImage(context, CGRect(x: i_x+1, y: 7-appDelegate.row, width: 4, height: 5), charImage[ch.hashValue-22].CGImage)
                }
                i += 1
            }
            
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
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
            
            let rectangle = CGRect(x: (Int)(0.5+(value)*16), y: -1, width: 1, height: 14)
            

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
        
        //let image : UIImage = UIImage(named:"char_A.png")!
        
        CGContextSetLineWidth(context, 0)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextFillRect(context, CGRect(x: 0, y: 0, width: 170, height: 120))
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextAddRect(context, rectangle)
        CGContextDrawPath(context, .FillStroke)
        //CGContextDrawImage(context, CGRect(x: 0, y: 0, width: 170, height: 120), image.CGImage)
        
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

    func drawImage(value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextDrawImage(context, CGRect(x:0, y:0, width: 170, height:120), imageWithImage(appDelegate.activeImage, scaledToSize: CGSize(width: 170, height: 120)).CGImage)
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
    }


    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
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
            
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), components[0], components[1], components[2], components[3])
            //CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), appDelegate.selectedColor.CGColor)
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
        
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), components[0], components[1], components[2], components[3])
            //CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), appDelegate.selectedColor.CGColor)
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
    
    
    func getPixelColor(img: UIImage, pos: CGPoint) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        
        if(img.CGImage != nil){
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
        
        }else{
            return(0, 0, 0, 0)
        }
    }
    
    func roundToPlaces(value:CGFloat, places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return CGFloat(round(Double(value) * divisor) / divisor)
    }
    

    func interpolateRGBColorFrom(start: UIColor, end: UIColor, endWithFraction: CGFloat) -> UIColor {
        
        var endWithFraction = max(0, endWithFraction)
        endWithFraction = min(1, endWithFraction)
        
        let c1 = CGColorGetComponents(start.CGColor)
        let c2 = CGColorGetComponents(end.CGColor)
        
        let r = c1[0] + (c2[0] - c1[0]) * endWithFraction;
        let g = c1[1] + (c2[1] - c1[1]) * endWithFraction;
        let b = c1[2] + (c2[2] - c1[2]) * endWithFraction;
        let a = c1[3] + (c2[3] - c1[3]) * endWithFraction;
        
        return UIColor(red: r, green: g, blue: b, alpha: a) //UIColor (colorLiteralRed: r, green: g, blue: b, alpha: a)
        
    }
    
    /*+ (UIColor *)interpolateRGBColorFrom:(UIColor *)start to:(UIColor *)end withFraction:(float)f {
    
    f = MAX(0, f);
    f = MIN(1, f);
    
    const CGFloat *c1 = CGColorGetComponents(start.CGColor);
    const CGFloat *c2 = CGColorGetComponents(end.CGColor);
    
    CGFloat r = c1[0] + (c2[0] - c1[0]) * f;
    CGFloat g = c1[1] + (c2[1] - c1[1]) * f;
    CGFloat b = c1[2] + (c2[2] - c1[2]) * f;
    CGFloat a = c1[3] + (c2[3] - c1[3]) * f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    
    + (UIColor *)interpolateHSVColorFrom:(UIColor *)start to:(UIColor *)end withFraction:(float)f {
    
    f = MAX(0, f);
    f = MIN(1, f);
    
    CGFloat h1,s1,v1,a1;
    [start getHue:&h1 saturation:&s1 brightness:&v1 alpha:&a1];
    
    CGFloat h2,s2,v2,a2;
    [end getHue:&h2 saturation:&s2 brightness:&v2 alpha:&a2];
    
    CGFloat h = h1 + (h2 - h1) * f;
    CGFloat s = s1 + (s2 - s1) * f;
    CGFloat v = v1 + (v2 - v1) * f;
    CGFloat a = a1 + (a2 - a1) * f;
    
    return [UIColor colorWithHue:h saturation:s brightness:v alpha:a];
    }*/


}
