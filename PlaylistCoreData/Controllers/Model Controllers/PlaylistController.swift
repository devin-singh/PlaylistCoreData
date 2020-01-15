//
//  PlaylistController.swift
//  PlaylistCoreData
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    // MARK: - Properties
    
    // Singleton
    static let shared = PlaylistController()
    
    var playlists: [Playlist] {
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        let results = try? moc.fetch(fetchRequest)
        return results ?? []
    }
    
    func createPlaylist(withName name: String) {
        _ = Playlist(name: name)
    }
    
    func deletePlaylist(playlist: Playlist) {
        if let moc = playlist.managedObjectContext {
            moc.delete(playlist)
            saveToPersistence()
        }
    }
    
    func saveToPersistence() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            print("There was a problem saving \(error)")
        }
    }
}
