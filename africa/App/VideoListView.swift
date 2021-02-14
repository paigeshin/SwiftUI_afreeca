//
//  VideoListView.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import SwiftUI

//HAPTIC IMPACT
//반짝인다.
struct VideoListView: View {
    // MARK: - PROPERTIES
    
    @State var videos: [Video] = Bundle.main.decode("videos.json")
    
    /* design tool, enhance user interface. Some of your actions will trigger haptic. */
    let hapticImpact = UIImpactFeedbackGenerator(style: .heavy)
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(videos) { item in
                    NavigationLink(destination: VideoPlayerView(videoSelected: item.id, videoTitle: item.name)) {
                        
                        VideoListItemView(video: item)
                            .padding(.vertical, 8)
                        
                    }
                } //: LOOP
            } //: LIST
            /* Add gray background */
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Videos", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Shuffle Videos
                        videos.shuffle()
                        hapticImpact.impactOccurred()
                    }, label: {
                        Image(systemName: "arrow.2.squarepath")
                    })
                }
            }
        } //: NAVIGATION
    }
    
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView()
    }
}
