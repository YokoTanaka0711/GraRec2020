//
//  DropView.swift
//  PencilKitDraw
//
//  Created by 田中陽子 on 2020/01/12.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DropView: UIView {
    

//    //    ドロップされるview（=DrawingViewControllerの保持するview）
//     func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
//
//         let dropInteraction = UIDropInteraction(delegate: self)
//         view.addInteraction(dropInteraction)
//     }
    
     func dropInteraction(
       _ interaction: UIDropInteraction,
       sessionDidUpdate session: UIDropSession) -> UIDropProposal {

       let dropLocation = session.location(in: view)
       let operation: UIDropOperation

       if imageView.frame.contains(dropLocation) {
         operation = session.localDragSession == nil ? .copy : .move
       } else {
         operation = .cancel
       }

       return UIDropProposal(operation: operation)
     }

}
