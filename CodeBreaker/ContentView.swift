//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Daniel Barros on 02/02/26.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
            VStack {
                pegs(colors: [.red, .green, .green, .blue,])
                pegs(colors: [.red, .green, .green, .blue])
                pegs(colors: [.red, .blue, .green, .blue])
                pegs(colors: [.red, .yellow, .green, .blue])
                pegs(colors: [.red, .green, .green, .blue])
                pegs(colors: [.red, .red, .red, .blue])
            }
        .padding()
    }
    
    @ViewBuilder
    func pegs(colors: Array<Color>) -> some View { // we could've used [Color] to represent Array<Color>
        HStack {
            ForEach(colors.indices, id: \.self) {index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
                }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact, .inexact, .inexact])
        }
        
    }
    
}

enum Match {
    case nomatch
    case exact
    case inexact
}


#Preview {
    ContentView()
}
