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
            array.append(Array(count:width, repeatedValue:Bool()))
        }
    }
    
    func Chard(charArray: Array<Array<Bool>>) {
        array = charArray
    }

}
    

class TextCharacter {
    
  let height = 5
  let width = 4
    
  var columns = Array<PixelSetColumn?>()
 
  func TextCharacter() {
  
  }
    
  func initColumns(numberOfColumns: Int) {
    columns = Array<PixelSetColumn?>(count: numberOfColumns, repeatedValue: nil);
    
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
        pixels = Array<Bool?>(count: 4, repeatedValue: nil) ;
    }
    
    func getPixels() -> Array<Bool?> {
    return pixels;
    }
}


class PixelSetColumn {
    var pixelSets = Array<PixelSet?>();
    
    func PixelSetColumn() {
        pixelSets = Array<PixelSet?>(count: 4, repeatedValue: nil);
        
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