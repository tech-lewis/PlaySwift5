//
//  AAService.swift
//  Demo1
//
//  Created by mac on 24.7.20.
//  Copyright © 2020 Tsinghua University. All rights reserved.
//

import UIKit
enum HTTPMethod {
    case GET
    case POST
    case RANGE
    case PUT
}

struct API {
    static let hostName = ""
    static let baseURL = ""
}


class AAService: AFHTTPSessionManager
{
//    class var shareInsetance: AAService {
//        static var onceToken: dispatch_queue_t
//        static instance: AAService = nil
//    }
    // dispatch_once(&onceToken){ //实例化这个变量}
    //RETURN instance
    //OC的写法 只是Swift语法
    
    static let shareInstance = AAService()
    func initManager() {
        //let manager = AAService()
        //manager.requestSerializer = AFJSONRequestSerializer() //XML怎么解决
        let settings = NSSet(objects: "text/html", "application/json", "text/json")
        //manager .responseSerializer.acceptableContentTypes = settings as? Set<String>
        
        //add 请求头部
        //manager.requestSerializer.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
    }
    //    private init(){)} //很重要的是不能调用初始化方法
    
}
