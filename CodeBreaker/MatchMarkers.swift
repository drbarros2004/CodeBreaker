//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Daniel Barros on 05/02/26.
//

import SwiftUI

struct MatchMarkers: View {
    
    var matches: [Match]
    
    var exactCount, foundCount: Int
    
    init( matches: [Match] ) {
        
        self.matches = matches // I can't use self until all the stored properties have velues
        
        exactCount = self.matches.count { $0 == .exact } // it counts how many .exact matches are there in the matches array
        foundCount = self.matches.count { $0 != .nomatch }
        
    }
    
    var body: some View {

        
        HStack {
            // (matches.count + 1)/2 == ceil(matches.count/2) == max number of columns
            ForEach ( 0..<((matches.count + 1) / 2), id: \.self) { column in
                VStack {
                    matchMarker(peg: column * 2) // upper peg = column * 2
                    if ( column * 2 + 1 < matches.count ) { matchMarker(peg: column * 2 + 1) } // lower peg
                    else { matchMarker(peg: 10) } // could be any number >= 6
                    
                    // TODO: adjust pegs that are "in the middle". I have to use a placeholder, I guess.
                }
            }
        }
        
    }
    
    @ViewBuilder
    func matchMarker(peg: Int) -> some View {
        
        Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 10, height: 10)
    }
}

struct MatchMarkersPreview: View {

    struct DummyRow {
        
        var colors: [Color]
        var matches: [Match]
        
    }
    
    let testData: [DummyRow] = [
        DummyRow(colors: [.primary, .primary, .primary], matches: [.exact, .inexact, .inexact]),
        DummyRow(colors: [.primary, .primary, .primary], matches: [.exact, .nomatch, .nomatch]),
        DummyRow(colors: [.primary, .primary, .primary, .primary], matches: [.exact, .exact, .inexact, .inexact]),
        DummyRow(colors: [.primary, .primary, .primary, .primary], matches: [.exact, .exact, .nomatch, .inexact]),
        DummyRow(colors: [.primary, .primary, .primary, .primary], matches: [.exact, .exact, .nomatch, .nomatch]),
        DummyRow(colors: [.primary, .primary, .primary, .primary, .primary, .primary], matches: [.exact, .nomatch, .nomatch, .inexact]),
        DummyRow(colors: [.primary, .primary, .primary, .primary, .primary, .primary], matches: [.exact, .exact, .exact, .inexact]),
        DummyRow(colors: [.primary, .primary, .primary, .primary, .primary], matches: [.exact, .exact, .exact, .inexact, .inexact, .inexact]),
        DummyRow(colors: [.primary, .primary, .primary, .primary, .primary], matches: [.exact, .exact, .nomatch, .inexact, .nomatch, .nomatch])
    ]
    
    var body: some View {
        
        VStack (alignment: .leading){ // TODO: adjust alignment, matchMarkers sizes and padding between rows
            // these colors and matches arrays match the ones of the screenshot example
            
            ForEach(0..<testData.count, id: \.self) { index in
                pegs(colors: testData[index].colors, matches: testData[index].matches)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    func pegs(colors: [Color], matches: [Match]) -> some View {
        
        HStack {
            
            ForEach(colors.indices, id: \.self) {index in
                Circle().foregroundStyle(colors[index])
                    .frame(width: 45, height: 45)
                }
            
            MatchMarkers(matches: matches)
            
        }
            
    }
    
}

#Preview {
    MatchMarkersPreview()
}

