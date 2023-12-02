//
//  SearchRadius.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/25/23.
//

import Foundation

enum SearchRadius {
    case narrow(Int, String)
    case mediumNarrow(Int, String)
    case medium(Int, String)
    case mediumWide(Int, String)
    case wide(Int, String)
}
