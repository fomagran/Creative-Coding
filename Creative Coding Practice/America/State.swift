//
//  AmericaEnum.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import Foundation
import SwiftUI

enum State {
    case Alabama
    case Alaska
    case Arizona
    case Arkansas
    case California
    case Colorado
    case Connecticut
    case Delaware
    case Florida
    case Georgia
    case Hawaii
    case Idaho
    case IllinoisIndiana
    case Iowa
    case Kansas
    case Kentucky
    case Louisiana
    case Maine
    case Maryland
    case Massachusetts
    case Michigan
    case Minnesota
    case Mississippi
    case Missouri
    case MontanaNebraska
    case Nevada
    case NewHampshire
    case NewJersey
    case NewMexico
    case NewYork
    case NorthCarolina
    case NorthDakota
    case Ohio
    case Oklahoma
    case Oregon
    case PennsylvaniaRhodeIsland
    case SouthCarolina
    case SouthDakota
    case Tennessee
    case Texas
    case Utah
    case Vermont
    case Virginia
    case Washington
    case WestVirginia
    case Wisconsin
    case Wyoming
    
    func path() -> UIBezierPath {
        switch self {
        case .Alabama:
            return washingtonPath
        case .Alaska:
            return washingtonPath
        case .Arizona:
            return washingtonPath
        case .Arkansas:
            return washingtonPath
        case .California:
            return washingtonPath
        case .Colorado:
            return washingtonPath
        case .Connecticut:
            return washingtonPath
        case .Delaware:
            return washingtonPath
        case .Florida:
            return washingtonPath
        case .Georgia:
            return washingtonPath
        case .Hawaii:
            return washingtonPath
        case .Idaho:
            return washingtonPath
        case .IllinoisIndiana:
            return washingtonPath
        case .Iowa:
            return washingtonPath
        case .Kansas:
            return washingtonPath
        case .Kentucky:
            return washingtonPath
        case .Louisiana:
            return washingtonPath
        case .Maine:
            return washingtonPath
        case .Maryland:
            return washingtonPath
        case .Massachusetts:
            return washingtonPath
        case .Michigan:
            return washingtonPath
        case .Minnesota:
            return washingtonPath
        case .Mississippi:
            return washingtonPath
        case .Missouri:
            return washingtonPath
        case .MontanaNebraska:
            return washingtonPath
        case .Nevada:
            return washingtonPath
        case .NewHampshire:
            return washingtonPath
        case .NewJersey:
            return washingtonPath
        case .NewMexico:
            return washingtonPath
        case .NewYork:
            return washingtonPath
        case .NorthCarolina:
            return washingtonPath
        case .NorthDakota:
            return washingtonPath
        case .Ohio:
            return washingtonPath
        case .Oklahoma:
            return washingtonPath
        case .Oregon:
            return washingtonPath
        case .PennsylvaniaRhodeIsland:
            return washingtonPath
        case .SouthCarolina:
            return washingtonPath
        case .SouthDakota:
            return washingtonPath
        case .Tennessee:
            return washingtonPath
        case .Texas:
            return washingtonPath
        case .Utah:
            return washingtonPath
        case .Vermont:
            return washingtonPath
        case .Virginia:
            return washingtonPath
        case .Washington:
            return washingtonPath
        case .WestVirginia:
            return washingtonPath
        case .Wisconsin:
            return washingtonPath
        case .Wyoming:
            return washingtonPath
        }
    }
}


