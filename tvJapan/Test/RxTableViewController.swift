//
//  RxTableViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/9.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxTableViewController: UIViewController {
    
    var tableView:UITableView!
    
    var barImageView:UIView?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //导航栏背景色为橙色
        self.navigationController?.navigationBar.barTintColor = .orange
        
        //获取导航栏背景视图
        self.barImageView = self.navigationController?.navigationBar.subviews.first
        
        //创建表格视图
        self.tableView = UITableView(frame: self.view.frame, style:.grouped)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        
        //初始化数据
        //Array(0...100).map{ "这个是条目\($0)"}
        let array = Array(1...3).map { (num) -> String in
            return "哈哈\(num)"
        }
        let items = Observable.just([
            SectionModel(model: "1", items: array),
            SectionModel(model: "2", items: array),
            SectionModel(model: "3", items: array),
            ])
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: { (_, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = element
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.tableView.rx
            .itemSelected
            .subscribe(onNext: {IndexPath in
                print(IndexPath)
            }).disposed(by: disposeBag)
        
        
        
        
        
        
        
        
//        //设置单元格数据（其实就是对 cellForRowAt 的封装）
//        items.bind(to: tableView.rx.items) { (tableView, row, element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
//            cell.textLabel?.text = "\(element)"
//            return cell
//            }
//            .disposed(by: disposeBag)
//
//
//        _ = self.tableView.rx.observe(CGPoint.self, "contentOffset").subscribe(onNext: { [weak self] offset in
//            let delta = offset!.y / CGFloat(64) + 1
////            delta = CGFloat.maximum(delta, 0)
////            self?.barImageView?.alpha = CGFloat.minimum(delta, 1)
//            self?.barImageView?.alpha = delta
//
//        })
//
//        self.tableView.rx.modelSelected(String.self).subscribe(onNext: { (string) in
//            print(string)
//        }).disposed(by: disposeBag)
//
//        self.tableView.rx
//            .itemSelected
//            .subscribe(onNext: { indexPath in
//               print("itemSelected\(indexPath)")
//            })
//            .disposed(by: disposeBag)
        
        
        
        
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
