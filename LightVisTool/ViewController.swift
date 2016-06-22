//
//  ViewController.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 15.04.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["None", "Fade Brightness", "Fade Red", "Fade Green", "Fade Blue", "Ellipse", "Rectangle", "Horizontal Line", "Vertical Line", "Horizontal Box", "Vertical Box", "Text", "LightPattern"]

    var images:NSArray = ["red_pattern.jpg", "green_pattern.jpg", "red_pattern.jpg", "green_pattern.jpg","circle.png", "default.png", "circle.png", "default.png"]

    var logoImage: [UIImage] = [
        UIImage(named: "default.png")!,
        UIImage(named: "brightness_pattern.jpg")!,
        UIImage(named: "red_pattern.jpg")!,
        UIImage(named: "green_pattern.jpg")!,
        UIImage(named: "blue_pattern.jpg")!,
        UIImage(named: "circle_pattern.jpg")!,
        UIImage(named: "rect_pattern.jpg")!,
        UIImage(named: "line_pattern.jpg")!,
        UIImage(named: "line2_pattern.jpg")!,
        UIImage(named: "line3_pattern.jpg")!,
        UIImage(named: "line4_pattern.jpg")!,
        UIImage(named: "line4_pattern.jpg")!,
        UIImage(named: "line4_pattern.jpg")!


    ]

    @IBOutlet var smooth: UISwitch!
    @IBOutlet var notification: UISwitch!
    @IBOutlet var smoothLabel: UILabel!
    @IBOutlet var backwardsLabel: UILabel!
    
    @IBOutlet var backgroundLight: RedLightPattern!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    @IBOutlet var brightness: UISlider!
    @IBOutlet var red: UISlider!
    @IBOutlet var green: UISlider!
    @IBOutlet var blue: UISlider!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var timeProgress: UISlider!
    
    @IBOutlet var backwardLoop: UISwitch!
    @IBOutlet var lightPatternCollectionView: UICollectionView!
    
    @IBOutlet var lightPatternLabel: UILabel!
    
    @IBOutlet var lightPatternImage: UIImageView!
    
    @IBOutlet var textOptionView: UIView!
    @IBOutlet var lightPatternOptionView: UIView!
    @IBOutlet var textLabel: UITextField!
    
    @IBOutlet var recordButtonOut: UIButton!
    
    let screenSizeWidth = UIScreen.mainScreen().bounds.width
    let screenSizeHeight = UIScreen.mainScreen().bounds.height
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var ipadDiagonal:CGFloat = 12.9
    var ipadFormat:CGFloat = 1.333984375
    var backgroundLightSizeWidth: CGFloat = 0.0
    var backgroundLightSizeHeight: CGFloat = 0.0
    var ipadSizeWidth: CGFloat = 0.0
    var ipadSizeHeight: CGFloat = 0.0
    let test = sqrt(1.0/100.0)
    let modelName = UIDevice().type.rawValue

    var timer = NSTimer()
    var recTimer = NSTimer()
    
    var play: Bool = true
    var speed: CGFloat = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSLog("Model-Name %@", modelName)
        
        if(modelName == "iPad 3"){
            NSLog("GOOOO")
            ipadDiagonal = 9.7
            ipadFormat = 1.3333

            ipadSizeHeight = ipadDiagonal*sqrt(1.0/(pow(ipadFormat,2.0)+1))
            ipadSizeWidth = ipadFormat*ipadDiagonal*sqrt(1.0/(pow(ipadFormat, 2.0)+1.0))
            
            backgroundLightSizeWidth = (screenSizeWidth/ipadSizeWidth)*0.85*5.9
            backgroundLightSizeHeight = (screenSizeWidth/ipadSizeWidth)*0.87*4.03
        }else{
            ipadDiagonal = 12.9
            ipadFormat = 1.3333
            
            ipadSizeHeight = ipadDiagonal*sqrt(1.0/(pow(ipadFormat,2.0)+1))
            ipadSizeWidth = ipadFormat*ipadDiagonal*sqrt(1.0/(pow(ipadFormat, 2.0)+1.0))
            
            backgroundLightSizeWidth = (screenSizeWidth/ipadSizeWidth)*0.95*5.9*1.32989690721649
            backgroundLightSizeHeight = (screenSizeWidth/ipadSizeWidth)*0.97*4.03*1.32989690721649
        }
        
        lightPatternCollectionView.dataSource = self
        
        brightness.value = Float(appDelegate.brigtness)
        red.value = Float(appDelegate.red)
        green.value = Float(appDelegate.green)
        blue.value = Float(appDelegate.blue)
        
        //backgroundLight.frame = CGRectMake(20 , 20, backgroundLightSizeWidth, backgroundLightSizeHeight)
        heightConstraint.constant = backgroundLightSizeHeight;
        widthConstraint.constant = backgroundLightSizeWidth;
        NSLog("ScrenSizeWidth: %f",ipadSizeWidth)
        NSLog("ScrenSizeHeight: %f",ipadSizeHeight)
        
        NSLog("LightBackground x: %f y: %f %f", ((backgroundLight.frame.origin.x+backgroundLightSizeWidth))*(ipadSizeWidth/screenSizeWidth), (backgroundLight.frame.origin.y+backgroundLightSizeHeight)*(ipadSizeWidth/screenSizeWidth))
        
        NSLog("LightBackground x: %f y: %f %f", ((backgroundLightSizeWidth))*(ipadSizeWidth/screenSizeWidth), (backgroundLightSizeHeight)*(ipadSizeWidth/screenSizeWidth))
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        
        var A:Chard = Chard()
        
        //drawRectangle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*@IBAction func brightnessChanged(sender: UISlider) {
        NSLog("Brightness Value Changed: %f", sender.value)
        appDelegate.brigtness = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
        //backgroundLight
    }*/

    @IBAction func redChanged(sender: UISlider) {
        NSLog("Red Value Changed: %f", sender.value)
        appDelegate.red = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func greenChanged(sender: UISlider) {
        NSLog("Green Value Changed: %f", sender.value)
        appDelegate.green = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func blueChanged(sender: UISlider) {
        NSLog("Blue Value Changed: %f", sender.value)
        appDelegate.blue = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func brightnessChanged(sender: UISlider) {
        NSLog("Brightness Value Changed: %f", sender.value)
        appDelegate.brigtness = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
        //backgroundLight
    }
    
    @IBAction func playButtonPressed(sender: UIButton) {
        NSLog("Pressed")
        play = !play
        if(play){
            playButton .setTitle("\u{f04c}", forState: UIControlState.Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        }else{
            playButton .setTitle("\u{f04b}", forState: UIControlState.Normal)
            timer.invalidate()
            speedLabel.alpha = 1.0
        }
    }
    
    @IBAction func progressSliderChanged(sender: UISlider) {
        NSLog("Sender changed: %f", sender.value)
        appDelegate.counter = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    //@IBAction func stepperPressed(sender: UIStepper) {
    //    NSLog("Stepper pressed")
    //}
    
    @IBAction func stepperPressed(sender: UIStepper) {
        NSLog("Stepper pressed %f", sender.value)
        speed = 1 * pow(2.0, CGFloat(sender.value))
        let s = (NSString(format: "%.2f", speed) as String)+" x"
        speedLabel.text = s as String
    }
    
    //@IBAction func stepperPressed(sender: UIStepper) {
    //}
    func updateCounter() {
        if(appDelegate.backwardLoop || appDelegate.notification){
            if(appDelegate.notification){
                if(appDelegate.counter<1.0 && appDelegate.counterUp){
                    appDelegate.counter += 0.05*speed
                    speedLabel.alpha = 1
                }else if(appDelegate.counter>0.0 && !appDelegate.counterUp){
                    appDelegate.counter -= 0.05*speed
                    speedLabel.alpha = 0
                }else{
                    appDelegate.counterUp = !appDelegate.counterUp;
                }
            }else{
                if(appDelegate.counter<1.0 && appDelegate.counterUp){
                    appDelegate.counter += 0.001*speed
                }else if(appDelegate.counter>0.0 && !appDelegate.counterUp){
                    appDelegate.counter -= 0.001*speed
                }else{
                    appDelegate.counterUp = !appDelegate.counterUp;
                }
            }
        }else{
            if(appDelegate.counter<1.0){
                appDelegate.counter += 0.001*speed
            }else{
                appDelegate.counter = 0.0
            }
        }
        
        if(appDelegate.notification){
            timeProgress.value = Float(0)
        }else if(appDelegate.smooth){
            timeProgress.value = Float(appDelegate.counter)
        }else{
            timeProgress.value = Float(appDelegate.counter)//Float(roundToPlaces(appDelegate.counter, places:1))
        }
        //NSLog("Counter: %f", appDelegate.counter)
        backgroundLight.setNeedsDisplay()
        

    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! LightPatternCollectioViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.myLabel.text = self.items[indexPath.item]
        cell.myImage.image = self.logoImage[indexPath.item]
        //cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        lightPatternLabel.text = self.items[indexPath.item]
        lightPatternImage.image = self.logoImage[indexPath.item]
        
        if(indexPath.item==11){
            lightPatternOptionView.hidden = true
            textOptionView.hidden = false
        }else if(indexPath.item==12){
            textOptionView.hidden = true
            lightPatternOptionView.hidden = false
        }else{
            lightPatternOptionView.hidden = true
            textOptionView.hidden = true
        }
        
        appDelegate.mode = indexPath.item
        
        appDelegate.counter = 0.0
        timeProgress.value = Float(appDelegate.counter)
        backgroundLight.setNeedsDisplay()


    }

    @IBAction func backwordSwitchChanged(sender: UISwitch) {
        if(sender.on){
            appDelegate.backwardLoop = true
        }else{
            appDelegate.backwardLoop = false
        }
        
    }

    @IBAction func smoothSwitchChanged(sender: UISwitch) {
        if(sender.on){
            appDelegate.smooth = true
        }else{
            appDelegate.smooth = false
        }
    }
    
    @IBAction func notificationSwitchChanged(sender: UISwitch) {
        if(sender.on){
            appDelegate.notification = true
            smooth.alpha = 0.5
            smoothLabel.alpha = 0.5
            backwardLoop.alpha = 0.5
            backwardsLabel.alpha = 0.5
            timeProgress.alpha = 0.5
        }else{
            appDelegate.notification = false
            smooth.alpha = 1.0
            smoothLabel.alpha = 1.0
            backwardLoop.alpha = 1.0
            backwardsLabel.alpha = 1.0
            timeProgress.alpha = 1.0
            speedLabel.alpha = 1.0
        }
    }
    
    @IBAction func textLabelEditEnd(sender: UITextField) {
        //print("action")
        appDelegate.text = (sender.text?.uppercaseString)!
    }
    
    @IBAction func endOnExit(sender: UITextField) {
        print("actionTest")
    }
    

    @IBAction func recordButton(sender: UIButton) {
        
        appDelegate.record = !appDelegate.record
        if(appDelegate.record){
            recordButtonOut.setTitle("Stop Recording", forState: UIControlState.Normal)
            appDelegate.recordCounter = 0.0
            recTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("updateRecCounter"), userInfo: nil, repeats: true)
        }else{
            recordButtonOut .setTitle("Record New LightPattern", forState: UIControlState.Normal)
            recordButtonOut.alpha = 0.75
            recTimer.invalidate()
        }
        
    }
    
    func updateRecCounter() {
        appDelegate.recordCounter += 0.05
        if(Int(appDelegate.recordCounter)%2==0){
          recordButtonOut.alpha = 0.25
        }else{
          recordButtonOut.alpha = 0.75
        }
        print(appDelegate.recordCounter)
    }
    
    func roundToPlaces(value:CGFloat, places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return CGFloat(round(Double(value) * divisor) / divisor)
    }
}



