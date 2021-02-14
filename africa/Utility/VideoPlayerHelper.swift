//
//  VideoPlayerHelper.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import Foundation
import AVKit

var videoPlayer: AVPlayer?

func playVideo(fileName: String, fileFormat: String) -> AVPlayer? {
    if let url: URL = Bundle.main.url(forResource: fileName, withExtension: fileFormat) {
        videoPlayer = AVPlayer(url: url)
        videoPlayer?.play()
    }
    return videoPlayer
}
