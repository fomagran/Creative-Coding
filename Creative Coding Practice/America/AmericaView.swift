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
        
        let width:CGFloat = 150
        let height:CGFloat = 100

        let easierPath = EasierPath(0,0)
            .down(height)
            .right(width)
            .up(height)
            .left(width)
   
            
   
        
        let washington = Path(easierPath.path.cgPath)
        washington.fill(Color.red).overlay(washington.stroke(Color.black, lineWidth: 2))
            .padding(10)
        
//        VStack(spacing:-550) {
//            let washington = Path(State.Washington.path().cgPath)
//            washington.fill(Color.red).overlay(washington.stroke(Color.black, lineWidth: 2))
//
//            let oregon = Path(State.Oregon.path().cgPath)
//            oregon.fill(Color.orange).overlay(oregon.stroke(Color.black, lineWidth: 2))
//
//        }
            
      
    }
}

struct AmericaView_Previews: PreviewProvider {
    static var previews: some View {
        AmericaView()
    }
}
