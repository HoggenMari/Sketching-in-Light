//
//  TextCharacter.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 19.06.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//

import Foundation

class Chard {
    
    let height = 5
    let width = 4
    var array = Array<Array<Bool>>()

    func Chard () {
        for _ in 0...height {
            array.append(Array(repeating: Bool(), count: width))
        }
    }
    
    func Chard(_ charArray: Array<Array<Bool>>) {
        array = charArray
    }

}
    

class TextCharacter {
    
  let height = 5
  let width = 4
    
  var columns = Array<PixelSetColumn?>()
 
  func TextCharacter() {
  
  }
    
  func initColumns(_ numberOfColumns: Int) {
    columns = Array<PixelSetColumn?>(repeating: nil, count: numberOfColumns);
    
    //for (int i = 0; i < numberOfColumns; i++) {
    //  columns[i] = new PixelSetColumn();
    //}
  }
    
  //protected abstract void initPixels();
    
  func getColumns() -> Array<PixelSetColumn?> {
    return columns;
  }
    
}


class PixelSet {
    
    var pixels = Array<Bool?>();

    func PixelSet() {
        pixels = Array<Bool?>(repeating: nil, count: 4) ;
    }
    
    func getPixels() -> Array<Bool?> {
    return pixels;
    }
}


class PixelSetColumn {
    var pixelSets = Array<PixelSet?>();
    
    func PixelSetColumn() {
        pixelSets = Array<PixelSet?>(repeating: nil, count: 4);
        
        //for i in 0...pixelSets.count-1 {
        //    pixelSets[i] = new PixelSet()
       // }
        
        //for i in 0...pixelSets.count -1 {
        //    pixelSets[i] = new PixelSet()
        //}
    }
    
    func getPixelSets() -> Array<PixelSet?> {
        return pixelSets;
    }
}
