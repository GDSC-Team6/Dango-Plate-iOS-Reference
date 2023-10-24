//
//  Path.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/25/23.
//

import Foundation

class PathModel: ObservableObject {
    @Published var paths: [PathType]
    
    init(paths: [PathType] = []) {
        self.paths = paths
    }
}
