//
//  XXCustomTransitionDelegate.swift
//  XXUIComponent
//
//  Created by 魏梦雪 on 2021/1/8.
//  Copyright © 2021 魏梦雪. All rights reserved.
//

import UIKit

enum XXTransitionStyle {
    case scaleFromCenter
    case scaleBig
    case fromCenter
    case fromBottom
}

class XXCustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    var alertStyle: XXTransitionStyle = .fromCenter

    init(alertStyle: XXTransitionStyle = .fromCenter) {
        super.init()
        self.alertStyle = alertStyle
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return XXPresentationController(presentedViewController: presented, presenting: presenting)
    }

    //负责present时的动画效果
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = XXCustomAnimator()
        animator.isPresentation = true
        animator.transitionStyle = alertStyle
        return animator
    }

    //负责dismiss时的动画效果
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = XXCustomAnimator()
        animator.isPresentation = false
        animator.transitionStyle = alertStyle
        return animator
    }
}
