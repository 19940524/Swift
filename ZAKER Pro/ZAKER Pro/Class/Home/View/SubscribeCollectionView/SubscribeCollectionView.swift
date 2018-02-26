//
//  SubscribeCollectionView.swift
//  ZAKER Pro
//
//  Created by 薛国宾 on 2018/2/15.
//  Copyright © 2018年 GuoBin. All rights reserved.
//

import UIKit
import ESPullToRefresh
import FSPagerView

class SubCell: CYCollectionViewCell {
    
    private let button: UIButton = UIButton(type: UIButtonType.custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.RGB(r: 230, g: 230, b: 230)
        self.contentView.addSubview(button)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() {
        CYHandler.GETData(url: "http://img.mp.itc.cn/upload/20170518/124d595d0e594a3ebeb91573ec99f64f.gif", params: nil, success: { (s) in
            print(s)
        }) { (f) in
            print(f)
        }
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

class SubHeaderView: UICollectionReusableView,FSPagerViewDelegate, FSPagerViewDataSource {
    
    fileprivate let imageNames = ["http://i2.hdslb.com/bfs/archive/6cc7e02ca5d2f0ff98726d5c68fc731eb08d6eb8.jpg",
                                  "http://img.mp.itc.cn/upload/20170518/124d595d0e594a3ebeb91573ec99f64f.gif",
                                  "http://i0.hdslb.com/video/4d/4df3c619387ba724e0c0de469da0f6f5.jpg",
                                  "http://img.mp.itc.cn/upload/20170518/b3cad2b8be5340f59d22d7fb87f5f370.jpg",
                                  "http://g.hiphotos.baidu.com/image/pic/item/8644ebf81a4c510f5fd56ac76a59252dd52aa5de.jpg",
                                  "http://i2.hdslb.com/video/c3/c3edb15a8daa6535063e709286258c68.jpg"]
    let pagerView: FSPagerView = FSPagerView()

    lazy var pageControl: FSPageControl = {
        let control: FSPageControl = FSPageControl()
        control.numberOfPages = self.imageNames.count
        control.contentHorizontalAlignment = .center
        control.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        control.hidesForSinglePage = true
        return control
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        self.pagerView.isInfinite = true
        self.pagerView.automaticSlidingInterval = 3.0
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.addSubview(self.pagerView)
        
        self.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.bottom.right.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK:- FSPagerViewDataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        cell.imageView?.af_setImage(withURL: URL(string: self.imageNames[index])!)
        
        cell.imageView?.contentMode = .scaleAspectFill
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
    
    // MARK:- FSPagerViewDelegate
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.pagerView.frame = self.bounds
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
        self.register(SubHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        var header: ESRefreshProtocol & ESRefreshAnimatorProtocol
        header = SubRefreshHeaderAnimator(frame: CGRect.zero)
        self.es.addPullToRefresh(animator: header) { [weak self] in
            self?.downCover()
        }
        
        
    }
    
    /// 坠下封面
    func downCover() {
        self.es.stopPullToRefresh()
        
        eaView.show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewDataSource
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
            let headerView: SubHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SubHeaderView
            
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
