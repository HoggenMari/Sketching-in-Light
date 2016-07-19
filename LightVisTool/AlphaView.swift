//
//  BrightnessView.swift
//  SwiftHSVColorPicker
//
//  Created by johankasperi on 2015-08-20.
//

import UIKit

class AlphaView: UIView {
    
    var delegate: SwiftHSVColorPicker?
    
    var colorLayer: CAGradientLayer!
    var alphaLayer: CALayer!

    var point: CGPoint!
    var indicator = CAShapeLayer()
    var indicatorColor: CGColorRef = UIColor.lightGrayColor().CGColor
    var indicatorBorderWidth: CGFloat = 2.0
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        
        // Init the point at the correct position
        point = getPointFromColor(color)
        
        // Clear the background
        backgroundColor = UIColor.clearColor()
        
        // Create a gradient layer that goes from black to white
        // Create a gradient layer that goes from black to white
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if (!ok) {
            print("SwiftHSVColorPicker: exception <The color provided to SwiftHSVColorPicker is not convertible to HSV>")
        }
        
        alphaLayer = CALayer()
        alphaLayer.frame = CGRectMake(0, 7, self.frame.width, 10)
        alphaLayer.contents = createAlphaLayer(alphaLayer.frame.size)
        self.layer.addSublayer(alphaLayer)
        
        colorLayer = CAGradientLayer()
        colorLayer.colors = [
            UIColor.clearColor().CGColor,
            UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1).CGColor
        ]
        colorLayer.locations = [0.0, 1.0]
        colorLayer.startPoint = CGPointMake(0.0, 0.5)
        colorLayer.endPoint = CGPointMake(1.0, 0.5)
        colorLayer.frame = CGRect(x: 0, y: 7, width: self.frame.size.width, height: 10)
        // Insert the colorLayer into this views layer as a sublayer
        self.layer.insertSublayer(colorLayer, below: layer)
        
        // Add the indicator
        indicator.strokeColor = indicatorColor
        indicator.fillColor = indicatorColor
        indicator.lineWidth = indicatorBorderWidth
        self.layer.addSublayer(indicator)
    
        
        drawIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touch")
        touchHandler(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchHandler(touches)
    }
    
    func touchHandler(touches: Set<UITouch>) {
        // Set reference to the location of the touchesMoved in member point
        if let touch = touches.first {
            point = touch.locationInView(self)
        }
        
        point.y = self.frame.height/2
        point.x = getXCoordinate(point.x)
        // Notify delegate of the new brightness
        delegate?.alphaSelected(getAlphaFromPoint())
        
        drawIndicator()
    }
    
    func getXCoordinate(coord: CGFloat) -> CGFloat {
        // Offset the x coordinate to fit the view
        if (coord < 1) {
            return 1
        }
        if (coord > frame.size.width) {
            return frame.size.width
        }
        return coord
    }
    
    func drawIndicator() {
        // Draw the indicator
        if (point != nil) {
            indicator.path = UIBezierPath(roundedRect: CGRect(x: point.x-10, y: 2, width: 20, height: 20), cornerRadius: 3).CGPath
        }
    }
    
    func getAlphaFromPoint() -> CGFloat {
        // Get the brightness value for a given point
        return point.x/frame.size.width
    }
    
    func getPointFromColor(color: UIColor) -> CGPoint {
        // Update the indicator position for a given color
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if (!ok) {
            print("SwiftHSVColorPicker: exception <The color provided to SwiftHSVColorPicker is not convertible to HSV>")
        }
        
        return CGPoint(x: alpha * frame.width, y: frame.height / 2)
    }
    
    func setViewColor(color: UIColor!) {
        // Update the Gradient Layer with a given color
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0, alpha: CGFloat = 0.0
        let ok: Bool = color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if (!ok) {
            print("SwiftHSVColorPicker: exception <The color provided to SwiftHSVColorPicker is not convertible to HSV>")
        }
        colorLayer.colors = [
            UIColor.clearColor().CGColor,
            UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1).CGColor
        ]
    }
    
    func createAlphaLayer(size: CGSize) -> CGImageRef {
       
        var img = UIImage(named: "alpha.png")?.CGImage
    
        return img!

    }
    
}