//
//  ViewController.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 15.04.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import UIKit
import Photos
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["None", "Fade Brightness", "Fade Red", "Fade Green", "Fade Blue", "Ellipse", "Rectangle", "Horizontal Line", "Vertical Line", "Horizontal Box", "Vertical Box", "Text", "LightPattern", "Image", "Processing"]

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
        UIImage(named: "text_pattern.jpg")!,
        UIImage(named: "light_pattern.jpg")!,
        UIImage(named: "image_pattern.jpg")!,
        UIImage(named: "wlan.jpg")!



    ]

    @IBOutlet var smooth: UISwitch!
    @IBOutlet var notification: UISwitch!
    @IBOutlet var smoothLabel: UILabel!
    @IBOutlet var backwardsLabel: UILabel!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    
    
    @IBOutlet var backgroundLight: RedLightPattern!
    @IBOutlet var previewLight: PreviewLight!
    
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
    let lightPatternCollectionViewIdentifier = "lightPatternCell"

    @IBOutlet var lightPatternLabel: UILabel!
    
    @IBOutlet var lightPatternImage: UIImageView!
    
    @IBOutlet var textOptionView: UIView!
    @IBOutlet var lightPatternOptionView: UIView!
    @IBOutlet var textLabel: UITextField!
    
    @IBOutlet var recordButtonOut: UIButton!
    @IBOutlet var textPosLabel: UILabel!
    
    @IBOutlet var duplicateButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var imageCollectionView: UICollectionView!
    let imageCollectionViewIdentifier = "imageCell"
    var images = [UIImage]()
    var photo = UIImage()
    
    @IBOutlet var drawCollection: UICollectionView!
    @IBOutlet var drawView: UIView!
    let drawCollectionViewIdentifier = "drawCell"
    
    @IBOutlet var colorPicker: SwiftHSVColorPicker!
    
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
    var drawTimer = NSTimer()

    
    var speed: CGFloat = 1.0
    
    var maxTextPos:Int = 7
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
            let server:UDPServer=UDPServer(addr:"",port:53282)
            let run:Bool=true
            while run{
                var (data,remoteip,remoteport)=server.recv(2048)
                print("recive")
                if let d=data{
                    if let str=String(bytes: d, encoding: NSUTF8StringEncoding){
                        
                        let separators = NSCharacterSet(charactersInString: "#")
                        let fullName : String = str
                        self.appDelegate.processing = fullName.componentsSeparatedByCharactersInSet(separators)
                        print(self.appDelegate.processing[1])
                    }
                }
                print(remoteip)
                //server.close()
                //break
            }
        })        
        
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
            backgroundLightSizeHeight = (screenSizeWidth/ipadSizeWidth)*0.98*4.03*1.32989690721649
            
            backgroundLightSizeWidth = round(backgroundLightSizeWidth/17)*17
            backgroundLightSizeHeight = round(backgroundLightSizeHeight/12)*12
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
        
        //timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)

        playButton.setTitle("\u{f04b}", forState: UIControlState.Normal)
        playButton.setTitleColor(UIColor.init(white: 1, alpha: 0.25), forState: UIControlState.Normal)
        timeProgress.thumbTintColor = UIColor.grayColor()
        timeProgress.userInteractionEnabled = false
        smooth.alpha = 0.5
        smoothLabel.alpha = 0.5
        backwardLoop.alpha = 0.5
        backwardsLabel.alpha = 0.5
        notification.alpha = 0.5
        notificationLabel.alpha = 0.5
        timeProgress.alpha = 0.5
        stepper.alpha = 0.5
        speedLabel.alpha = 0.5
        speedLabel.alpha = 1.0
        appDelegate.play = false
        
        
        var A:Chard = Chard()
        
        
        lightPatternCollectionView.delegate = self
        imageCollectionView.delegate = self
        lightPatternCollectionView.dataSource = self
        imageCollectionView.dataSource = self
        drawCollection.delegate = self
        drawCollection.dataSource = self
        self.view.addSubview(lightPatternCollectionView)
        self.view.addSubview(imageCollectionView)
        self.view.addSubview(drawCollection)
        
        FetchCustomAlbumPhotos()
        

        //appDelegate.img_draw.append(UIImage())
        //appDelegate.img_draw.append(UIImage())
        
        
        
        appDelegate.imgSeq.append(ImageSequence())
        //appDelegate.imgSeq[appDelegate.imgSeqCtr].img_draw.append(UIImage())
        //appDelegate.imgSeq[appDelegate.imgSeqCtr].img_draw.append(UIImage())
        
        print("ImageSequenceSize:")
        print(appDelegate.imgSeq.count)
        print(appDelegate.imgSeq[appDelegate.imgSeqCtr].img_draw.count)


        loadImageSequenceFromCoreData()

        
        //drawRectangle()

        appDelegate.selectedColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        colorPicker.setViewColor(appDelegate.selectedColor)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reloadCollection), name: "reloadCollection", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateImageSequencePersistent), name: UIApplicationDidEnterBackgroundNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateImageSequencePersistent), name: UIApplicationWillTerminateNotification, object: nil)

        var client:TCPClient = TCPClient(addr: "www.apple.com", port: 80)
        
        self.textLabel.delegate = self
        
    }
    
    func reloadCollection(){
        print("Reload collection")
        drawCollection.reloadData()
        previewLight.setNeedsDisplay()

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
        if(appDelegate.mode != 0){
            appDelegate.play = !appDelegate.play
            if(appDelegate.play){
                playButton .setTitle("\u{f04c}", forState: UIControlState.Normal)
                timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
            }else{
                playButton .setTitle("\u{f04b}", forState: UIControlState.Normal)
                timer.invalidate()
                speedLabel.alpha = 1.0
            }
        }
    }
    
    @IBAction func progressSliderChanged(sender: UISlider) {
        NSLog("Sender changed: %f", sender.value)
        appDelegate.counter = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func touchDown(sender: AnyObject) {
        print("touchDown")
        appDelegate.sliderChanged = true
    }
    
    @IBAction func touchUpInside(sender: AnyObject) {
        print("touchUpInside")
        appDelegate.sliderChanged = false
    }
    
    @IBAction func touchUpOutside(sender: AnyObject) {
        print("touchUpOutside")
        appDelegate.sliderChanged = false
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
                if((appDelegate.counter+0.001*speed)<=1.0 && appDelegate.counterUp){
                    appDelegate.counter += 0.001*speed
                }else if((appDelegate.counter-0.001*speed)>=0.0 && !appDelegate.counterUp){
                    appDelegate.counter -= 0.001*speed
                }else{
                    if(appDelegate.counterUp){
                        appDelegate.counter = 1-0.001*speed
                    }else{
                        appDelegate.counter = 0.001*speed
                    }
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
        
        if collectionView == self.lightPatternCollectionView {
            return self.items.count
        } else if collectionView == self.imageCollectionView {
            //print(images.count)
            return images.count
        } else {
            print("numberOfItems")
            print(appDelegate.imgSeq[appDelegate.seq].drawFrames)
            return (appDelegate.imgSeq[appDelegate.seq].drawFrames) + 1
        }
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == self.lightPatternCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(lightPatternCollectionViewIdentifier, forIndexPath: indexPath) as! LightPatternCollectionViewCell
        
            cell.myLabel.text = self.items[indexPath.item]
            cell.myImage.image = self.logoImage[indexPath.item]
        
            return cell
        } else if collectionView == self.imageCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(imageCollectionViewIdentifier, forIndexPath: indexPath) as! ImageCollectionViewCell
            
            //if let image = cell.viewWithTag(1000) as? UIImageView {
                //print("add image")
                print(indexPath.item)
                cell.image.image = images[indexPath.item]
            //}
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(drawCollectionViewIdentifier, forIndexPath: indexPath) as! DrawCollectionViewCell
            
            if(indexPath.item<appDelegate.imgSeq[appDelegate.seq].drawFrames){
            
            print("CellForItemAtIndexPath")
            print(appDelegate.seq)
            print(indexPath.item)
            cell.image.image = appDelegate.imgSeq[appDelegate.seq].img_draw[indexPath.item]
            cell.backgroundColor = UIColor.clearColor()
            cell.contentView.layer.borderColor = UIColor.whiteColor().CGColor
            cell.contentView.layer.borderWidth = 1
            //print("IndexPath: "+String(indexPath.item)+" DrawFrames: "+String(appDelegate.drawFrames))
            }else if(indexPath.item==appDelegate.imgSeq[appDelegate.seq].drawFrames){
                cell.image.image = UIImage(named: "add.png")!
                cell.backgroundColor = UIColor.grayColor()
            }
            //}//else if(indexPath.item == indexPath.)
            //}
            return cell
        }
            
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        //print("You selected cell #\(indexPath.item)!")
        
        if collectionView == self.lightPatternCollectionView {
        lightPatternLabel.text = self.items[indexPath.item]
        lightPatternImage.image = self.logoImage[indexPath.item]
        
        if(indexPath.item==11){
            lightPatternOptionView.hidden = true
            textOptionView.hidden = false
            imageCollectionView.hidden = true
            drawCollection.hidden = true
            drawView.hidden = true
            deleteButton.hidden = true
            duplicateButton.hidden = true
            saveButton.hidden = true
        }else if(indexPath.item==12 || indexPath.item > 14){
            textOptionView.hidden = true
            lightPatternOptionView.hidden = false
            imageCollectionView.hidden = true
            drawCollection.hidden = false
            drawView.hidden = false
            deleteButton.hidden = false
            duplicateButton.hidden = false
            saveButton.hidden = false
        }else if(indexPath.item==13){
            textOptionView.hidden = true
            lightPatternOptionView.hidden = true
            imageCollectionView.hidden = false
            drawCollection.hidden = true
            drawView.hidden = true
            deleteButton.hidden = true
            duplicateButton.hidden = true
            saveButton.hidden = true
            FetchCustomAlbumPhotos()
        }else{
            drawCollection.hidden = true
            lightPatternOptionView.hidden = true
            textOptionView.hidden = true
            imageCollectionView.hidden = true
            drawView.hidden = true
            deleteButton.hidden = true
            duplicateButton.hidden = true
            saveButton.hidden = true
        }
        
        if(indexPath.item==0 || indexPath.item==14){
            playButton.setTitle("\u{f04b}", forState: UIControlState.Normal)
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 0.25), forState: UIControlState.Normal)
            timeProgress.thumbTintColor = UIColor.grayColor()
            timeProgress.userInteractionEnabled = false
            smooth.alpha = 0.5
            smoothLabel.alpha = 0.5
            backwardLoop.alpha = 0.5
            backwardsLabel.alpha = 0.5
            notification.alpha = 0.5
            notificationLabel.alpha = 0.5
            timeProgress.alpha = 0.5
            stepper.alpha = 0.5
            speedLabel.alpha = 0.5
            timer.invalidate()
            speedLabel.alpha = 1.0
            appDelegate.play = false
            
        }else if(indexPath.item==12){
            appDelegate.seq = 0
            appDelegate.play = true
            timer.invalidate()
            timeProgress.userInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.whiteColor()
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), forState: UIControlState.Normal)
            playButton .setTitle("\u{f04b}", forState: UIControlState.Normal)
            timer.invalidate()
            drawTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: #selector(ViewController.drawTimerUpdate), userInfo: nil, repeats: true)
            speedLabel.alpha = 1.0
            appDelegate.play = false
            drawCollection.reloadData()
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
        }else if(indexPath.item>14){
            appDelegate.seq = indexPath.item - 14
            appDelegate.play = true
            timer.invalidate()
            timeProgress.userInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.whiteColor()
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), forState: UIControlState.Normal)
            playButton .setTitle("\u{f04b}", forState: UIControlState.Normal)
            timer.invalidate()
            drawTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: #selector(ViewController.drawTimerUpdate), userInfo: nil, repeats: true)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            speedLabel.alpha = 1.0
            appDelegate.play = false
            drawCollection.reloadData()
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
        }else{
            appDelegate.play = true
            timer.invalidate()
            timeProgress.userInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.whiteColor()
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), forState: UIControlState.Normal)
            playButton .setTitle("\u{f04c}", forState: UIControlState.Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        }
            
        if(indexPath.item > 14){
            appDelegate.play = true
            timer.invalidate()
            timeProgress.userInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.whiteColor()
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), forState: UIControlState.Normal)
            playButton .setTitle("\u{f04c}", forState: UIControlState.Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        }
        
        appDelegate.mode = indexPath.item
        
        appDelegate.counter = 0.0
        timeProgress.value = Float(appDelegate.counter)
        backgroundLight.setNeedsDisplay()
        } else if collectionView == self.imageCollectionView {
            
        appDelegate.activeImage = images[indexPath.item]
            
        //appDelegate.imgSeq[appDelegate.imgSeqCtr].activeImage = images[indexPath.item]
            
        backgroundLight.setNeedsDisplay()
            
        } else {
            //print("selected: "+String(indexPath.item))
            if(indexPath.item==appDelegate.imgSeq[appDelegate.seq].drawFrames){
                //print("last: "+String(appDelegate.drawFrames))
                

                appDelegate.play = false;
                timer.invalidate()
                playButton .setTitle("\u{f04b}", forState: UIControlState.Normal)
                
                //appDelegate.img_draw.append(UIImage())
                //appDelegate.drawFrames++
                //appDelegate.currentFrame = appDelegate.drawFrames-1
                
                appDelegate.imgSeq[appDelegate.seq].img_draw.append(UIImage())
                appDelegate.imgSeq[appDelegate.seq].drawFrames++
                appDelegate.imgSeq[appDelegate.seq].currentFrame = (appDelegate.imgSeq[appDelegate.seq].drawFrames)-1
                
                backgroundLight.setNeedsDisplay()
                previewLight.setNeedsDisplay()
                drawCollection.reloadData()
                //self.drawCollection.scrollToItemAtIndexPath(NSIndexPath(forItem: appDelegate.drawFrames, inSection: 0), atScrollPosition: .Right, animated: true)
                
                self.drawCollection.scrollToItemAtIndexPath(NSIndexPath(forItem: (appDelegate.imgSeq[appDelegate.seq].drawFrames), inSection: 0), atScrollPosition: .Right, animated: true)
                

            }else{
                appDelegate.imgSeq[appDelegate.seq].currentFrame = indexPath.item
                backgroundLight.setNeedsDisplay()
                previewLight.setNeedsDisplay()
            }
        }

    }
    
    func drawTimerUpdate(){
        
        backgroundLight.setNeedsDisplay()
        previewLight.setNeedsDisplay()
        appDelegate.selectedColor = colorPicker.color
        
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
        print("action")
        appDelegate.text = (sender.text?.uppercaseString)!
        backgroundLight.setNeedsDisplay()
    }

    @IBAction func textEditingChanged(sender: AnyObject) {
        appDelegate.text = (sender.text?.uppercaseString)!
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func endOnExit(sender: UITextField) {
        print("actionTest")
    }
    

    @IBAction func recordButton(sender: UIButton) {
        
        appDelegate.record = !appDelegate.record
        if(appDelegate.record){
            recordButtonOut.setTitle("Stop Recording", forState: UIControlState.Normal)
            recTimer = NSTimer.scheduledTimerWithTimeInterval(0.05, target:self, selector: Selector("updateRecCounter"), userInfo: nil, repeats: true)
        }else{
            recordButtonOut .setTitle("Record New LightPattern", forState: UIControlState.Normal)
            recordButtonOut.alpha = 0.75
            recTimer.invalidate()
            appDelegate.recordCounter = 0.0

        }
        
    }
    
    @IBAction func textPosSliderChanged(sender: UISlider) {
        textPosLabel.text = "Row "+String((Int)(sender.value*Float(maxTextPos)))
        appDelegate.row = (Int)(sender.value*Float(maxTextPos))
        backgroundLight.setNeedsDisplay()
    }
    
    func updateRecCounter() {
        appDelegate.recordCounter += 0.05
        if(Int(appDelegate.recordCounter)%2==0){
          recordButtonOut.alpha = 0.25
        }else{
          recordButtonOut.alpha = 0.75
        }
        //print(appDelegate.recordCounter)
        
    }
    
    func roundToPlaces(value:CGFloat, places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return CGFloat(round(Double(value) * divisor) / divisor)
    }
    
    
    func FetchCustomAlbumPhotos()
    {
        var albumName = "Camera Roll"
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult()
        
        let fetchOptions = PHFetchOptions()
        //fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)
        
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = collection.firstObject as! PHAssetCollection
            albumFound = true
        }
        else { albumFound = false }
        var i = collection.count
        print(i)
        photoAssets = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
        let imageManager = PHCachingImageManager()
        
        //        let imageManager = PHImageManager.defaultManager()
        
        images.removeAll()
        
        photoAssets.enumerateObjectsUsingBlock{(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                    height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .FastFormat
                options.synchronous = true
                
                imageManager.requestImageForAsset(asset,
                    targetSize: imageSize,
                    contentMode: .AspectFill,
                    options: options,
                    resultHandler: {
                        (image, info) -> Void in
                        self.photo = image!
                        /* The image is now available to us */
                        self.addImgToArray(self.photo)
                        print("enum for image, This is number 2")
                        
                })
                
            }
        }
        imageCollectionView.reloadData()
    }
    
    func addImgToArray(uploadImage:UIImage)
    {
        self.images.append(uploadImage)
        
        print("add")
        print(images.count)
    }
    
    @IBAction func deleteImage(sender: AnyObject) {
        print("duplicate")
        if(appDelegate.imgSeq[appDelegate.seq].drawFrames>1){
            appDelegate.imgSeq[appDelegate.seq].img_draw.removeAtIndex((appDelegate.imgSeq[appDelegate.seq].currentFrame))
            appDelegate.imgSeq[appDelegate.seq].drawFrames--
            appDelegate.imgSeq[appDelegate.seq].currentFrame = (appDelegate.imgSeq[appDelegate.seq].drawFrames)-1
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
            drawCollection.reloadData()
        }else if(appDelegate.imgSeq[appDelegate.seq].drawFrames==1){
            appDelegate.imgSeq[appDelegate.seq].img_draw.append(UIImage())
            appDelegate.imgSeq[appDelegate.seq].img_draw.removeAtIndex((appDelegate.imgSeq[appDelegate.seq].currentFrame))
            appDelegate.imgSeq[appDelegate.seq].currentFrame = (appDelegate.imgSeq[appDelegate.seq].drawFrames)-1
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
            drawCollection.reloadData()
        }
    }
    
    @IBAction func duplicateImage(sender: AnyObject) {
        print("delete")
        appDelegate.imgSeq[appDelegate.seq].img_draw.insert((appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)]), atIndex: (appDelegate.imgSeq[appDelegate.seq].currentFrame))
        appDelegate.imgSeq[appDelegate.seq].drawFrames++
        backgroundLight.setNeedsDisplay()
        previewLight.setNeedsDisplay()
        drawCollection.reloadData()
    }
    
    // change background color when user touches cell
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        if(collectionView == self.drawCollection){
            var index = collectionView.indexPathsForVisibleItems()
            print("Test")
            print(index)
            
            
            var indexes = [NSIndexPath]()
            // assuming that tableView is your self.tableView defined somewhere
            for i in 0...drawCollection.numberOfSections() - 1
            {
                for j in 0...drawCollection.numberOfItemsInSection(i)-1
                {
                    
                    let index = NSIndexPath(forRow: j, inSection: i)
                    indexes.append(index)
                    
                }
            }
            
            
            for i in 0 ..< index.count - 1 {
                print("Count")
                print(index[i])
                let cell = collectionView.cellForItemAtIndexPath(index[i]) as! DrawCollectionViewCell
                cell.contentView.layer.borderColor = UIColor.whiteColor().CGColor
                cell.contentView.layer.borderWidth = 1
            }
            
            
            if(indexPath.item != appDelegate.imgSeq[appDelegate.imgSeqCtr].drawFrames){
                let cell = collectionView.cellForItemAtIndexPath(indexPath) as! DrawCollectionViewCell
                cell.contentView.layer.borderColor = UIColor.whiteColor().CGColor
                cell.contentView.layer.borderWidth = 3            }
        }
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    @IBAction func save(sender: AnyObject) {
        print("save")

        UIGraphicsBeginImageContextWithOptions(CGSize(width:400, height: 280), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        var img_bg = UIImage(named: "brightness_pattern.jpg")
        CGContextDrawImage(context, CGRect(x:0, y:0, width:400, height:280), imageWithImage(img_bg!, scaledToSize: CGSize(width: 400, height: 280)).CGImage)
        
        CGContextSetAlpha(context, 0.7)
        
        // then flip Y axis
        CGContextTranslateCTM(context, 0, 280);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        CGContextDrawImage(context, CGRect(x:0, y:0, width:400, height:280), imageWithImage(appDelegate.imgSeq[appDelegate.seq].img_draw[0], scaledToSize: CGSize(width:400, height:280)).CGImage)
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        logoImage.append(img)
        appDelegate.imgSeq[appDelegate.seq].preview_image = img
        
        var name = "Saved Pattern "+String(appDelegate.imgSeq.count)
        items.append(name)

        saveImageSequencePersistent()
        
        appDelegate.imgSeq.append(ImageSequence())
        appDelegate.imgSeq.last?.img_draw = appDelegate.imgSeq[appDelegate.seq].img_draw
        appDelegate.imgSeq.last?.drawFrames = appDelegate.imgSeq[appDelegate.seq].drawFrames
        
        appDelegate.imgSeqCtr++
        backgroundLight.setNeedsDisplay()
        previewLight.setNeedsDisplay()
        drawCollection.reloadData()
        lightPatternCollectionView.reloadData()
    }
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func saveImageSequencePersistent(){
        
        let entityDescription =
            NSEntityDescription.entityForName("SavedImageSequence",
                                              inManagedObjectContext: appDelegate.managedObjectContext)
        
        let savedImageSequence = SavedImageSequence(entity: entityDescription!,
                               insertIntoManagedObjectContext: appDelegate.managedObjectContext)
        
        //savedImageSequence.activeImage = appDelegate.imgSeq[appDelegate.imgSeqCtr].activeImage
        //savedImageSequence.img_draw = appDelegate.imgSeq[appDelegate.imgSeqCtr].img_draw
        //savedImageSequence.currentFrame = appDelegate.imgSeq[appDelegate.imgSeqCtr].currentFrame
        savedImageSequence.currentFrame = Float(appDelegate.imgSeq[appDelegate.seq].currentFrame)
        savedImageSequence.drawFrames = Float(appDelegate.imgSeq[appDelegate.seq].drawFrames)
        
        var thumbnailImageDatas = NSMutableArray()
        for image in appDelegate.imgSeq[appDelegate.seq].img_draw {
            print(image)
            if(image.CGImage != nil){
            thumbnailImageDatas.addObject(UIImagePNGRepresentation(image)!)
            }
            //[thumbnailImageDatas addObject:UIImagePNGRepresentation(resizedImage)];
        }
        let thumbnailImageData = NSKeyedArchiver.archivedDataWithRootObject(thumbnailImageDatas)//[NSKeyedArchiver archivedDataWithRootObject:thumbnailImageDatas];
        
        print(thumbnailImageData)

        savedImageSequence.img_draw = thumbnailImageData
        
        var previewImageData = UIImagePNGRepresentation(appDelegate.imgSeq[appDelegate.seq].preview_image)
        savedImageSequence.preview_image = previewImageData!
        
        savedImageSequence.name = "Saved Pattern "+String(appDelegate.imgSeq.count)

                
        do {
            try appDelegate.managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
    
    func updateImageSequencePersistent(){
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "SavedImageSequence")
        
        appDelegate.imgSeq.count
        
        for i in 1...appDelegate.imgSeq.count {
            let name = "Saved Pattern "+String(i)
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
            var result: [AnyObject]?
            do {
                result = try managedContext.executeFetchRequest(fetchRequest)
            } catch let nserror1 as NSError{
                result = nil
            }
        
            for resultItem in result! {
                let imageSequence = resultItem as! SavedImageSequence
                
                imageSequence.currentFrame = Float(appDelegate.imgSeq[i].currentFrame)
                imageSequence.drawFrames = Float(appDelegate.imgSeq[i].drawFrames)
                
                var thumbnailImageDatas = NSMutableArray()
                for image in appDelegate.imgSeq[i].img_draw {
                    print(image)
                    if(image.CGImage != nil){
                        thumbnailImageDatas.addObject(UIImagePNGRepresentation(image)!)
                    }
                    //[thumbnailImageDatas addObject:UIImagePNGRepresentation(resizedImage)];
                }
                let thumbnailImageData = NSKeyedArchiver.archivedDataWithRootObject(thumbnailImageDatas)//[NSKeyedArchiver archivedDataWithRootObject:thumbnailImageDatas];
                
                print(thumbnailImageData)
                
                imageSequence.img_draw = thumbnailImageData
                
                var previewImageData = UIImagePNGRepresentation(appDelegate.imgSeq[i].preview_image)
                imageSequence.preview_image = previewImageData!
                
                print(imageSequence.name)
            }
        }
        do {
            try appDelegate.managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    func loadImageSequenceFromCoreData(){
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "SavedImageSequence")
        
        //3
        //var result: [AnyObject]?
        //do {
        //    let results =
        //        try managedContext.executeFetchRequest(fetchRequest)
        //    people = results as! [NSManagedObject]
        //} catch let error as NSError {
        //    print("Could not fetch \(error), \(error.userInfo)")
        //}
        
        var result: [AnyObject]?
        do {
            result = try managedContext.executeFetchRequest(fetchRequest)
        } catch let nserror1 as NSError{
            result = nil
        }
        
        for resultItem in result! {
            let imageSequence = resultItem as! SavedImageSequence
            var image = UIImage(data: imageSequence.preview_image)//[UIImage imageWithData:selectedDance.danceImage];
            logoImage.append(image!)
            var name = "Saved Pattern "+String(appDelegate.imgSeq.count)
            items.append(name)
            appDelegate.imgSeq.append(ImageSequence())
            appDelegate.imgSeqCtr++
            appDelegate.imgSeq.last?.preview_image = image!
            
            var images = Array<UIImage>()
            var imageDatas = NSKeyedUnarchiver.unarchiveObjectWithData(imageSequence.img_draw) as! NSArray // [NSKeyedUnarchiver unarchiveObjectWithData:self.thumbnailImagesData];
            for imageData in imageDatas {
                var img = UIImage(data: imageData as! NSData)!
                
                UIGraphicsBeginImageContextWithOptions(CGSize(width:17, height: 12), false, 1)
                let context = UIGraphicsGetCurrentContext()
                
                CGContextDrawImage(context, CGRect(x:0, y:0, width:17, height:12), imageWithImage(img, scaledToSize: CGSize(width: 17, height: 12)).CGImage)
                let imgCopy = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                images.append(imgCopy)//[images addObject:[UIImage imageWithData:imageData]];
            }
            appDelegate.imgSeq.last?.img_draw = images

            appDelegate.imgSeq.last?.drawFrames = Int(imageSequence.drawFrames)
            appDelegate.imgSeq.last?.currentFrame = Int(imageSequence.currentFrame)
            
            print("imageSeqDrawFrames")
            print(imageSequence.drawFrames)
            print(imageSequence.currentFrame)
            
            //drawCollection.reloadData()
            //print(imageSequence.img_draw)
        }
        
        print("ImageSequenceSize")
        print(appDelegate.imgSeq.count)
        
    }
    
}


