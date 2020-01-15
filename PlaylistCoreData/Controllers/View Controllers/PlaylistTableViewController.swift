//
//  PlaylistTableViewController.swift
//  PlaylistCoreData
//
//  Created by Devin Singh on 1/15/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var playlistTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let name = playlistTextField.text, !name.isEmpty else {return}
        PlaylistController.shared.createPlaylist(withName: name)
        playlistTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        guard let songs = playlist.songs else {return UITableViewCell()}
        
        cell.textLabel?.text = playlist.name
        
        if songs.count == 1 {
            cell.detailTextLabel?.text = "\(songs.count) song"
        } else {
            cell.detailTextLabel?.text = "\(songs.count) songs"
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlist: playlist)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let destinationVC = segue.destination as? SongTableViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            destinationVC.playlist = playlist
            
        }
    }
}
