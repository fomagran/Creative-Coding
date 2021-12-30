//
//  ThreeDCardDataSource.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/29.
//

import UIKit

protocol ThreeDCardDataSource:AnyObject {
    func setCardImages() -> [UIImage]
}
