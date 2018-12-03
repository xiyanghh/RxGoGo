//
//  GitHubViewController.swift
//  tvJapan
//
//  Created by com on 2018/11/22.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GitHubViewController: BaseViewController {
    
    
    //显示资源列表的tableView
    var tableView: UITableView!
    
    //搜索栏
    var searchBar: UISearchBar!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rxx"
        self.navigationBarColor = UIColor.red

        //创建表视图
        self.tableView = UITableView(frame:CGRect.zero, style:.plain)
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView!)
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        //创建表头的搜索栏
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0,
                                                   width: self.view.bounds.size.width, height: 56))
        self.tableView.tableHeaderView =  self.searchBar
        
//        let searchAction = searchBar.rx.text.orEmpty
//            .throttle(0.5, scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .asObservable()
        
        let searchAction = searchBar.rx.text.orEmpty.asDriver()
            .throttle(0.5)
            .distinctUntilChanged()
        
//        let viewModel = GitViewModel(searchAction: searchAction)
        let viewModel = GitViewModel(searchAction: searchAction)
        
//        viewModel.navigationTitle.bind(to: self.rx.title).disposed(by: disposeBag)
        viewModel.navigationTitle.drive(self.rx.title).disposed(by: disposeBag)

//        viewModel.repositories.bind(to: tableView.rx.items){ (tableView, row, element) in
//            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
//            cell.textLabel?.text = element.name
//            cell.detailTextLabel?.text = element.htmlUrl
//            return cell
//        }.disposed(by: disposeBag)
        
        viewModel.repositories.drive(tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.htmlUrl
            return cell
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(GitHubRepository.self)
            .subscribe(onNext: { [weak self]  (item) in
               self?.showAlert(title: item.fullName, message: item.description)
            }).disposed(by: disposeBag)
        
        
    }
    
    
    //显示消息
    func showAlert(title:String, message:String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
