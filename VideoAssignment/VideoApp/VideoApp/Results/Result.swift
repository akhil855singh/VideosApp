//
//  Result.swift
//  VideoApp
//
//  Created by Akhil Singh on 28/01/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
