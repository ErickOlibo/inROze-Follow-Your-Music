//
//  TabBarViewController.swift
//  InRoZe
//
//  Created by Erick Olibo on 05/08/2017.
//  Copyright © 2017 Erick Olibo. All rights reserved.
//

import UIKit


class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .black
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = Colors.logoRed


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}
