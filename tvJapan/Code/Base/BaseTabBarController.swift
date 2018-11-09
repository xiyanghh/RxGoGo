//
//  BaseTabBarController.swift
//  ouo
//
//  Created by xiyanghh on 2018/3/7.
//  Copyright © 2018年 xiyanghh. All rights reserved.
//

import UIKit


class BaseTabBarController: UITabBarController {
    
    var v1: BaseNavigationContorller!
    var v2: BaseNavigationContorller!
    var v3: BaseNavigationContorller!
    var v4: BaseNavigationContorller!

    override func viewDidLoad() {
        super.viewDidLoad()

//        v1 = BaseNavigationContorller(rootViewController: WorkUnitsViewController())
//        v1.tabBarItem = UITabBarItem(title: "工作台", image: #imageLiteral(resourceName: "tab_work"), tag: 0)
//
//        v2 = BaseNavigationContorller(rootViewController: OrderViewController())
//        v2.tabBarItem = UITabBarItem(title: "订单", image: #imageLiteral(resourceName: "tab_order"), tag: 1)
//
//        v3 = BaseNavigationContorller(rootViewController: CustomerViewController())
//        v3.tabBarItem = UITabBarItem(title: "客户", image: #imageLiteral(resourceName: "tab_customer"), tag: 2)
//
//        v4 = BaseNavigationContorller(rootViewController: MyViewController())
//        v4.tabBarItem = UITabBarItem(title: "我的", image: #imageLiteral(resourceName: "tab_my"), tag: 3)
        
//        self.viewControllers = [v1, v3]
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
