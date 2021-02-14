//
//  CenterModifier.swift
//  africa
//
//  Created by paigeshin on 2021/02/14.
//

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
