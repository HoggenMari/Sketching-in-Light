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
    
    
    //@IBOutlet var backgroundLight: RedLightPattern!
    var backgroundLight: RedLightPattern!
    //@IBOutlet var previewLight: PreviewLight!
    var previewLight: RedLightPattern!
    
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
    
    @IBOutlet var ip_label: UILabel!
    
    let screenSizeWidth = UIScreen.main.bounds.width
    let screenSizeHeight = UIScreen.main.bounds.height
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var ipadDiagonal:CGFloat = 12.9
    var ipadFormat:CGFloat = 1.333984375
    var backgroundLightSizeWidth: CGFloat = 0.0
    var backgroundLightSizeHeight: CGFloat = 0.0
    var ipadSizeWidth: CGFloat = 0.0
    var ipadSizeHeight: CGFloat = 0.0
    let test = sqrt(1.0/100.0)
    let modelName = UIDevice.current.modelName

    var timer = Timer()
    var recTimer = Timer()
    var drawTimer = Timer()

    
    var speed: CGFloat = 1.0
    
    var maxTextPos:Int = 7
    
    fileprivate var lPCollectionView: LightPatternCollectionViewController?
    
    //let lPCollectionView = LightPatternCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async(execute: { () -> Void in
            let server:UDPServer=UDPServer(addr:"",port:53282)
            let run:Bool=true
            while run{
                var (data,remoteip,remoteport)=server.recv(2048)
                print("recive")
                if let d=data{
                    if let str=String(bytes: d, encoding: String.Encoding.utf8){
                        
                        let separators = CharacterSet(charactersIn: "#")
                        let fullName : String = str
                        self.appDelegate.processing = fullName.components(separatedBy: separators)
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
            
            backgroundLightSizeWidth = round(backgroundLightSizeWidth/34)*34
            backgroundLightSizeHeight = round(backgroundLightSizeHeight/24)*24
            
            backgroundLight = RedLightPattern(frame:CGRect(x: 0, y: 0, width: backgroundLightSizeWidth, height: backgroundLightSizeHeight), pixelWidth: 34, pixelHeight: 24)
            self.view.addSubview(backgroundLight)
            
        }else{
            ipadDiagonal = 12.9
            ipadFormat = 1.3333
            
            ipadSizeHeight = ipadDiagonal*sqrt(1.0/(pow(ipadFormat,2.0)+1))
            ipadSizeWidth = ipadFormat*ipadDiagonal*sqrt(1.0/(pow(ipadFormat, 2.0)+1.0))
            
            backgroundLightSizeWidth = (screenSizeWidth/ipadSizeWidth)*0.95*5.9*1.32989690721649
            backgroundLightSizeHeight = (screenSizeWidth/ipadSizeWidth)*0.98*4.03*1.32989690721649
            
            backgroundLightSizeWidth = round(backgroundLightSizeWidth/34)*34
            backgroundLightSizeHeight = round(backgroundLightSizeHeight/24)*24
            
            backgroundLight = RedLightPattern(frame:CGRect(x: 50, y: 50, width: backgroundLightSizeWidth, height: backgroundLightSizeHeight), pixelWidth: 17, pixelHeight: 12)
            self.view.addSubview(backgroundLight)
            
            previewLight = RedLightPattern(frame:CGRect(x: 450, y: 450, width: 170, height: 120), pixelWidth: 17, pixelHeight: 12)
            self.view.addSubview(previewLight)

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

        playButton.setTitle("\u{f04b}", for: UIControlState())
        playButton.setTitleColor(UIColor.init(white: 1, alpha: 0.25), for: UIControlState())
        timeProgress.thumbTintColor = UIColor.gray
        timeProgress.isUserInteractionEnabled = false
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
        
        
        //var A:Chard = Chard()
        
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reloadCollection), name: NSNotification.Name(rawValue: "reloadCollection"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateImageSequencePersistent), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateImageSequencePersistent), name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
        
        self.textLabel.delegate = self
        
        //self.addChildViewController(lPCollectionView)
        
        //lPCollectionView.view.frame = self.view.frame
        //self.view.addSubview(lPCollectionView.view)
        
        //lPCollectionView.didMove(toParentViewController: self)
        
        //lPCollectionView.view.frame = self.view.bounds
        //lPCollectionView.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let controller = destination as? LightPatternCollectionViewController {
            lPCollectionView = controller
            controller.delegate = self // as? LightPatternSelectionDelegate
        }
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

    @IBAction func redChanged(_ sender: UISlider) {
        NSLog("Red Value Changed: %f", sender.value)
        appDelegate.red = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func greenChanged(_ sender: UISlider) {
        NSLog("Green Value Changed: %f", sender.value)
        appDelegate.green = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func blueChanged(_ sender: UISlider) {
        NSLog("Blue Value Changed: %f", sender.value)
        appDelegate.blue = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func brightnessChanged(_ sender: UISlider) {
        NSLog("Brightness Value Changed: %f", sender.value)
        appDelegate.brigtness = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
        //backgroundLight
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        NSLog("Pressed")
        if(appDelegate.mode != 0){
            appDelegate.play = !appDelegate.play
            if(appDelegate.play){
                playButton .setTitle("\u{f04c}", for: UIControlState())
                timer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            }else{
                playButton .setTitle("\u{f04b}", for: UIControlState())
                timer.invalidate()
                speedLabel.alpha = 1.0
            }
        }
    }
    
    @IBAction func progressSliderChanged(_ sender: UISlider) {
        NSLog("Sender changed: %f", sender.value)
        appDelegate.counter = CGFloat(sender.value)
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func touchDown(_ sender: AnyObject) {
        print("touchDown")
        appDelegate.sliderChanged = true
    }
    
    @IBAction func touchUpInside(_ sender: AnyObject) {
        print("touchUpInside")
        appDelegate.sliderChanged = false
    }
    
    @IBAction func touchUpOutside(_ sender: AnyObject) {
        print("touchUpOutside")
        appDelegate.sliderChanged = false
    }
    
    //@IBAction func stepperPressed(sender: UIStepper) {
    //    NSLog("Stepper pressed")
    //}
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.lightPatternCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lightPatternCollectionViewIdentifier, for: indexPath) as! LightPatternCollectionViewCell
        
            cell.myLabel.text = self.items[indexPath.item]
            cell.myImage.image = self.logoImage[indexPath.item]
        
            return cell
        } else if collectionView == self.imageCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCollectionViewIdentifier, for: indexPath) as! ImageCollectionViewCell
            
            //if let image = cell.viewWithTag(1000) as? UIImageView {
                //print("add image")
                print(indexPath.item)
                cell.image.image = images[indexPath.item]
            //}
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: drawCollectionViewIdentifier, for: indexPath) as! DrawCollectionViewCell
            
            if(indexPath.item<appDelegate.imgSeq[appDelegate.seq].drawFrames){
            
            print("CellForItemAtIndexPath")
            print(appDelegate.seq)
            print(indexPath.item)
            cell.image.image = appDelegate.imgSeq[appDelegate.seq].img_draw[indexPath.item]
            cell.backgroundColor = UIColor.clear
            cell.contentView.layer.borderColor = UIColor.white.cgColor
            cell.contentView.layer.borderWidth = 1
            //print("IndexPath: "+String(indexPath.item)+" DrawFrames: "+String(appDelegate.drawFrames))
            }else if(indexPath.item==appDelegate.imgSeq[appDelegate.seq].drawFrames){
                cell.image.image = UIImage(named: "add.png")!
                cell.backgroundColor = UIColor.gray
            }
            //}//else if(indexPath.item == indexPath.)
            //}
            return cell
        }
            
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        //print("You selected cell #\(indexPath.item)!")
        
        if collectionView == self.lightPatternCollectionView {
        lightPatternLabel.text = self.items[indexPath.item]
        lightPatternImage.image = self.logoImage[indexPath.item]
        
        if(indexPath.item==11){
            lightPatternOptionView.isHidden = true
            textOptionView.isHidden = false
            imageCollectionView.isHidden = true
            drawCollection.isHidden = true
            drawView.isHidden = true
            deleteButton.isHidden = true
            duplicateButton.isHidden = true
            saveButton.isHidden = true
        }else if(indexPath.item==12 || indexPath.item > 14){
            textOptionView.isHidden = true
            lightPatternOptionView.isHidden = false
            imageCollectionView.isHidden = true
            drawCollection.isHidden = false
            drawView.isHidden = false
            deleteButton.isHidden = false
            duplicateButton.isHidden = false
            saveButton.isHidden = false
        }else if(indexPath.item==13){
            textOptionView.isHidden = true
            lightPatternOptionView.isHidden = true
            imageCollectionView.isHidden = false
            drawCollection.isHidden = true
            drawView.isHidden = true
            deleteButton.isHidden = true
            duplicateButton.isHidden = true
            saveButton.isHidden = true
            FetchCustomAlbumPhotos()
        }else{
            drawCollection.isHidden = true
            lightPatternOptionView.isHidden = true
            textOptionView.isHidden = true
            imageCollectionView.isHidden = true
            drawView.isHidden = true
            deleteButton.isHidden = true
            duplicateButton.isHidden = true
            saveButton.isHidden = true
        }
        
        if(indexPath.item==0 || indexPath.item==14){
            playButton.setTitle("\u{f04b}", for: UIControlState())
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 0.25), for: UIControlState())
            timeProgress.thumbTintColor = UIColor.gray
            timeProgress.isUserInteractionEnabled = false
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
            if(indexPath.item==14){
                ip_label.text = "IP: Blaa"
            }
            
        }else if(indexPath.item==12){
            appDelegate.seq = 0
            appDelegate.play = true
            timer.invalidate()
            timeProgress.isUserInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.white
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), for: UIControlState())
            playButton .setTitle("\u{f04b}", for: UIControlState())
            timer.invalidate()
            drawTimer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.drawTimerUpdate), userInfo: nil, repeats: true)
            speedLabel.alpha = 1.0
            appDelegate.play = false
            drawCollection.reloadData()
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
        }else if(indexPath.item>14){
            appDelegate.seq = indexPath.item - 14
            appDelegate.play = true
            timer.invalidate()
            timeProgress.isUserInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.white
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), for: UIControlState())
            playButton .setTitle("\u{f04b}", for: UIControlState())
            timer.invalidate()
            drawTimer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.drawTimerUpdate), userInfo: nil, repeats: true)
            timer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            speedLabel.alpha = 1.0
            appDelegate.play = false
            drawCollection.reloadData()
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
        }else{
            appDelegate.play = true
            timer.invalidate()
            timeProgress.isUserInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.white
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), for: UIControlState())
            playButton .setTitle("\u{f04c}", for: UIControlState())
            timer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
        }
            
        if(indexPath.item > 14){
            appDelegate.play = true
            timer.invalidate()
            timeProgress.isUserInteractionEnabled = true
            if(appDelegate.notification == false){
                smooth.alpha = 1.0
                smoothLabel.alpha = 1.0
                backwardLoop.alpha = 1.0
                backwardsLabel.alpha = 1.0
                timeProgress.thumbTintColor = UIColor.white
            }
            timeProgress.alpha = 1.0
            stepper.alpha = 1.0
            speedLabel.alpha = 1.0
            notification.alpha = 1.0
            notificationLabel.alpha = 1.0
            playButton.setTitleColor(UIColor.init(white: 1, alpha: 1), for: UIControlState())
            playButton .setTitle("\u{f04c}", for: UIControlState())
            timer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
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
                playButton .setTitle("\u{f04b}", for: UIControlState())
                
                //appDelegate.img_draw.append(UIImage())
                //appDelegate.drawFrames++
                //appDelegate.currentFrame = appDelegate.drawFrames-1
                
                appDelegate.imgSeq[appDelegate.seq].img_draw.append(UIImage())
                appDelegate.imgSeq[appDelegate.seq].drawFrames += 1
                appDelegate.imgSeq[appDelegate.seq].currentFrame = (appDelegate.imgSeq[appDelegate.seq].drawFrames)-1
                
                backgroundLight.setNeedsDisplay()
                previewLight.setNeedsDisplay()
                drawCollection.reloadData()
                //self.drawCollection.scrollToItemAtIndexPath(NSIndexPath(forItem: appDelegate.drawFrames, inSection: 0), atScrollPosition: .Right, animated: true)
                
                self.drawCollection.scrollToItem(at: IndexPath(item: (appDelegate.imgSeq[appDelegate.seq].drawFrames), section: 0), at: .right, animated: true)
                

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

    @IBAction func backwordSwitchChanged(_ sender: UISwitch) {
        if(sender.isOn){
            appDelegate.backwardLoop = true
        }else{
            appDelegate.backwardLoop = false
        }
        
    }

    @IBAction func smoothSwitchChanged(_ sender: UISwitch) {
        if(sender.isOn){
            appDelegate.smooth = true
        }else{
            appDelegate.smooth = false
        }
    }
    
    @IBAction func notificationSwitchChanged(_ sender: UISwitch) {
        if(sender.isOn){
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
    
    @IBAction func textLabelEditEnd(_ sender: UITextField) {
        print("action")
        appDelegate.text = (sender.text?.uppercased())!
        backgroundLight.setNeedsDisplay()
    }

    @IBAction func textEditingChanged(_ sender: AnyObject) {
        appDelegate.text = (sender.text?.uppercased())!
        backgroundLight.setNeedsDisplay()
    }
    
    @IBAction func endOnExit(_ sender: UITextField) {
        print("actionTest")
    }
    

    @IBAction func recordButton(_ sender: UIButton) {
        
        appDelegate.record = !appDelegate.record
        if(appDelegate.record){
            recordButtonOut.setTitle("Stop Recording", for: UIControlState())
            recTimer = Timer.scheduledTimer(timeInterval: 0.05, target:self, selector: #selector(ViewController.updateRecCounter), userInfo: nil, repeats: true)
        }else{
            recordButtonOut .setTitle("Record New LightPattern", for: UIControlState())
            recordButtonOut.alpha = 0.75
            recTimer.invalidate()
            appDelegate.recordCounter = 0.0

        }
        
    }
    
    @IBAction func textPosSliderChanged(_ sender: UISlider) {
        textPosLabel.text = "Row "+String((Int)(sender.value*Float(maxTextPos)))
        appDelegate.row = (Int)(sender.value*Float(maxTextPos))
        backgroundLight.setNeedsDisplay()
    }
    
    func updateRecCounter() {
        appDelegate.recordCounter += 0.05
        appDelegate.setValue(15, forKey: "recordCounter")
        if(Int(appDelegate.recordCounter)%2==0){
          recordButtonOut.alpha = 0.25
        }else{
          recordButtonOut.alpha = 0.75
        }
        //print(appDelegate.recordCounter)
        
    }
    
    func roundToPlaces(_ value:CGFloat, places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return CGFloat(round(Double(value) * divisor) / divisor)
    }
    
    
    func FetchCustomAlbumPhotos()
    {
        var albumName = "Camera Roll"
        var assetCollection = PHAssetCollection()
        var albumFound = Bool()
        var photoAssets = PHFetchResult<AnyObject>()
        
        let fetchOptions = PHFetchOptions()
        //fetchOptions.predicate = NSPredicate(format: "title = %@", albumName)
        let collection:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        
        if let first_Obj:AnyObject = collection.firstObject{
            //found the album
            assetCollection = collection.firstObject as! PHAssetCollection
            albumFound = true
        }
        else { albumFound = false }
        var i = collection.count
        print(i)
        photoAssets = PHAsset.fetchAssets(in: assetCollection, options: nil) as! PHFetchResult<AnyObject>
        let imageManager = PHCachingImageManager()
        
        //        let imageManager = PHImageManager.defaultManager()
        
        images.removeAll()
        
        photoAssets.enumerateObjects({(object: AnyObject!,
            count: Int,
            stop: UnsafeMutablePointer<ObjCBool>) in
            
            if object is PHAsset{
                let asset = object as! PHAsset
                print("Inside  If object is PHAsset, This is number 1")
                
                let imageSize = CGSize(width: asset.pixelWidth,
                                       height: asset.pixelHeight)
                
                /* For faster performance, and maybe degraded image */
                let options = PHImageRequestOptions()
                options.deliveryMode = .fastFormat
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset,
                                          targetSize: imageSize,
                                          contentMode: .aspectFill,
                                          options: options,
                                          resultHandler: {
                                            (image, info) -> Void in
                                            self.photo = image!
                                            /* The image is now available to us */
                                            self.addImgToArray(self.photo)
                                            print("enum for image, This is number 2")
                                            
                })
                
            }
        })
        imageCollectionView.reloadData()
    }
    
    func addImgToArray(_ uploadImage:UIImage)
    {
        self.images.append(uploadImage)
        
        print("add")
        print(images.count)
    }
    
    @IBAction func deleteImage(_ sender: AnyObject) {
        print("duplicate")
        if(appDelegate.imgSeq[appDelegate.seq].drawFrames>1){
            appDelegate.imgSeq[appDelegate.seq].img_draw.remove(at: (appDelegate.imgSeq[appDelegate.seq].currentFrame))
            appDelegate.imgSeq[appDelegate.seq].drawFrames -= 1
            appDelegate.imgSeq[appDelegate.seq].currentFrame = (appDelegate.imgSeq[appDelegate.seq].drawFrames)-1
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
            drawCollection.reloadData()
        }else if(appDelegate.imgSeq[appDelegate.seq].drawFrames==1){
            appDelegate.imgSeq[appDelegate.seq].img_draw.append(UIImage())
            appDelegate.imgSeq[appDelegate.seq].img_draw.remove(at: (appDelegate.imgSeq[appDelegate.seq].currentFrame))
            appDelegate.imgSeq[appDelegate.seq].currentFrame = (appDelegate.imgSeq[appDelegate.seq].drawFrames)-1
            backgroundLight.setNeedsDisplay()
            previewLight.setNeedsDisplay()
            drawCollection.reloadData()
        }
    }
    
    @IBAction func duplicateImage(_ sender: AnyObject) {
        print("delete")
        appDelegate.imgSeq[appDelegate.seq].img_draw.insert((appDelegate.imgSeq[appDelegate.seq].img_draw[(appDelegate.imgSeq[appDelegate.seq].currentFrame)]), at: (appDelegate.imgSeq[appDelegate.seq].currentFrame))
        appDelegate.imgSeq[appDelegate.seq].drawFrames += 1
        backgroundLight.setNeedsDisplay()
        previewLight.setNeedsDisplay()
        drawCollection.reloadData()
    }
    
    // change background color when user touches cell
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if(collectionView == self.drawCollection){
            var index = collectionView.indexPathsForVisibleItems
            print("Test")
            print(index)
            
            
            var indexes = [IndexPath]()
            // assuming that tableView is your self.tableView defined somewhere
            for i in 0...drawCollection.numberOfSections - 1
            {
                for j in 0...drawCollection.numberOfItems(inSection: i)-1
                {
                    
                    let index = IndexPath(row: j, section: i)
                    indexes.append(index)
                    
                }
            }
            
            
            for i in 0 ..< index.count - 1 {
                print("Count")
                print(index[i])
                let cell = collectionView.cellForItem(at: index[i]) as! DrawCollectionViewCell
                cell.contentView.layer.borderColor = UIColor.white.cgColor
                cell.contentView.layer.borderWidth = 1
            }
            
            
            if(indexPath.item != appDelegate.imgSeq[appDelegate.imgSeqCtr].drawFrames){
                let cell = collectionView.cellForItem(at: indexPath) as! DrawCollectionViewCell
                cell.contentView.layer.borderColor = UIColor.white.cgColor
                cell.contentView.layer.borderWidth = 3            }
        }
    }
    
    func textFieldShouldReturn(_ userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    @IBAction func save(_ sender: AnyObject) {
        print("save")

        UIGraphicsBeginImageContextWithOptions(CGSize(width:400, height: 280), false, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let img_bg = UIImage(named: "brightness_pattern.jpg")
        context?.draw(imageWithImage(img_bg!, scaledToSize: CGSize(width: 400, height: 280)).cgImage!, in: CGRect(x:0, y:0, width:400, height:280))
        
        context?.setAlpha(0.7)
        
        // then flip Y axis
        context?.translateBy(x: 0, y: 280);
        context?.scaleBy(x: 1.0, y: -1.0);
        
        context?.draw(imageWithImage(appDelegate.imgSeq[appDelegate.seq].img_draw[0], scaledToSize: CGSize(width:400, height:280)).cgImage!, in: CGRect(x:0, y:0, width:400, height:280))
        
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        
        logoImage.append(img!)
        appDelegate.imgSeq[appDelegate.seq].preview_image = img!
        
        let name = "Saved Pattern "+String(appDelegate.imgSeq.count)
        items.append(name)

        saveImageSequencePersistent()
        
        appDelegate.imgSeq.append(ImageSequence())
        appDelegate.imgSeq.last?.img_draw = appDelegate.imgSeq[appDelegate.seq].img_draw
        appDelegate.imgSeq.last?.drawFrames = appDelegate.imgSeq[appDelegate.seq].drawFrames
        
        appDelegate.imgSeqCtr += 1
        backgroundLight.setNeedsDisplay()
        previewLight.setNeedsDisplay()
        drawCollection.reloadData()
        lightPatternCollectionView.reloadData()
    }
    
    
    func imageWithImage(_ image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func saveImageSequencePersistent(){
        
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "SavedImageSequence",
                                              in: appDelegate.managedObjectContext)
        
        let savedImageSequence = SavedImageSequence(entity: entityDescription!,
                               insertInto: appDelegate.managedObjectContext)
        
        //savedImageSequence.activeImage = appDelegate.imgSeq[appDelegate.imgSeqCtr].activeImage
        //savedImageSequence.img_draw = appDelegate.imgSeq[appDelegate.imgSeqCtr].img_draw
        //savedImageSequence.currentFrame = appDelegate.imgSeq[appDelegate.imgSeqCtr].currentFrame
        savedImageSequence.currentFrame = Float(appDelegate.imgSeq[appDelegate.seq].currentFrame)
        savedImageSequence.drawFrames = Float(appDelegate.imgSeq[appDelegate.seq].drawFrames)
        
        let thumbnailImageDatas = NSMutableArray()
        for image in appDelegate.imgSeq[appDelegate.seq].img_draw {
            print(image)
            if(image.cgImage != nil){
            thumbnailImageDatas.add(UIImagePNGRepresentation(image)!)
            }
            //[thumbnailImageDatas addObject:UIImagePNGRepresentation(resizedImage)];
        }
        let thumbnailImageData = NSKeyedArchiver.archivedData(withRootObject: thumbnailImageDatas)//[NSKeyedArchiver archivedDataWithRootObject:thumbnailImageDatas];
        
        print(thumbnailImageData)

        savedImageSequence.img_draw = thumbnailImageData
        
        let previewImageData = UIImagePNGRepresentation(appDelegate.imgSeq[appDelegate.seq].preview_image)
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImageSequence")
        
        appDelegate.imgSeq.count
        
        for i in 1...appDelegate.imgSeq.count {
            let name = "Saved Pattern "+String(i)
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
            var result: [AnyObject]?
            do {
                result = try managedContext.fetch(fetchRequest)
            } catch let nserror1 as NSError{
                result = nil
            }
        
            for resultItem in result! {
                let imageSequence = resultItem as! SavedImageSequence
                
                imageSequence.currentFrame = Float(appDelegate.imgSeq[i].currentFrame)
                imageSequence.drawFrames = Float(appDelegate.imgSeq[i].drawFrames)
                
                let thumbnailImageDatas = NSMutableArray()
                for image in appDelegate.imgSeq[i].img_draw {
                    print(image)
                    if(image.cgImage != nil){
                        thumbnailImageDatas.add(UIImagePNGRepresentation(image)!)
                    }
                    //[thumbnailImageDatas addObject:UIImagePNGRepresentation(resizedImage)];
                }
                let thumbnailImageData = NSKeyedArchiver.archivedData(withRootObject: thumbnailImageDatas)//[NSKeyedArchiver archivedDataWithRootObject:thumbnailImageDatas];
                
                print(thumbnailImageData)
                
                imageSequence.img_draw = thumbnailImageData
                
                let previewImageData = UIImagePNGRepresentation(appDelegate.imgSeq[i].preview_image)
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
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedImageSequence")
        
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
            result = try managedContext.fetch(fetchRequest)
        } catch let nserror1 as NSError{
            result = nil
        }
        
        for resultItem in result! {
            let imageSequence = resultItem as! SavedImageSequence
            let image = UIImage(data: imageSequence.preview_image as Data)//[UIImage imageWithData:selectedDance.danceImage];
            logoImage.append(image!)
            let name = "Saved Pattern "+String(appDelegate.imgSeq.count)
            items.append(name)
            appDelegate.imgSeq.append(ImageSequence())
            appDelegate.imgSeqCtr += 1
            appDelegate.imgSeq.last?.preview_image = image!
            
            var images = Array<UIImage>()
            let imageDatas = NSKeyedUnarchiver.unarchiveObject(with: imageSequence.img_draw as Data) as! NSArray // [NSKeyedUnarchiver unarchiveObjectWithData:self.thumbnailImagesData];
            for imageData in imageDatas {
                let img = UIImage(data: imageData as! Data)!
                
                UIGraphicsBeginImageContextWithOptions(CGSize(width:17, height: 12), false, 1)
                let context = UIGraphicsGetCurrentContext()
                
                context?.draw(imageWithImage(img, scaledToSize: CGSize(width: 17, height: 12)).cgImage!, in: CGRect(x:0, y:0, width:17, height:12))
                let imgCopy = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                images.append(imgCopy!)//[images addObject:[UIImage imageWithData:imageData]];
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

extension ViewController: LightPatternSelectionDelegate {
    func didSelectLightPattern(_ pattern: LightPattern) {
        print(pattern.name)
    }
}
