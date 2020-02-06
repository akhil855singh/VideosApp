//
//  HelperClass.swift
//  VideoApp
//
//  Created by Akhil Singh on 06/02/20.
//  Copyright © 2020 Akhil Singh. All rights reserved.
//

import Foundation
import UIKit

func makeViewRounded(_ view:UIView){
    view.layer.cornerRadius = view.bounds.size.height/2
    view.clipsToBounds = true
    view.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
    view.layer.borderWidth = 1.0
}

