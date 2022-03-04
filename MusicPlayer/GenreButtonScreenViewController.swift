//
//  GenreButtonScreenViewController.swift
//  MusicPlayer
//
//  Created by Eugenia Consoli on 04/03/22.
//

import UIKit
import MediaPlayer
import MusicKit
import AVFoundation


class GenreButtonScreenViewController: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func genreButtonTapped(_ sender: UIButton){
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                    DispatchQueue.main.async {
                       self.playGenre(genre: sender.currentTitle ?? String())
                    }
            }
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
    }
    
    func playGenre(genre: String)  {
        musicPlayer.stop()
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
    }
}
