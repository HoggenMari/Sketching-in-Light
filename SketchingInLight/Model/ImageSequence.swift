//
//  ImageSequence.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 20.07.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit

open class ImageSequence {


    open var activeImage = UIImage()
    open var preview_image = UIImage()
    open var img_draw = Array<UIImage>()
    open var drawFrames:Int = 1
    open var currentFrame:Int = 0
    open var name:String = ""


    init() {
        
        img_draw.append(UIImage())
        img_draw.append(UIImage())
        
    
    }

}
