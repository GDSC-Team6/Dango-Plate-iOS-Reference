//
//  ReviewReadViewModel.swift
//  DangoPlate
//
//  Created by Demian on 2023/12/03.
//

import Foundation
import PhotosUI

class ReviewReadViewModel: ObservableObject {
    let review: Review
    
    init (review: Review) {
        self.review = review
    }
}

extension ReviewReadViewModel {
    func loadUserInfo() {
        
    }
}
