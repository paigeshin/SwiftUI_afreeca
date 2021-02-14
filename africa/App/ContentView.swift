//
//  ContentView.swift
//  africa
//
//  Created by paigeshin on 2021/02/13.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    let animals: [Animal] = Bundle.main.decode("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    @State private var isGridViewActive: Bool = false
    
    //    let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State private var gridLayout: [GridItem] = [ GridItem(.flexible())]
    @State private var gridColumn: Int = 1
    @State private var toolbarIcon: String = "square.grid.2x2"
    
    //: MARK: - FUNCTIONS
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
        
        // TOOLBAR IMAGE
        switch gridColumn {
        case 1:
            toolbarIcon = "square.grid.2x2"
        case 2:
            toolbarIcon = "square.grid.3x2"
        case 3:
            toolbarIcon = "square.grid.3x3"
        default:
            toolbarIcon = "square.grid.2x2"
        }
        
    }
    
    var body: some View {
        // MARK: - BODY
        NavigationView {
            Group {
                if !isGridViewActive {
                    List {
                        CoverImageView()
                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                AnimalListItemView(animal: animal)
                            } //: Link
                        }
                        CreditsView()
                            .modifier(CenterModifier())
                    } //: LIST
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(animals) { animal in
                                NavigationLink(
                                    destination: AnimalDetailView(animal: animal),
                                    label: {
                                        AnimalGridItemView(animal: animal)
                                    }) //: LINK
                            } //: LOOP
                        } //: GRID
                        .padding(10)
                        .animation(.easeIn)
                    } //: SCROLL
                } //: CONDITION
            } //: GROUP
            .navigationBarTitle("Africa", displayMode: .large)
            //horizontal 방식으로 버튼을 추가할 수 있다.
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        
                        // LIST
                        Button(action: {
                            isGridViewActive = false
                            haptics.impactOccurred()
                        }, label: {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .primary : .accentColor)
                        })
                        
                        // GRID
                        Button(action: {
                            isGridViewActive = true
                            gridSwitch()
                            haptics.impactOccurred()
                        }, label: {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(isGridViewActive ? .accentColor : .primary)
                        })
                        
                    } //: HSTACK
                } //: BUTTONS
            } //: TOOLBAR
        } //: NAVIGATION
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
