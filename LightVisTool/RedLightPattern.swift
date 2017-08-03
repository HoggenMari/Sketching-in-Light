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
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
    override func draw(_ rect: CGRect) {
        // Drawing code
                
        let viewSizeWidth: CGFloat = bounds.width
        let viewSizeHeight: CGFloat = bounds.height
        
        appDelegate.viewSizeWidth = viewSizeWidth
        appDelegate.viewSizeHeight = viewSizeHeight
        
        //print("test")

        //appDelegate.mode = 14
        
        print(appDelegate.mode)
        
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
        }else if(appDelegate.mode == 12 || appDelegate.mode>14){
            if(appDelegate.play || appDelegate.sliderChanged){
                if(appDelegate.notification){
                    if(appDelegate.counterUp){
                        img = imageWithImage(drawImageSequence(0), scaledToSize: CGSize(width: 17, height: 12))
                    }else{
                        img = imageWithImage(drawImageSequence(1), scaledToSize: CGSize(width: 17, height: 12))
                    }
                }else{
                    //print(appDelegate.drawFrames)
                    if(appDelegate.imgSeq[appDelegate.seq].drawFrames>1){
                        img = imageWithImage(drawImageSeqInterpolate(appDelegate.counter), scaledToSize: CGSize(width: 17, height: 12))
                    }
                }
            }else{
                //img = imageWithImage(appDelegate.img_draw[appDelegate.currentFrame], scaledToSize: CGSize(width: 17, height: 12))
                img = imageWithImage((appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)]), scaledToSize: CGSize(width: 17, height: 12))

            }
            
            //if(!appDelegate.record && sequenceCounter>0){
            //    img = drawRecord(appDelegate.counter)
            //}
        }else if(appDelegate.mode == 13){
            img = drawImage(0)
        }else if(appDelegate.mode == 14){
            img = drawProcessing();
        }
        
        //img = drawProcessing();
        
        
        
        
        let context = UIGraphicsGetCurrentContext()
        //CGContextSetLineWidth(context, 1)
        context?.setStrokeColor(UIColor.white.cgColor)
        
        self.backgroundColor = UIColor.black
        
        
        

        //CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        for ix in 0...pixelWidth-1 {
            for iy in 0...pixelHeight-1 {
                if(appDelegate.mode == 0){
                    context?.setFillColor(red: appDelegate.red
                        , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                }else if(appDelegate.mode == 1){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            context?.setFillColor(red: appDelegate.red
                                , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                        }else{
                            context?.setFillColor(red: appDelegate.red
                                , green: appDelegate.green, blue: appDelegate.blue, alpha: 0)
                        }
                    }else if(appDelegate.smooth){
                        context?.setFillColor(red: appDelegate.red
                            , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness - appDelegate.counter)
                    }else{
                        context?.setFillColor(red: appDelegate.red
                        , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness - roundToPlaces(appDelegate.counter,places: 1))
                    }
                }else if(appDelegate.mode == 2){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            context?.setFillColor(red: appDelegate.red
                                , green: appDelegate.green-1, blue: appDelegate.blue-1, alpha: appDelegate.brigtness)
                        }else{
                            context?.setFillColor(red: appDelegate.red
                                , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                        }
                    }else if(appDelegate.smooth){
                        context?.setFillColor(red: appDelegate.red
                            , green: appDelegate.green - appDelegate.counter, blue: appDelegate.blue - appDelegate.counter, alpha: appDelegate.brigtness)
                    }else{
                        context?.setFillColor(red: appDelegate.red
                            , green: appDelegate.green - roundToPlaces(appDelegate.counter, places: 1), blue: appDelegate.blue - roundToPlaces(appDelegate.counter, places: 1), alpha: appDelegate.brigtness)
                    }
                }else if(appDelegate.mode == 3){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            context?.setFillColor(red: appDelegate.red-1
                                , green: appDelegate.green, blue: appDelegate.blue-1, alpha: appDelegate.brigtness)
                        }else{
                            context?.setFillColor(red: appDelegate.red
                                , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                        }
                    }else if(appDelegate.smooth){
                        context?.setFillColor(red: appDelegate.red - appDelegate.counter
                            , green: appDelegate.green, blue: appDelegate.blue - appDelegate.counter, alpha: appDelegate.brigtness)
                    }else{
                        context?.setFillColor(red: appDelegate.red - roundToPlaces(appDelegate.counter, places: 1)
                            , green: appDelegate.green, blue: appDelegate.blue - roundToPlaces(appDelegate.counter, places: 1), alpha: appDelegate.brigtness)
                    }
                }else if(appDelegate.mode == 4){
                    if(appDelegate.notification){
                        if(appDelegate.counterUp){
                            context?.setFillColor(red: appDelegate.red-1
                                , green: appDelegate.green-1, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                        }else{
                            context?.setFillColor(red: appDelegate.red
                                , green: appDelegate.green, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                        }
                    }else if(appDelegate.smooth){
                        context?.setFillColor(red: appDelegate.red - appDelegate.counter
                            , green: appDelegate.green - appDelegate.counter, blue: appDelegate.blue, alpha: appDelegate.brigtness)
                    }else{
                        context?.setFillColor(red: appDelegate.red - roundToPlaces(appDelegate.counter, places: 1)
                            , green: appDelegate.green - roundToPlaces(appDelegate.counter, places: 1), blue: appDelegate.blue, alpha: appDelegate.brigtness)
                    }
                }else if(appDelegate.mode == 5){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                    
                    //NSLog("pixel %d %d", ix, iy)
                    //NSLog("image %f", img.size.width)
                
                }else if(appDelegate.mode == 6){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 7){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 8){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 9){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 10){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 11){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 12 || appDelegate.mode > 13){
                    if((appDelegate.play || appDelegate.sliderChanged) && (appDelegate.imgSeq[appDelegate.seq].img_draw.count > 2)){
                        let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                        context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                    }else{
                        let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: iy))
                        context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                        
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
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
                }else if(appDelegate.mode == 14){
                    let (r, g, b, a) = getPixelColor(img, pos: CGPoint(x: ix,y: 11-iy))
                    context?.setFillColor(red: appDelegate.red * r, green: appDelegate.green * g, blue: appDelegate.blue * b, alpha: appDelegate.brigtness * a)
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
                                
                let rectangle = CGRect(x: round(x_pos),y: round(y_pos),width: round(viewSizeWidth/CGFloat(pixelWidth)),height: round(viewSizeHeight/CGFloat(pixelHeight)))
                
                context?.addRect(rectangle)

                if((appDelegate.mode==12 || appDelegate.mode > 13) && !appDelegate.play && !appDelegate.sliderChanged){
                    //CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
                    context?.strokePath()
                }else{
                    //CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
                }
                //CGContextStrokePath(context)
                context?.fill(rectangle)
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
    
    
    func imageWithImage(_ image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func drawProcessing() -> UIImage {
        
        var img:UIImage!
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        print(appDelegate.processing.count)
        if(appDelegate.processing.count != 0){
        var counter:NSInteger = 0
        for ix in 0...pixelWidth-1 {
            for iy in 0...pixelHeight-1 {

                let rectangle = CGRect(x: ix, y: iy, width: 1, height: 1)
                let color:UIColor = hexStringToUIColor(appDelegate.processing[counter+1])
                context?.setLineWidth(0)
                context?.setFillColor(color.cgColor)
                //CGContextFillRect(context, CGRect(x: 0, y: 0, width: 17, height: 12))
                //CGContextSetFillColorWithColor(context, UIColor.init(red: 1, green: 0, blue: 0, alpha: 1).CGColor)
                context?.addRect(rectangle)
                context?.drawPath(using: .fillStroke)
                counter += 1
            }
        }
        }
        
        img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func drawLine(_ value:CGFloat) -> UIImage {
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: -1, y: (Int)((value)*11), width: 19, height: 1)
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: -1, y: (Int)(0.9+(value)*11), width: 19, height: 1)
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
            let context = UIGraphicsGetCurrentContext()
        
            let rectangle = CGRect(x: -10, y: (Int)((value)*110), width: 190, height: 12)
        
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 170, height: 120))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
        
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }
    
    func drawBox(_ value:CGFloat) -> UIImage {
        
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
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
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
            
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
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
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 170, height: 120))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }
    
    func drawImageSeqInterpolate(_ value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        
        if(appDelegate.notification){
            
            context?.setAlpha(1)
            if(value==0){
                
                //CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[0].CGImage)
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[0].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
                
            }else{
                
                //CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[appDelegate.drawFrames-1].CGImage)
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].drawFrames)-1].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))

            }
            
            img = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            
        }else if(!appDelegate.smooth){
            
            //var num = Int((value)*CGFloat(appDelegate.drawFrames))
            let num = Int((value)*CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames)))
            
            print("Number")
            print(num)

            //CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
            if(num < appDelegate.imgSeq[appDelegate.seq].img_draw.count){
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }
            
            img = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            
        }else{
        
        //var num = Int((value)*CGFloat(appDelegate.drawFrames))
        let num = Int((value)*CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames)))
        var num2: Int
        
        //var timer = CGFloat(appDelegate.counter - CGFloat(Int((value)*CGFloat(appDelegate.drawFrames)))*CGFloat(1/CGFloat(appDelegate.drawFrames))) * CGFloat(appDelegate.drawFrames)
        let timer = CGFloat(appDelegate.counter - CGFloat(Int((value)*CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames))))*CGFloat(1/CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames)))) * CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames))
            
            
        if(appDelegate.counterUp){
            //if(num<appDelegate.drawFrames-1){
            if(num<(appDelegate.imgSeq[appDelegate.seq].drawFrames)-1){
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
                    
                        //if(num2<appDelegate.drawFrames && num2>=0 && num<appDelegate.drawFrames && num>=0){
                        //let (r, g, b, a) = getPixelColor(appDelegate.img_draw[num], pos: CGPoint(x: ix,y: 11-iy))
                        //let (r1, g1, b1, a1) = getPixelColor(appDelegate.img_draw[num2], pos: CGPoint(x: ix,y: 11-iy))

                        if(num2<appDelegate.imgSeq[appDelegate.seq].drawFrames && num2>=0 && num<appDelegate.imgSeq[appDelegate.seq].drawFrames && num>=0){
                        let (r, g, b, a) = getPixelColor((appDelegate.imgSeq[appDelegate.seq].img_draw[num]), pos: CGPoint(x: ix,y: 11-iy))
                        let (r1, g1, b1, a1) = getPixelColor((appDelegate.imgSeq[appDelegate.seq].img_draw[num2]), pos: CGPoint(x: ix,y: 11-iy))
                                
    
                            
                        let interpol = interpolateRGBColorFrom(UIColor(red: r, green: g, blue: b, alpha: a), end: UIColor(red: r1, green: g1, blue: b1, alpha: a1), endWithFraction: pow(timer,1))
                        
                        let c1 = interpol.cgColor.components
                        
                        context?.setFillColor(red: appDelegate.red * (c1?[0])!, green: appDelegate.green * (c1?[1])!, blue: appDelegate.blue * (c1?[2])!, alpha: appDelegate.brigtness * (c1?[3])!)
                        

                        let rectangle = CGRect(x: CGFloat(ix),y: CGFloat(iy),width: CGFloat(1),height: CGFloat(1))
                        if(appDelegate.mode==12 || appDelegate.mode > 13){
                            context?.setStrokeColor(UIColor.white.cgColor)
                        }else{
                            context?.setStrokeColor(UIColor.black.cgColor)
                        }
                        context?.addRect(rectangle)
                        //CGContextStrokePath(context)
                        context?.fill(rectangle)
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
                        
                        //if(num2<appDelegate.drawFrames && num2>=0 && num<appDelegate.drawFrames && num>=0){
                        //let (r, g, b, a) = getPixelColor(appDelegate.img_draw[num2], pos: CGPoint(x: ix,y: 11-iy))
                        //let (r1, g1, b1, a1) = getPixelColor(appDelegate.img_draw[num], pos: CGPoint(x: ix,y: 11-iy))
                        
                        if(num2<appDelegate.imgSeq[appDelegate.seq].drawFrames && num2>=0 && num<appDelegate.imgSeq[appDelegate.seq].drawFrames && num>=0){
                            let (r, g, b, a) = getPixelColor((appDelegate.imgSeq[appDelegate.seq].img_draw[num2]), pos: CGPoint(x: ix,y: 11-iy))
                            let (r1, g1, b1, a1) = getPixelColor((appDelegate.imgSeq[appDelegate.seq].img_draw[num]), pos: CGPoint(x: ix,y: 11-iy))
                        
                        let interpol = interpolateRGBColorFrom(UIColor(red: r, green: g, blue: b, alpha: a), end: UIColor(red: r1, green: g1, blue: b1, alpha: a1), endWithFraction: pow(timer,1))
                        
                        let c1 = interpol.cgColor.components
                        
                        context?.setFillColor(red: appDelegate.red * (c1?[0])!, green: appDelegate.green * (c1?[1])!, blue: appDelegate.blue * (c1?[2])!, alpha: appDelegate.brigtness * (c1?[3])!)
                        
                        
                        let rectangle = CGRect(x: CGFloat(ix),y: CGFloat(iy),width: CGFloat(1),height: CGFloat(1))
                        if(appDelegate.mode==12 || appDelegate.mode > 13){
                            context?.setStrokeColor(UIColor.white.cgColor)
                        }else{
                            context?.setStrokeColor(UIColor.black.cgColor)
                        }
                        context?.addRect(rectangle)
                        //CGContextStrokePath(context)
                        context?.fill(rectangle)
                        }
                    }
                }
           // }else{
           //     CGContextSetAlpha(context, 1)
           //     CGContextDrawImage(context, CGRect(x: 0, y:0, width: 17, height: 12), appDelegate.img_draw[num].CGImage)
           // }
        }
        img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    
        }
    
    //print("NUMBER: "+String(num)+" "+String(num2)+" "+String((1-timer)+timer))
    return img;
    }

    
    func drawImageSequence(_ value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        if(appDelegate.notification){
            
            context?.setAlpha(1)
            if(value==0){
            context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[0].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }else{
            context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].drawFrames)-1].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }
            
            img = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            
        }else if(!appDelegate.smooth){
           
        let num = Int((value)*CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames)))
            
        context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            
        img = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            
        }else{
        let num = Int((value)*CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames)))
        var num2: Int
        
        let timer = CGFloat(appDelegate.counter - CGFloat(Int((value)*CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames))))*CGFloat(1/CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames)))) * CGFloat((appDelegate.imgSeq[appDelegate.seq].drawFrames))
        
        if(appDelegate.counterUp){
            if(num<(appDelegate.imgSeq[appDelegate.seq].drawFrames)-1){
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
                context?.setAlpha(1-pow((timer-0.25),5))
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
                context?.setAlpha(pow((timer),2))
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num2].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }else{
                context?.setAlpha(1)
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }
        }else{
            if(num != num2){
                context?.setAlpha(1-pow(((1-timer)-0.25),5))
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
                context?.setAlpha(pow((1-timer),2))
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num2].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }else{
                context?.setAlpha(1)
                context?.draw(appDelegate.imgSeq[appDelegate.seq].img_draw[num].cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
            }
        }
        img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        }
        
        
        //print("NUMBER: "+String(num)+" "+String(num2)+" "+String((1-timer)+timer))
        return img;
    }
    
    
    func drawRecord(_ value:CGFloat) -> UIImage {
        
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
        
        context?.translateBy(x: 0, y: 12);
        context?.scaleBy(x: 1.0, y: -1.0);
        context?.draw(i.cgImage!, in: CGRect(x: 0, y:0, width: 17, height: 12))
        
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

    
    

    func drawBoxVertical(_ value:CGFloat) -> UIImage {
        
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
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
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
            
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
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
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 170, height: 120))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }
    
    
    func drawText(_ value:CGFloat) -> UIImage {
        
        //NSLog("value: %f", value)
        //NSLog("Text: %d", appDelegate.text.characters.count)
        //NSLog("Character: %d", Array(arrayLiteral: appDelegate.text)[0])

        
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)(0.5+(value)*16), y: -1, width: 1, height: 14)
            
            //let image : UIImage = UIImage(named:"char_B.png")!
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            //CGContextAddRect(context, rectangle)
            context?.drawPath(using: .fillStroke)
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16), y: 12-5, width: 4, height: 5), charImage[0].CGImage)
            
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16)+5, y: 12-5, width: 4, height: 5), charImage[1].CGImage)
            
            if(value==0){
            var i = 0;
            var len:CGFloat = CGFloat(appDelegate.text.characters.count-3) * -5
            for ch in appDelegate.text.utf8 {
                print(ch.hashValue-65)
                let i_x:Int = 5*i
                if(ch.hashValue<91 && ch.hashValue>64){
                    context?.draw(charImage[ch.hashValue-65].cgImage!, in: CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5))
                }else if(ch.hashValue<58 && ch.hashValue>47){
                    context?.draw(charImage[ch.hashValue-22].cgImage!, in: CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5))
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
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            //CGContextAddRect(context, rectangle)
            context?.drawPath(using: .fillStroke)
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16), y: 12-5, width: 4, height: 5), charImage[0].CGImage)
            
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16)+5, y: 12-5, width: 4, height: 5), charImage[1].CGImage)
            
            var i = 0;
            let len:CGFloat = CGFloat(appDelegate.text.characters.count-3) * -5
            for ch in appDelegate.text.utf8 {
                print(ch.hashValue-65)
                let i_x:Int = (Int)((value) * len)+5*i
                if(ch.hashValue<91 && ch.hashValue>64){
                    context?.draw(charImage[ch.hashValue-65].cgImage!, in: CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5))
                }else if(ch.hashValue<58 && ch.hashValue>47){
                    context?.draw(charImage[ch.hashValue-22].cgImage!, in: CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5))
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
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            //CGContextAddRect(context, rectangle)
            context?.drawPath(using: .fillStroke)
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16), y: 12-5, width: 4, height: 5), charImage[0].CGImage)
            
            //CGContextDrawImage(context, CGRect(x: (Int)((value)*16)+5, y: 12-5, width: 4, height: 5), charImage[1].CGImage)
            
            var i = 0;
            let len:CGFloat = CGFloat(appDelegate.text.characters.count-3) * -5
            
            let duration:CGFloat = CGFloat(value.truncatingRemainder(dividingBy: (1/len)) * len * -1);
            
            print(duration)
            
            for ch in appDelegate.text.utf8 {
                print(ch.hashValue-65)
                let i_x:Int = (Int)((value) * len)+5*i
                if(ch.hashValue<91 && ch.hashValue>64){
                    context?.setAlpha(duration*2)
                    context?.draw(charImage[ch.hashValue-65].cgImage!, in: CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5))
                    context?.setAlpha(1-duration*1.2)
                    context?.draw(charImage[ch.hashValue-65].cgImage!, in: CGRect(x: i_x+1, y: 7-appDelegate.row, width: 4, height: 5))
                }else if(ch.hashValue<58 && ch.hashValue>47){
                    context?.setAlpha(duration*2)
                    context?.draw(charImage[ch.hashValue-22].cgImage!, in: CGRect(x: i_x, y: 7-appDelegate.row, width: 4, height: 5))
                    context?.setAlpha(1-duration*1.2)
                    context?.draw(charImage[ch.hashValue-22].cgImage!, in: CGRect(x: i_x+1, y: 7-appDelegate.row, width: 4, height: 5))
                }
                i += 1
            }
            
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return img
    }
    
    func drawLineVertical(_ value:CGFloat) -> UIImage {
        
        var img:UIImage!
        
        if(appDelegate.notification){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)((value)*16), y: -1, width: 1, height: 14)
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }else if(!appDelegate.smooth){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 17, height: 12), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)(0.5+(value)*16), y: -1, width: 1, height: 14)
            

            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 17, height: 12))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)

            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }else{
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
            let context = UIGraphicsGetCurrentContext()
            
            let rectangle = CGRect(x: (Int)((value)*160), y: -10, width: 10, height: 140)
            
            context?.setLineWidth(0)
            context?.setFillColor(UIColor.black.cgColor)
            context?.fill(CGRect(x: 0, y: 0, width: 170, height: 120))
            context?.setFillColor(UIColor.white.cgColor)
            context?.addRect(rectangle)
            context?.drawPath(using: .fillStroke)
            
            img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            //return img
            img = imageWithImage(img, scaledToSize: CGSize(width: 17,height: 12))
        }
        return img
    }

    
    func drawRectangle(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let rectangle = CGRect(x: 85-(value+0.05)*85, y: 60-(value+0.05)*85, width: value*170, height: value*170)
        
        //let image : UIImage = UIImage(named:"char_A.png")!
        
        context?.setLineWidth(0)
        context?.setFillColor(UIColor.black.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: 170, height: 120))
        context?.setFillColor(UIColor.white.cgColor)
        context?.addRect(rectangle)
        context?.drawPath(using: .fillStroke)
        //CGContextDrawImage(context, CGRect(x: 0, y: 0, width: 170, height: 120), image.CGImage)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithImage(img!, scaledToSize: CGSize(width: 17,height: 12))
    }
    
    func drawEllipse(_ value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let rectangle = CGRect(x: 85-(value+0.05)*85, y: 60-(value+0.05)*85, width: value*170, height: value*170)
        
        context?.setLineWidth(0)
        context?.setFillColor(UIColor.black.cgColor)
        context?.fill(CGRect(x: 0, y: 0, width: 170, height: 120))
        context?.setFillColor(UIColor.white.cgColor)
        context?.addEllipse(in: rectangle)
        context?.drawPath(using: .fillStroke)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithImage(img!, scaledToSize: CGSize(width: 17,height: 12))
    }

    func drawImage(_ value:CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 170, height: 120), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        context?.draw(imageWithImage((appDelegate.activeImage), scaledToSize: CGSize(width: 170, height: 120)).cgImage!, in: CGRect(x:0, y:0, width: 170, height:120))
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageWithImage(img!, scaledToSize: CGSize(width: 17,height: 12))
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(appDelegate.mode==12 || appDelegate.mode > 13){
        //isSwiping    = false
        if let touch = touches.first{
            lastPoint = touch.location(in: self)
            
            UIGraphicsBeginImageContextWithOptions(CGSize(width: draw_width, height: draw_height), false, 1)
            //appDelegate.img_draw[appDelegate.currentFrame].drawInRect(CGRectMake(0, 0, draw_width, draw_height))
            appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)].draw(in: CGRect(x: 0, y: 0, width: draw_width, height: draw_height))
            UIGraphicsEndImageContext()

        }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(appDelegate.mode==12 || appDelegate.mode > 13){
    NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadCollection"), object: nil)
        
        //isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.location(in: self)
            
            let x1 = lastPoint.x/(self.frame.width/draw_width)
            let y1 = lastPoint.y/(self.frame.height/draw_height)
            let x2 = currentPoint.x/(self.frame.width/draw_width)
            let y2 = currentPoint.y/(self.frame.height/draw_height)
            UIGraphicsBeginImageContextWithOptions(CGSize(width: draw_width, height: draw_height), false, 1)

            //appDelegate.img_draw[appDelegate.currentFrame].drawInRect(CGRectMake(0, 0, draw_width, draw_height))
            appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)].draw(in: CGRect(x: 0, y: 0, width: draw_width, height: draw_height))
            
            //self.imageView.image?.drawInRect(CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height))
            //CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect(x: 0, y:0, width: 170, height: 120), img_draw2.CGImage)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: x1, y: y1))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: x2, y: y2))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(minBrushWidth)
            var components = appDelegate.selectedColor.cgColor.components
            
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: (components?[0])!, green: (components?[1])!, blue: (components?[2])!, alpha: (components?[3])!)
            //CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), appDelegate.selectedColor.CGColor)
            UIGraphicsGetCurrentContext()?.strokePath()
            //img = UIGraphicsGetImageFromCurrentImageContext()
            
            //appDelegate.img_draw[appDelegate.currentFrame] = UIGraphicsGetImageFromCurrentImageContext()
            appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)] = UIGraphicsGetImageFromCurrentImageContext()!
            
            //img_draw2 = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()
            lastPoint = currentPoint
            
        }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(appDelegate.mode==12 || appDelegate.mode > 13){
        NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadCollection"), object: nil)

        //if(!isSwiping) {
            // This is a single touch, draw a point
            let x1 = lastPoint.x/(self.frame.width/draw_width)
            let y1 = lastPoint.y/(self.frame.height/draw_height)
            UIGraphicsBeginImageContextWithOptions(CGSize(width: draw_width, height: draw_height), false, 1)
            
            //appDelegate.img_draw[appDelegate.currentFrame].drawInRect(CGRectMake(0, 0, draw_width, draw_height))
            appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)].draw(in: CGRect(x: 0, y: 0, width: draw_width, height: draw_height))

            
            //CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect(x: 0, y:0, width: 170, height: 120), img_draw2.CGImage)
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(minBrushWidth)
        
            var components = appDelegate.selectedColor.cgColor.components
        
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: (components?[0])!, green: (components?[1])!, blue: (components?[2])!, alpha: (components?[3])!)
            //CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), appDelegate.selectedColor.CGColor)
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: x1, y: y1))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: x1, y: y1))
            UIGraphicsGetCurrentContext()?.strokePath()
            //img = UIGraphicsGetImageFromCurrentImageContext()
            
            //appDelegate.img_draw[appDelegate.currentFrame] = UIGraphicsGetImageFromCurrentImageContext()
            appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)] = UIGraphicsGetImageFromCurrentImageContext()!

            
            //img_draw2 = UIGraphicsGetImageFromCurrentImageContext()

            UIGraphicsEndImageContext()
            
       // }
        }

    }
    
    
    func getPixelColor(_ img: UIImage, pos: CGPoint) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        
        if(img.cgImage != nil){
        let pixelData = img.cgImage?.dataProvider?.data
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
            print("nil")
            return(0, 0, 0, 0)
        }
    }
    
    func roundToPlaces(_ value:CGFloat, places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return CGFloat(round(Double(value) * divisor) / divisor)
    }
    

    func interpolateRGBColorFrom(_ start: UIColor, end: UIColor, endWithFraction: CGFloat) -> UIColor {
        
        var endWithFraction = max(0, endWithFraction)
        endWithFraction = min(1, endWithFraction)
        
        let c1 = start.cgColor.components
        let c2 = end.cgColor.components
        
        let r = (c1?[0])! + ((c2?[0])! - (c1?[0])!) * endWithFraction;
        let g = (c1?[1])! + ((c2?[1])! - (c1?[1])!) * endWithFraction;
        let b = (c1?[2])! + ((c2?[2])! - (c1?[2])!) * endWithFraction;
        let a = (c1?[3])! + ((c2?[3])! - (c1?[3])!) * endWithFraction;
        
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
