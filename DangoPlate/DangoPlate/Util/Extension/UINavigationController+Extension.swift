//
//  UINavigationController+Extension.swift
//  DangoPlate
//
//  Created by Jinyoung Yoo on 11/22/23.
//

import UIKit

// MEMO: - navigationBarBackButtonHidden()이어도 swipe 제스처가 동작하게 하는 코드

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
