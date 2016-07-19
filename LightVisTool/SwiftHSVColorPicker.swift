//
//  SwiftHSVColorPicker.swift
//  SwiftHSVColorPicker
//
//  Created by johankasperi on 2015-08-20.
//

import UIKit

public class SwiftHSVColorPicker: UIView {
    var colorWheel: ColorWheel!
    var brightnessView: BrightnessView!
    var alphaView: AlphaView!
    var selectedColorView: SelectedColorView!

    public var color: UIColor!
    var hue: CGFloat = 1.0
    var saturation: CGFloat = 1.0
    var brightness: CGFloat = 1.0
    var alph: CGFloat = 1.0
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setViewColor(color: UIColor) {
        var hue: CGFloat = 1.0, saturation: CGFloat = 1.0, brightness: CGFloat = 1.0, alpha: CGFloat = 1.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if (!ok) {
            print("SwiftHSVColorPicker: exception <The color provided to SwiftHSVColorPicker is not convertible to HSV>")
        }
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.color = color
        self.alph = alpha
        setup()
    }
    
    func setup() {
        // Remove all subviews
        let views = self.subviews
        for view in views {
            view.removeFromSuperview()
        }
        
        let selectedColorViewHeight: CGFloat = 0.0
        let brightnessViewHeight: CGFloat = 25.0
        let alphaViewHeight: CGFloat = 25.0

        
        // let color wheel get the maximum size that is not overflow from the frame for both width and height
        let colorWheelSize = min(self.bounds.width, self.bounds.height-10)
        
        // let the all the subviews stay in the middle of universe horizontally
        let centeredX = (self.bounds.width - colorWheelSize) / 2.0
        
        // Init SelectedColorView subview
        selectedColorView = SelectedColorView(frame: CGRect(x: 0, y:0, width: 0, height: 0), color: self.color)
        // Add selectedColorView as a subview of this view
        self.addSubview(selectedColorView)
        
        // Init new ColorWheel subview
        colorWheel = ColorWheel(frame: CGRect(x: 5, y: 0, width: colorWheelSize, height: colorWheelSize), color: self.color)
        colorWheel.delegate = self
        // Add colorWheel as a subview of this view
        self.addSubview(colorWheel)
        
        // Init new BrightnessView subview
        alphaView = AlphaView(frame: CGRect(x: colorWheelSize+30, y: colorWheelSize-alphaViewHeight, width: colorWheelSize-20, height: brightnessViewHeight), color: self.color)
        alphaView.delegate = self
        // Add brightnessView as a subview of this view
        self.addSubview(alphaView)

        // Init new BrightnessView subview
        brightnessView = BrightnessView(frame: CGRect(x: colorWheelSize+30, y: colorWheelSize-brightnessViewHeight-alphaViewHeight-10, width: colorWheelSize-20, height: brightnessViewHeight), color: self.color)
        brightnessView.delegate = self
        // Add brightnessView as a subview of this view
        self.addSubview(brightnessView)
        
    }
    
    func hueAndSaturationSelected(hue: CGFloat, saturation: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: self.alph)
        brightnessView.setViewColor(self.color)
        selectedColorView.setViewColor(self.color)
        alphaView.setViewColor(self.color)
    }
    
    func brightnessSelected(brightness: CGFloat) {
        self.brightness = brightness
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: self.alph)
        colorWheel.setViewBrightness(brightness)
        selectedColorView.setViewColor(self.color)
        alphaView.setViewColor(self.color)
    }
    
    func alphaSelected(alpha: CGFloat) {
        self.alph = alpha
        self.color = UIColor(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: self.alph)
        colorWheel.setViewBrightness(brightness)
        selectedColorView.setViewColor(self.color)
        brightnessView.setViewColor(self.color)
        colorWheel.setViewAlpha(alph)
    }
}
