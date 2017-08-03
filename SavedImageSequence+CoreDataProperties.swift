//
//  ImageSequence+CoreDataProperties.swift
//  LightVisTool
//
//  Created by Marius Hoggenmüller on 20.07.16.
//  Copyright © 2016 Marius Hoggenmüller. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData
import UIKit

extension SavedImageSequence {
    
    @NSManaged var img_draw: Data
    @NSManaged var preview_image: Data
    @NSManaged var drawFrames: Float
    @NSManaged var currentFrame: Float
    @NSManaged var name: String

}
