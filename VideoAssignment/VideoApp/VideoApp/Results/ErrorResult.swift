//
//  ErrorResult.swift
//  VideoApp
//
//  Created by Akhil Singh on 28/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
