//
//  LightPatternCollectionViewController.swift
//  SketchingInLight
//
//  Created by Marius Hoggenmüller on 01.11.17.
//  Copyright © 2017 Marius Hoggenmüller. All rights reserved.
//

import UIKit

private let reuseIdentifier = "lightPatternCell"

public enum LightPattern: Int {
    case None
    case FadeBrightness
    case FadeRed
    case FadeGreen
    case FadeBlue
    case Ellipse
    case Rectangle
    case HorizontalLine
    case VerticalLine
    case HorizontalBox
    case VerticalBox
    case Text
    case KeyFrame
    case Image
    case Processing
    
    static func count() -> Int {
        return LightPattern.Processing.rawValue + 1
    }
    
    var name: String {
        switch self {
        case .None:
            return "None"
        case .FadeBrightness:
            return "Fade Brightness"
        case .FadeRed:
            return "Fade Red"
        case .FadeGreen:
            return "Fade Green"
        case .FadeBlue:
            return "Fade Blue"
        case .Ellipse:
            return "Ellipse"
        case .Rectangle:
            return "Rectangle"
        case .HorizontalLine:
            return "Horizontal Line"
        case .VerticalLine:
            return "Vertical Line"
        case .HorizontalBox:
            return "Horizontal Box"
        case .VerticalBox:
            return "Vertical Box"
        case .Text:
            return "Text"
        case .KeyFrame:
            return "Key Frames"
        case .Image:
            return "Image"
        case .Processing:
            return "Processing"
        }
    }
    
    var image: UIImage {
        switch self {
        case .None:
            return UIImage(named: "default.png")!
        case .FadeBrightness:
            return UIImage(named: "brightness_pattern.jpg")!
        case .FadeRed:
            return UIImage(named: "red_pattern.jpg")!
        case .FadeGreen:
            return UIImage(named: "green_pattern.jpg")!
        case .FadeBlue:
            return UIImage(named: "blue_pattern.jpg")!
        case .Ellipse:
            return UIImage(named: "circle_pattern.jpg")!
        case .Rectangle:
            return UIImage(named: "rect_pattern.jpg")!
        case .HorizontalLine:
            return UIImage(named: "line_pattern.jpg")!
        case .VerticalLine:
            return UIImage(named: "line2_pattern.jpg")!
        case .HorizontalBox:
            return UIImage(named: "line3_pattern.jpg")!
        case .VerticalBox:
            return UIImage(named: "line4_pattern.jpg")!
        case .Text:
            return UIImage(named: "text_pattern.jpg")!
        case .KeyFrame:
            return UIImage(named: "light_pattern.jpg")!
        case .Image:
            return UIImage(named: "image_pattern.jpg")!
        case .Processing:
            return UIImage(named: "wlan.jpg")!
        }
    }
}

protocol LightPatternSelectionDelegate: class {
    func didSelectLightPattern(_ pattern: LightPattern)
}

class LightPatternCollectionViewController: UICollectionViewController {
    
    weak var delegate:LightPatternSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LightPattern.count()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LightPatternCollectionViewCell
        
        if let text = LightPattern(rawValue: indexPath.item)?.name, let image = LightPattern(rawValue: indexPath.item)?.image {
            cell.myLabel.text = text
            cell.myImage.image = image
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pattern = LightPattern(rawValue: indexPath.item) {
            delegate?.didSelectLightPattern(pattern)
        }
    }

}
