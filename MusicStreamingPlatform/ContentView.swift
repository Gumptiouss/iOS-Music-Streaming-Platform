//
//  ContentView.swift
//  MusicStreamingPlatform
//
//  Created by Bardia Naderi on 2023-01-04.
//

import SwiftUI
import Firebase

struct Album : Hashable {
    var id = UUID()
    var name : String
    var image : String
    var songs : [Song]
}

struct Song : Hashable {
    var id = UUID()
    var name : String
    var time : String
}

struct ContentView: View {
    @ObservedObject var data : OurData
    
    @State private var currentAlbum : Album?

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    LazyHStack{
                        ForEach(self.data.albums, id: \.self, content: {
                            album in
                            AlbumArt(album: album, isWithText: true).onTapGesture {
                                self.currentAlbum = album
                            }
                        })
                    }
                })
                LazyVStack{
                    if self.data.albums.isEmpty {
                        EmptyView()
                    }
                    else {
                        ForEach((self.currentAlbum?.songs ?? self.data.albums.first?.songs) ?? [], id: \.self, content: {
                            song in SongCell(album: currentAlbum ?? self.data.albums.first!, song: song)
                        })
                    }
                                                                                                                                 }
            }.navigationTitle("Artist Name Here")
                                                                                                                                 }
                                                                                                                                 }
                                                                                                                             }

struct AlbumArt: View {
    var album: Album
    var isWithText : Bool

    var body: some View {
        ZStack(alignment: .bottom, content: {
            Image(album.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 200, alignment: .center)
            
            if isWithText == true {
                ZStack {
                    Blur(style: .dark)
                    Text(album.name).foregroundColor(.white)
                }.frame(height: 60, alignment: .center)
            }
        }).frame(width: 170, height: 200, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10).padding(20)
    }
}

struct SongCell: View {
    var album : Album
    var song: Song
    var body: some View {
        NavigationLink(
            destination: PlayerView(album: album, song: song),
            label: {
                HStack(alignment: .center) {
                    ZStack{
                        Circle().fill(Color.blue).frame(width: 50, height: 50)
                        Circle().fill(Color.white).frame(width: 20, height: 20)
                    }
                    Text(song.name).bold()
                    Spacer()
                    Text(song.time)
                }.padding(20)
            }).buttonStyle(PlainButtonStyle())
    }
}
