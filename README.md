# Notion Link

[Africa](https://www.notion.so/Africa-a41972d8c0a24b6c8ea536d550dbf47f)

[JSON Decoder](https://www.notion.so/JSON-Decoder-5fb71073292541f5a95180054f642b73)

[Africa UI Library](https://www.notion.so/Africa-UI-Library-c35b5164a25e4e0da1c4c187e27cf607)

# Launch Screen without `.storyboard`

- Go to `Project` `Info` Tab.
- Delete `info.plist` 's `Launch screen interface file base name` and `.storyboard` file.
- Create `Launch Screen` Key and add `image name` and `background color` .

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b3fc5aae-022d-403d-83b7-5cb7a868b953/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b3fc5aae-022d-403d-83b7-5cb7a868b953/Untitled.png)

# Enable Dark Mode

- Go to `Project` `Info` Tab.
- Add `Appearance` and its value `Dark` .

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2bd753d0-9c4d-4774-b37d-f26c7e381a45/Screen_Shot_2021-02-13_at_7.23.17_PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2bd753d0-9c4d-4774-b37d-f26c7e381a45/Screen_Shot_2021-02-13_at_7.23.17_PM.png)

# JSON Decode

### Main Objectives

1. To decode a local JSON file to populate a SwiftUI view with this data
2. To make this decoder function [ algorithm ] reusable anywhere
3. To make this decoder a generics to decode any JSON file

### Instructions

1. Locate the JSON file in the app Bundle
2. Create a property for the data
3. Create a JSON decoder
4. Decode the data and collect the information with a new property
5. Return the ready-to-use use data 

### Extension

- Swift Extension is a useful feature that helps in adding more functionality to an existing Class, Structure, Enumeration or a Protocol type.

### Bundle

- App developers use bundles in iOS and macOS to represent apps, frameworks, plug-ins, executable codes, or related resources such as images, sounds, videos, or other files.

### JSON Decoder

```swift
//
//  Bundle + Codable.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import Foundation

extension Bundle {
    
    func decode(_ fileName: String) -> [CoverImage] {
        
        // 1. Locate the json file
        guard let url: URL = self.url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in bundle")
        }
        
        // 2. Create a property for the data
        guard let data: Data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decoded data
        guard let loaded: [CoverImage] = try? decoder.decode([CoverImage].self, from: data) else {
            fatalError("Failed to decode \(fileName) from bundle.")
        }
        
        // 5. Return the ready-tu-use data
        return loaded
    }
    
}
```

### How to use it

```swift
let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
```

# Swift Generics

- Refactored JSON Decoder

```swift
import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ fileName: String) -> T {
        
        // 1. Locate the json file
        guard let url: URL = self.url(forResource: fileName, withExtension: nil) else {
            fatalError("Failed to locate \(fileName) in bundle")
        }
        
        // 2. Create a property for the data
        guard let data: Data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName) from bundle.")
        }
        
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for the decoded data
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(fileName) from bundle.")
        }
        
        // 5. Return the ready-tu-use data
        return loaded
    }
    
}
```

# Computed Property

```swift
//
//  Videop.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    // Computed Property
    var thumbnail: String {
        "video-\(id)"
    }
    
}
```

# Auto Play VideoPlayer Helper

```swift
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
```

- how to use it

```swift
let player = playVideo(fileName: "cheetah", fileFormat: "mp4")
VideoPlayer(player: player)
```

# Simple MapKit

```swift
//
//  InsetMapView.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import SwiftUI
import MapKit

struct InsetMapView: View {
    // MARK: - PROPERTIES
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.600286, longitude: 16.4377599),
        span: MKCoordinateSpan(latitudeDelta: 60.0, longitudeDelta: 60.0)
    )
    
    // MARK: - BODY
    
    var body: some View {
        Map(coordinateRegion: $region)
            .overlay(
                NavigationLink(destination: MapView()) {
                    HStack {
                        Image(systemName: "mappin.circle")
                            .foregroundColor(Color.white)
                            .imageScale(.large)
                        
                        Text("Locations")
                            .foregroundColor(.accentColor)
                            .fontWeight(.bold)
                    } //: HSTACK
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(
                        Color.black
                            .opacity(0.4)
                            .cornerRadius(8)
                    )
                } //: NAVIGATION LINK
                .padding(12),
                alignment: .topTrailing
            )
            .frame(height: 256)
            .cornerRadius(12)
    }
}

struct InsetMapView_Previews: PreviewProvider {
    static var previews: some View {
        InsetMapView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
```

# Bundle Main URL Debugging

- You need to click on `Target Membership` in order to find your file using `Bundle.main.url`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e3530948-d431-4a96-ba21-3b8853680586/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e3530948-d431-4a96-ba21-3b8853680586/Untitled.png)

# New iMessage Extension

- Click on `plus button on Project Panel
- Choose `Sticker Pack Extension`
- Just put images

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6cd9b82b-09cc-4eb2-9df9-1ce35108fcdf/Screen_Shot_2021-02-14_at_9.20.36_PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6cd9b82b-09cc-4eb2-9df9-1ce35108fcdf/Screen_Shot_2021-02-14_at_9.20.36_PM.png)

⇒ Click on `plus` button on Project Panel 

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f3025fd4-86ef-4824-901d-0830194cf4b6/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f3025fd4-86ef-4824-901d-0830194cf4b6/Untitled.png)

⇒ Choose `Sticker Pack Extension`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6fe01207-0375-4a38-87b1-ce1dcaf4eacd/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6fe01207-0375-4a38-87b1-ce1dcaf4eacd/Untitled.png)

⇒ Put images 

# Create Modifier

- Modifier changes the default behavior of SwiftUI

```swift
import SwiftUI

struct CenterModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
    
}
```

- Usage

```swift
CreditsView()
.modifier(CenterModifier())
```