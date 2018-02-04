//
//  HTTP.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class HTTP:NSObject {
   static let progress: LoadingProgress = LoadingProgress.shared
    static let disposeBag = DisposeBag()
    
   
    class func getRequest(url:String) -> Observable<(Bool,Any)> {
        
    
        return Observable.create{ observer in
            
            if !(NetworkReachabilityManager()?.isReachable)! {
                observer.onNext((false,""))
                observer.onCompleted()
            }
            progress.showPI(message: "Loading...")
            RxAlamofire.requestJSON(.get, url, parameters: nil, headers: nil).debug().subscribe(onNext: { (head, body) in
                progress.hide()
                let errNum:Int = head.statusCode
                if errNum == 200 {
                    
                    guard let data = body as? [String:Any] else {
                        observer.onNext((false,""))
                        observer.onCompleted()
                        return
                    }
                    observer.onNext((true,data))
                    observer.onCompleted()
                }else {
                    observer.onNext((false,""))
                    observer.onCompleted()
                }
            }, onError: { error in
                progress.hide()
            }).disposed(by: disposeBag)
                return Disposables.create()
            }.share(replay: 1)
    }
}
