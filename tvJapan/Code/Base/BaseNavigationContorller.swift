//
//  BaseNavigationContorller.swift
//  ouo
//
//  Created by xiyanghh on 2018/3/7.
//  Copyright © 2018年 xiyanghh. All rights reserved.
//

import UIKit
import SnapKit
import EZSwiftExtensions
import SwiftyJSON

class BaseNavigationContorller: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = UINavigationBar.appearance()
//        navBar.barTintColor = colorMain
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]


    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器才需要隐藏, 根控制器 不需要处理
        
        let item = UIBarButtonItem.init(title: "", style: .done, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem = item
        
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
