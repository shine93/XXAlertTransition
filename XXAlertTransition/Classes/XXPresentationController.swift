//
//  XXPresentationController.swift
//  XXUIComponent
//
//  Created by 魏梦雪 on 2021/1/8.
//  Copyright © 2021 魏梦雪. All rights reserved.
//

import UIKit

//XXTransitionProtocol: present的VC需要遵循
protocol XXTransitionProtocol {
    var customTransitionDelegate: UIViewControllerTransitioningDelegate? { get } //这个很重要，要是全局的，要不然transitionDelegete会不生效。
}

public class XXPresentationController: UIPresentationController {

    let dimmingView = UIView()

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var adaptivePresentationStyle: UIModalPresentationStyle {
        return .overCurrentContext
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return container.preferredContentSize
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return CGRect()
        }
        let containerBounds = containerView.bounds
        var presentedViewFrame = containerBounds

        presentedViewFrame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.x = containerBounds.size.width / 2 - presentedViewFrame.size.width / 2
        presentedViewFrame.origin.y = containerBounds.size.height / 2 - presentedViewFrame.size.height / 2

        return presentedViewFrame
    }

    override func presentationTransitionWillBegin() {
        dimmingView.backgroundColor = UIColor.black
        dimmingView.alpha = 0.0
        containerView?.insertSubview(dimmingView, at: 0)

        guard let coordinator = presentedViewController.transitionCoordinator else {
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.4
        }, completion: nil)

    }

    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        }) { (_) in
            self.dimmingView.removeFromSuperview()
        }
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let containerView = containerView else {
            return
        }
        //不能写dimmingView.bounds
        dimmingView.frame = containerView.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}


