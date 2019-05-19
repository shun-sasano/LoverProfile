//
//  HeaderView.swift
//  LoverProfile
//
//  Created by 笹野駿 on 2019/05/02.
//  Copyright © 2019 笹野駿. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    

     override func draw(_ rect: CGRect) {
        if imageView?.image == nil || imageView?.image == UIImage() {
            noImageLabel?.isHidden = false
        } else {
            noImageLabel?.isHidden = true
        }
     }
    
    var wrapperView: UIView?
    var imageView: UIImageView?
    var noImageLabel: UILabel?
    
    var wrapperHeightConstraint: Constraint?
    var imageViewHeightConstraint: Constraint?
    var imageViewBottomConstraint: Constraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        let wrapperView = UIView()
        self.wrapperView = wrapperView
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrapperView)
        wrapperView.snp.makeConstraints{ (make) in
            make.left.right.bottom.equalToSuperview()
            wrapperHeightConstraint = make.height.equalToSuperview().constraint
        }
        
        
        let imageView = UIImageView()
        self.imageView = imageView
        
        // SnapKitは勝手にtranslatesAutoresizingMasIntoConstraintsをfalseにしてくれているのでいらない(と思うし、なくても動く)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.ex.mainPink
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        wrapperView.addSubview(imageView)
        addSubview(imageView)
        wrapperView.sendSubviewToBack(imageView)
        sendSubviewToBack(imageView)
        imageView.snp.makeConstraints{ (make) in
            make.left.right.equalToSuperview()
            imageViewHeightConstraint = make.height.equalToSuperview().constraint
            imageViewBottomConstraint = make.bottom.equalToSuperview().constraint
        }
        
        let noImageLabel = UILabel()
        self.noImageLabel = noImageLabel
        noImageLabel.text = "背景が設定されていません"
        noImageLabel.textColor = UIColor.ex.labelGrey
        noImageLabel.font = UIFont.boldSystemFont(ofSize: 18)
        noImageLabel.sizeToFit()
        wrapperView.addSubview(noImageLabel)
        addSubview(noImageLabel)
        wrapperView.bringSubviewToFront(noImageLabel)
        bringSubviewToFront(noImageLabel)
        noImageLabel.snp.makeConstraints{ (make) in
            make.center.equalToSuperview()
            make.size.equalTo(noImageLabel.frame.size)
        }
        
        
    }
    
    func setParallaxEffectToHeaderView(_ scrollView: UIScrollView) {
        
        //スクロールビューの上方向の余白の変化量をwrappedViewの高さに加算する
        //参考：http://blogios.stack3.net/archives/1663
        // ここもなくても動く。scrollView.contentInset.topが０なのでいらない
        //        wrapperHeightConstraint?.update(offset: scrollView.contentInset.top)
        
        //Y軸方向オフセット値を算出する
        let offsetY = -(scrollView.contentOffset.y)
        
        //Y軸方向オフセット値に応じた値をそれぞれの制約に加算する
        // 必要性がわからない。（なくても動く）
        wrapperView?.clipsToBounds = false
        
        // ここのimageViewのBottomConstraintはいらない。（なくても動く）
        //        imageViewBottomConstraint?.update(offset: (offsetY >= 0) ? CGFloat(0) : -offsetY / 2)
        
        // maxの記述を消して,offsetY + scrollView.contentInset.topだけだと、下にスクロールすると画像が小さくなってしまう。
        imageViewHeightConstraint?.update(offset: max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top))
    }
    
}
