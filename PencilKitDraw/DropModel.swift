//
//  DropModel2.swift
//  PencilKitDraw
//
//  Created by 田中陽子 on 2020/01/12.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

@objc protocol UIDropInteractionDelegate{
    
    func dropInteraction()
    
}

class DropInteraction : UIDropInteractionDelegate {

    func dropInteraction() {

    }

    weak var delegate = UIDropInteractionDelegate?()

    delegate.dropInteraction()

}
    
