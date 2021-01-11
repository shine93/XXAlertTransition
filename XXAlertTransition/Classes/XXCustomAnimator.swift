//
//  XXCustomAnimator.swift
//  XXUIComponent
//
//  Created by 魏梦雪 on 2021/1/8.
//  Copyright © 2021 魏梦雪. All rights reserved.
//

import UIKit

public class XXCustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    //用来标记present（true）还是dismiss（false）
    var isPresentation = false
    var transitionStyle: XXTransitionStyle = .fromCenter

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if isPresentation {
            //present动画
            guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
                return
            }
            containerView.addSubview(toView)
            switch transitionStyle {
            case .scaleFromCenter:
                toView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                UIView.animate(withDuration: 0.25) {
                    toView.transform = CGAffineTransform(scaleX: 1, y: 1)
                } completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            case .fromCenter:
                transitionContext.completeTransition(true)
            case .fromBottom:
                toView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                UIView.animate(withDuration: 0.25) {
                    toView.transform = .identity
                } completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            case .scaleBig:
                toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                UIView.animate(withDuration: 0.25) {
                    toView.transform = CGAffineTransform(scaleX: 1, y: 1)
                } completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            }

        } else {
            //dismiss动画
            guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
                return
            }
            switch transitionStyle {
            case .scaleFromCenter:
                fromView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                UIView.animate(withDuration: 0.25) {
                    fromView.transform = CGAffineTransform(scaleX: 1, y: 1)
                } completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            case .fromCenter:
                transitionContext.completeTransition(true)
            case .fromBottom:
                UIView.animate(withDuration: 0.25) {
                    fromView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
                } completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            case .scaleBig:
                fromView.transform = CGAffineTransform(scaleX: 1, y: 1)
                UIView.animate(withDuration: 0.25) {
                    fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                } completion: { (finished) in
                    transitionContext.completeTransition(true)
                }
            }

        }
    }

}
