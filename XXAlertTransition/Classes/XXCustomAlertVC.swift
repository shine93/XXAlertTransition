//
//  XXCustomAlertVC.swift
//  XXUIComponent
//
//  Created by 魏梦雪 on 2021/1/10.
//  Copyright © 2021 魏梦雪. All rights reserved.
//  由alert出来的VC继承

import Foundation
import UIKit

public class XXCustomAlertVC: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 10
        preferredContentSize = CGSize(width: 300, height: 150)
    }
}
