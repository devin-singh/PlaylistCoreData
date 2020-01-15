//
//  Song+Convenience.swift
//  PlaylistCoreData
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    
    convenience init(title: String, artist: String, playlist: Playlist, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.title = title
        self.artist = artist
        self.playlist = playlist
    }
}
