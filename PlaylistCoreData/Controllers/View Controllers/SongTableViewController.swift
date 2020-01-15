//
//  SongTableViewController.swift
//  PlaylistCoreData
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    // MARK: - Properties
    var playlist: Playlist?
    
    // MARK: - Outlets
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        title = playlist?.name
    }
    
    //MARK: - Actions
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let playlist = playlist,
        let title = songTextField.text,
        let artist = artistTextField.text,
        !title.isEmpty, !artist.isEmpty else { return }
        // Creates new song with params
        SongController.createSongWith(title: title, artist: artist, playlist: playlist)
        songTextField.text = ""
        artistTextField.text = ""
        // Reload data
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        if let playlist = playlist,
            let song = playlist.songs?.object(at: indexPath.row) as? Song {
            cell.textLabel?.text = song.title
            cell.detailTextLabel?.text = song.artist
        }
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist, let song = playlist.songs?.object(at: indexPath.row) as? Song else { return }
            SongController.delete(song: song)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
