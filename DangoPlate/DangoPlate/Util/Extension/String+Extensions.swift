//
//  String+Extension.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 10/25/23.
//

import Foundation

extension String {
    func createRandomString(len: Int) -> String {
        let str = (0..<len).map{ _ in self.randomElement()! }
        return String(str)
    }
}
