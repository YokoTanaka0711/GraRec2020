//
//  FaceItemViewController.swift
//  PencilKitDraw
//
//  Created by 田中陽子 on 2020/01/02.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class FaceItemViewController: UIViewController {
    private let faces = ["face0", "face1", "face2", "face3", "face4", "face5","face6", "face7", "face8", "face9", "face10", "face11","face12", "face13", "face14"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.dragDelegate = self
    }
}

extension FaceItemViewController: UICollectionViewDataSource {
    //セルの表示数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faces.count;
    }
    
    // セル（要素）に表示する内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FaceCell", for: indexPath) as! FaceItemCollectionViewCell
        cell.itemImage.image = UIImage(named: faces[indexPath.item])
        return cell
    }
}

extension FaceItemViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard let image = UIImage(named: faces[indexPath.item]) else { return [] }
        let itemProvider = NSItemProvider(object: image)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
