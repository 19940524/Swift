//
//  SubscribeCollectionView.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/15.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import ESPullToRefresh

class SubCell: CYCollectionViewCell {
    
    private let button: UIButton = UIButton(type: UIButtonType.custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.RGB(r: 230, g: 230, b: 230)
        
        self.contentView.addSubview(button)
        
    }
    
    func setImage(image: UIImage) {
        button.setImage(image, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 0, y: 0, width: self.width - 0.5, height: self.height - 0.5)
    }
    
}

class SubscribeCollectionView: CYCollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var images: Array<String> = Array()
    let eaView: EcptomaAdvertising = EcptomaAdvertising()
    
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width: CYDevice.width() / 3, height: CYDevice.width() / 3)
        layout.headerReferenceSize = CGSize.init(width: CYDevice.width(), height: 42.0 / 75.0 * CYDevice.width())
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        for index in 0..<16 {
            print(index)
            let name: String = "subscribe_\(index)"
            images.append(name)
        }
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = UIColor.white
        self.register(SubCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        self.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
//        RefreshControlArrowBlackNoBottom
        // 
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = SubRefreshHeaderAnimator(frame: CGRect.zero)
        self.es.addPullToRefresh(animator: header) { [weak self] in
            self?.downCover()
        }
    }
    
    func downCover() {
        self.es.stopPullToRefresh()
        
        eaView.show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier: String = "CellIdentifier"
        let cell: SubCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SubCell
        cell.setImage(image: UIImage.init(named: images[indexPath.row])!) 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.backgroundColor = UIColor.random()
            
            return headerView
        } else {
            return UICollectionReusableView()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
