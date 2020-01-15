//
//  Playlist+Convenience.swift
//  PlaylistCoreData
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

extension Playlist {
    
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
