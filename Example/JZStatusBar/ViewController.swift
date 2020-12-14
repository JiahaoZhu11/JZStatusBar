//
//  ViewController.swift
//  JZStatusBar
//
//  Created by jiahao_zhu98@outlook.com on 12/12/2020.
//  Copyright (c) 2020 jiahao_zhu98@outlook.com. All rights reserved.
//

import UIKit
import JZStatusBar

class ViewController: UIViewController {
    
    private lazy var statusBar = JZStatusBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(statusBar)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        statusBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

}

