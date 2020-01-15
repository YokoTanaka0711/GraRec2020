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
    
    var parentVC: DrawingViewController!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // レイアウトを調整
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        
        let dropInteraction = UIDropInteraction(delegate: self)
        view.addInteraction(dropInteraction)
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

extension FaceItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 3 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
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

extension FaceItemViewController: UIDropInteractionDelegate {
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        // ドラッグ中のアイテムが画像を含んでいる場合はドロップ可能
        if session.canLoadObjects(ofClass: UIImage.self) {
            return UIDropProposal(operation: .copy)
        } else {
            return UIDropProposal(operation: .cancel)
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self, completion: { [weak self] imageItems in
            guard let images = imageItems as? [UIImage] else { return }
            let imageView = UIImageView(image: images.first)
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            self?.parentVC.canvasView.addSubview(imageView)
        })
    }
}
