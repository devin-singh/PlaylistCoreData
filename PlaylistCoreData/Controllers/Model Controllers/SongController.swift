//
//  SongController.swift
//  PlaylistCoreData
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

class SongController {
    
    static func createSongWith(title: String, artist: String, playlist: Playlist) {
        _ = Song(title: title, artist: artist, playlist: playlist)
        PlaylistController.shared.saveToPersistence()
    }
    
    static func delete(song: Song) {
        if let moc = song.managedObjectContext {
            moc.delete(song)
            PlaylistController.shared.saveToPersistence()
        }
    }
}
