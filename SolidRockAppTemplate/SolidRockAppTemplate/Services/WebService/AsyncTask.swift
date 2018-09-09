//
//  AsyncTask.swift
//  SolidRockAppTemplate
//
//  Created by Darko Damjanovic on 08.09.18.
//  Copyright © 2018 SolidRock. All rights reserved.
//

import Foundation

final class AsyncTask {
    private let dataTask: URLSessionDataTask
    
    init(dataTask: URLSessionDataTask) {
        self.dataTask = dataTask
    }
    
    func cancel() {
        self.dataTask.cancel()
    }
}
