//
//  OptionalExt.swift
//  tvJapan
//
//  Created by com on 2018/11/29.
//  Copyright © 2018 yyets. All rights reserved.
//

import UIKit



class OptionalExt: BaseViewController {
    
    var btn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
//        btn = UIButton()
        
//        guard btn != nil else {
//            fatalError("Missing Interface Builder connections")
//        }
        
//        guard btn.isSome else {
//            print(btn.isSome)
//            fatalError("Missing Interface Builder connections")
//        }
//
//        let op: Int? = nil
//
//        print(op.or(3))
//
//        print(op.or(else: 3 * 32 ))
        
//        let os: String? = "hello"
//        let os2: String? = nil
//
//        print(os.map({ $0.count }, default: 0))
//        print(os2.map({ $0.count }, default: 0))
//
//        print(os2.map({ $0.count}, else: { "default".count }))

  
       
        
    }
    
//    func bubbleSort(_ inputArr:[Int]) -> [Int] {
//        guard inputArr.count > 1 else {
//            return inputArr
//        }
//        var res = inputArr
//        let count = res.count
//        var isSwapped = false
//        repeat {
//            isSwapped = false
//            for index in stride(from: 1, to: count, by: 1) {
//                if res[index] < res[index - 1] {
//                    res.swapAt((index - 1), index)
//                    isSwapped = true
//                }
//            }
//        } while isSwapped
//        return res
//    }
    
    
    func should(_ do: () throws -> Void) -> Error?{
        do{
            try `do`()
            return nil
        }catch let error{
            return error
        }
    }
    
}


extension Optional{
    
    
    /// 当可选值不为空时，执行 `some` 闭包
    func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }
    
    /// 当可选值为空时，执行 `none` 闭包
    func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
    
    ///可选值为空时返回true
    private var isNone: Bool{
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    ///可选值非空返回false
    var isSome: Bool{
        return !isNone
    }
    
    ///返回可选值或默认值
    /// - 参数： 如果可能为空，将会是默认值
    func or(_ default: Wrapped) -> Wrapped{
        return self ?? `default`
    }
    
    /// 返回可选值或 `else` 表达式返回的值
    /// 例如. optional.or(else: print("Arrr"))
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 返回可选值或者 `else` 闭包返回的值
    /// 例如. optional.or(else: {
    /// ... do a lot of stuff
    /// })
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 当可选值不为空时，返回可选值
    /// 如果为空，抛出异常
    func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
    
    /// 可选值变换返回，如果可选值为空，则返回默认值
    /// - 参数 fn: 映射值的闭包
    /// - 参数 default: 可选值为空时，将作为返回值
    func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T{
        return try map(fn) ?? `default`
    }
    
    /// 可选值变换返回，如果可选值为空，则调用 `else` 闭包
    /// - 参数 fn: 映射值的闭包
    /// - 参数 else: The function to call if the optional is empty
    func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }
    
    ///  当可选值不为空时，解包并返回参数 `optional`
    func and<B>(_ optional: B?) -> B? {
        guard self != nil else { return nil }
        return optional
    }
    
    /// 解包可选值，当可选值不为空时，执行 `then` 闭包，并返回执行结果
    /// 允许你将多个可选项连接在一起
    func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    
    /// 将当前可选值与其他可选值组合在一起
    /// 当且仅当两个可选值都不为空时组合成功，否则返回空
    func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }
    
    /// 将当前可选值与其他可选值组合在一起
    /// 当且仅当三个可选值都不为空时组合成功，否则返回空
    func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
        guard let first = self,
            let second = other,
            let third = another else { return nil }
        return (first, second, third)
    }
    
}
    

extension Optional where Wrapped == Error {
    /// 当可选值不为空时，执行 `else`
    func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
}
