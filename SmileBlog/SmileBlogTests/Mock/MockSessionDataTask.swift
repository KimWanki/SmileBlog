//
//  MockSessionDataTask.swift
//  SmileBlogTests
//
//  Created by WANKI KIM on 2021/11/05.
//

import Foundation
@testable import SmileBlog

class MockURLSessionDataTask: URLSessionDataTask {
    override init() {}
    var resumeDidCall: () -> Void = {}
    
    override func resume() {
        resumeDidCall()
    }
}
