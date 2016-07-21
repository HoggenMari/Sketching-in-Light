//
//  ImageSequence.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 20.07.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit

public class ImageSequence {


    public var activeImage = UIImage()
    public var preview_image = UIImage()
    public var img_draw = Array<UIImage>()
    public var drawFrames:Int = 1
    public var currentFrame:Int = 0
    public var name:String = ""


    init() {
        
        img_draw.append(UIImage())
        img_draw.append(UIImage())
        
    
    }

}