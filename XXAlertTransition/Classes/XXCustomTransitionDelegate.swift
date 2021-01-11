//
//  XXCustomTransitionDelegate.swift
//  XXUIComponent
//
//  Created by 魏梦雪 on 2021/1/8.
//  Copyright © 2021 魏梦雪. All rights reserved.
//

import UIKit

public enum XXTransitionStyle {
    case scaleFromCenter
    case scaleBig
    case fromCenter
    case fromBottom
}

public class XXCustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    var alertStyle: XXTransitionStyle = .fromCenter

    public init(alertStyle: XXTransitionStyle = .fromCenter) {
        super.init()
        self.alertStyle = alertStyle
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return XXPresentationController(presentedViewController: presented, presenting: presenting)
    }

    //负责present时的动画效果
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = XXCustomAnimator()
        animator.isPresentation = true
        animator.transitionStyle = alertStyle
        return animator
    }

    //负责dismiss时的动画效果
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = XXCustomAnimator()
        animator.isPresentation = false
        animator.transitionStyle = alertStyle
        return animator
    }
}
