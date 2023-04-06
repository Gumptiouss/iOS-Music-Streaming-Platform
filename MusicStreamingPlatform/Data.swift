//
//  Data.swift
//  MusicStreamingPlatform
//
//  Created by Bardia Naderi on 2023-01-05.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore

class OurData : ObservableObject{
    @Published public var albums = [Album]()
    func loadAlbums() {
        Firestore.firestore().collection("albums").getDocuments { ( snapshot, error) in
            if error == nil {
                for document in snapshot!.documents {
                    let name = document.data()["name"] as? String ?? "error"
                    let image = document.data()["image"] as? String ?? "error"
                    var songsArray = [Song]()
                    let songs = document.reference.collection("songs").getDocuments { (songsSnapshot, songsError) in
                                        if songsError == nil {
                                            for song in songsSnapshot!.documents {
                                                let songName = song.data()["name"] as? String ?? "error"
                                                let songTime = song.data()["time"] as? String ?? "error"
                                                songsArray.append(Song(name: songName, time: songTime))
                                                print(songsArray)
                                            }
                                        }
                                        else {
                                            print(songsError ?? "error")
                                        }
                                    }
                    self.albums.append(Album(name: name, image: image, songs: songsArray))
                                }
                            }
                            else {
                                print(error ?? "error")
                            }
                        }
                    }
}
