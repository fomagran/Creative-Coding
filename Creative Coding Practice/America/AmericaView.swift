//
//  AmericaView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/15.
//

import SwiftUI
import EasierPath

struct AmericaView: View {
    var body: some View {
        let path = Path(State.Washington.path().cgPath)
        path.fill(Color.red).overlay(path.stroke(Color.black, lineWidth: 2))
    }
}

struct AmericaView_Previews: PreviewProvider {
    static var previews: some View {
        AmericaView()
    }
}
