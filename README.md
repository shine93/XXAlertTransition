# XXAlertTransition

[![CI Status](https://img.shields.io/travis/weimengxue/XXAlertTransition.svg?style=flat)](https://travis-ci.org/weimengxue/XXAlertTransition)
[![Version](https://img.shields.io/cocoapods/v/XXAlertTransition.svg?style=flat)](https://cocoapods.org/pods/XXAlertTransition)
[![License](https://img.shields.io/cocoapods/l/XXAlertTransition.svg?style=flat)](https://cocoapods.org/pods/XXAlertTransition)
[![Platform](https://img.shields.io/cocoapods/p/XXAlertTransition.svg?style=flat)](https://cocoapods.org/pods/XXAlertTransition)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![alert转场效果图](https://github.com/shine93/XXAlertTransition/blob/main/Example/alertDemo.gif)

使用Demo：
1. 创建一个用来present的控制器。
```
import UIKit
import XXAlertTransition

class XXAlertViewController: UIViewController, XXTransitionProtocol {
    var customTransitionDelegate: UIViewControllerTransitioningDelegate? //这个很重要，要是全局的，要不然transitionDelegete会不生效。
    
    lazy var alertButton: UIButton = {
        let alertButton = UIButton(type: .custom)
        alertButton.setTitle("从中间present", for: .normal)
        alertButton.setTitleColor(UIColor.white, for: .normal)
        alertButton.backgroundColor = .blue
        alertButton.layer.cornerRadius = 12
        alertButton.layer.masksToBounds = true
        alertButton.addTarget(self, action: #selector(tappedAlertButton), for: .touchUpInside)
        return alertButton
    }()
    lazy var alertButton2: UIButton = {
        let alertButton = UIButton(type: .custom)
        alertButton.setTitle("从中间稍微放大present", for: .normal)
        alertButton.setTitleColor(UIColor.white, for: .normal)
        alertButton.backgroundColor = .blue
        alertButton.layer.cornerRadius = 12
        alertButton.layer.masksToBounds = true
        alertButton.addTarget(self, action: #selector(tappedAlertButton2), for: .touchUpInside)
        return alertButton
    }()
    lazy var alertButton3: UIButton = {
        let alertButton = UIButton(type: .custom)
        alertButton.setTitle("从中间从小到大缩放present", for: .normal)
        alertButton.setTitleColor(UIColor.white, for: .normal)
        alertButton.backgroundColor = .blue
        alertButton.layer.cornerRadius = 12
        alertButton.layer.masksToBounds = true
        alertButton.addTarget(self, action: #selector(tappedAlertButton3), for: .touchUpInside)
        return alertButton
    }()
    lazy var alertButton4: UIButton = {
        let alertButton = UIButton(type: .custom)
        alertButton.setTitle("从底部移动present", for: .normal)
        alertButton.setTitleColor(UIColor.white, for: .normal)
        alertButton.backgroundColor = .blue
        alertButton.layer.cornerRadius = 12
        alertButton.layer.masksToBounds = true
        alertButton.addTarget(self, action: #selector(tappedAlertButton4), for: .touchUpInside)
        return alertButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(alertButton)
        view.addSubview(alertButton2)
        view.addSubview(alertButton3)
        view.addSubview(alertButton4)
        alertButton.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
        alertButton2.frame = CGRect(x: 50, y: 150, width: 300, height: 30)
        alertButton3.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
        alertButton4.frame = CGRect(x: 50, y: 250, width: 300, height: 30)
    }
    
    @objc private func tappedAlertButton() {
        customTransitionDelegate = XXCustomTransitionDelegate(alertStyle: .fromCenter)
        let toVc = XXAlertDemoVC()
        toVc.transitioningDelegate = customTransitionDelegate
        toVc.modalPresentationStyle = .custom
        present(toVc, animated: true, completion: nil)
    }

    @objc private func tappedAlertButton2() {
        customTransitionDelegate = XXCustomTransitionDelegate(alertStyle: .scaleFromCenter)
        let toVc = XXAlertDemoVC()
        toVc.transitioningDelegate = customTransitionDelegate
        toVc.modalPresentationStyle = .custom
        present(toVc, animated: true, completion: nil)
    }

    @objc private func tappedAlertButton3() {
        customTransitionDelegate = XXCustomTransitionDelegate(alertStyle: .scaleBig)
        let toVc = XXAlertDemoVC()
        toVc.transitioningDelegate = customTransitionDelegate
        toVc.modalPresentationStyle = .custom
        present(toVc, animated: true, completion: nil)
    }

    @objc private func tappedAlertButton4() {
        customTransitionDelegate = XXCustomTransitionDelegate(alertStyle: .fromBottom)
        let toVc = XXAlertDemoVC()
        toVc.transitioningDelegate = customTransitionDelegate
        toVc.modalPresentationStyle = .custom
        present(toVc, animated: true, completion: nil)
    }

}
```


2. 自定义一个弹窗：
```
import Foundation
import UIKit
import XXAlertTransition


class XXAlertDemoVC: XXCustomAlertVC {

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Hallo, world!"
        titleLabel.textColor = UIColor.red
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        return titleLabel
    }()

    lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "I am subtitle!"
        subtitleLabel.textColor = UIColor.gray
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        return subtitleLabel
    }()
    lazy var confirmButton: UIButton = {
        let confirmButton = UIButton(type: .custom)
        confirmButton.layer.cornerRadius = 10
        confirmButton.setTitle("dismiss", for: .normal)
        confirmButton.backgroundColor = UIColor.blue
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        return confirmButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(confirmButton)

        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30))

        view.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30))

        view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -10))
        view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 20))
        view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -20))
        view.addConstraint(NSLayoutConstraint(item: confirmButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 30))

        confirmButton.addTarget(self, action: #selector(tappedConfirmButton), for: .touchUpInside)
    }


    @objc func tappedConfirmButton() {
        dismiss(animated: true, completion: nil )
    }

}
```
- present的ViewController遵守以下'XXTransitionProtocol'，也可不遵守，但是需要声明一个全局的`customTransitionDelegate: UIViewControllerTransitioningDelegate?`
- `XXAlertDemoVC`也可不继承`XXCustomAlertVC`。但是需要自己设置(弹窗的大小由`preferredContentSize`控制，弹窗的圆角由`cornerRadius`控制):
```
view.layer.cornerRadius = 10
preferredContentSize = CGSize(width: 300, height: 150)
```

## Requirements
注意⚠️：'XXAlertTransition' >=0.4.0 版本可正常使用

## Installation

XXAlertTransition is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XXAlertTransition'
```

## Author

weimengxue, shine9328@qq.com

## License

XXAlertTransition is available under the MIT license. See the LICENSE file for more info.
