//
//  JDHeader.swift
//  Friend
//
//  Created by 玮 李 on 2017/10/10.
//  Copyright © 2017年 玮 李. All rights reserved.
//

import UIKit
import MJRefresh
class JDHeader: MJRefreshHeader {
    private var gifView1Rect:CGRect = CGRect()
    private var gifView2Rect:CGRect = CGRect()
    private lazy var contentLabel:UILabel = {
        let contentLabel = UILabel()
        contentLabel.text = "让购物更便捷"
        contentLabel.font = UIFont.systemFont(ofSize: 12)
        contentLabel.textColor = .gray
        contentLabel.textAlignment = .left
        return contentLabel
    }()
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "下拉更新"
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    private lazy var gifView1:UIImageView = {
        let gifView1 = UIImageView()
        gifView1.image = UIImage(named: "app_refresh_goods_0")
        return gifView1
    }()
    private lazy var gifView2:UIImageView = {
        let gifView2 = UIImageView()
        var idleImages:[UIImage]? = []
        gifView2.image = UIImage(named: "app_refresh_people_0")
        for i in 1..<4 {
            let image = UIImage(named: "app_refresh_people_\(i)")
            idleImages?.append(image!)
        }
        gifView2.animationImages = idleImages
        gifView2.animationDuration = 0.3
        return gifView2
    }()
    private lazy var gifView3:UIImageView = {
        let gifView3 = UIImageView()
        gifView3.image = UIImage(named: "app_refresh_speed")
        return gifView3
    }()
    
    // MARK:在这里做一些初始化配置（比如添加子控件）
    override func prepare() {
        super.prepare()
        self.mj_h =  85
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(gifView1)
        self.addSubview(gifView2)
        self.addSubview(gifView3)
        
    }
    // MARK:在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        if state == .idle {
            DispatchQueue.once("0") {
                let react = super.frame
                let labelX = (react.size.width - 100)/2 + 25
                let labelY = react.size.height - 60
                self.contentLabel.frame = CGRect(x: labelX, y: labelY, width: 100, height: 20)
                self.titleLabel.frame = CGRect(x: labelX, y: labelY + 20, width: 100, height: 20)
                self.gifView1Rect = CGRect(x: labelX, y: labelY + 20, width: 0, height: 0)
                self.gifView1.frame = self.gifView1Rect
                self.gifView2Rect = CGRect(x: labelX - 100, y: react.size.height, width: 0, height: 0)
                self.gifView2.frame = self.gifView2Rect
                self.gifView3.frame = CGRect(x: labelX - 105, y: labelY + 10, width: 41, height: 33)
            }
            
            
        }
    }
    // MARK:监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
        // print(change)
    }
    // MARK:监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
        //print(change)
    }
    // MARK:监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
        //print(change)
    }
    // MARK:监听控件的刷新状态
    override var state: MJRefreshState{
        willSet {
            let oldState = self.state
            if newValue == oldState {
                return
            }
            super.state = newValue
            switch state {
            case .idle:
                endRefreshingAnimation()
                break
            case .pulling:
                startRefreshAnimation()
                titleLabel.text = "松手更新..."
                break
            case .refreshing:
                startRefreshAnimation()
            default:
                break
            }
        }
    }
    // MARK:监听拖拽比例（控件被拖出来的比例）
    override var pullingPercent: CGFloat{
        willSet {
            super.pullingPercent = newValue
            if newValue > 1.0 {return}
            let progress = newValue
            gifView1.isHidden = false
            gifView3.isHidden = true
            gifView1.frame = CGRect(x: gifView1Rect.origin.x - 36.0*progress,
                                    y: gifView1Rect.origin.y - 5.0*progress,
                                    width: gifView1Rect.size.width + 20.0*progress,
                                    height: gifView1Rect.size.height + 15.0*progress)
            gifView2.frame = CGRect(x: gifView2Rect.origin.x + 30.0*progress,
                                    y: gifView2Rect.origin.y - 78.0*progress,
                                    width: gifView2Rect.size.width + 53.0*progress,
                                    height: gifView2Rect.size.height + 73.0*progress)
            
        }
    }
    //结束刷新
    private func endRefreshingAnimation() {
        titleLabel.text = "下拉更新"
        gifView1.frame = gifView1Rect
        gifView2.frame = gifView2Rect
        gifView2.stopAnimating()
        gifView1.isHidden = false
        gifView3.isHidden = true
        
    }
    //开始刷新
    private func startRefreshAnimation() {
        titleLabel.text = "更新中..."
        gifView1.isHidden = true
        gifView3.isHidden = false
        gifView2.startAnimating()
    }
}
//只执行一次
public extension DispatchQueue {
    private static var onceToken = [String]()
    public class func once(_ token: String, _ block:@escaping () -> Void) {
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        if onceToken.contains(token) {
            return
        }
        onceToken.append(token)
        block()
    }
}
