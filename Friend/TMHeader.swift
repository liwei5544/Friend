
//
//  TMHeader.swift
//  Friend
//
//  Created by 玮 李 on 2017/10/10.
//  Copyright © 2017年 玮 李. All rights reserved.
//

import UIKit
import MJRefresh
class TMHeader: MJRefreshHeader {
    private lazy var tmallGifView:UIImageView = {
        let tmallGifView = UIImageView()
        return tmallGifView
    }()
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "下拉更新"
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    // MARK:在这里做一些初始化配置（比如添加子控件）
    override func prepare() {
        super.prepare()
        self.mj_h =  85
        self.addSubview(titleLabel)
        self.addSubview(tmallGifView)
       
        
    }
    // MARK:在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
        if state == .idle {
           
                let react = super.frame
                
                self.titleLabel.frame = CGRect(x: 0, y: react.size.height - 25, width: react.size.width, height: 20)
                self.tmallGifView.frame = CGRect(x: 0, y: react.size.height - 85, width: react.size.width, height: 80)
              
               
            
            
            
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
                titleLabel.text = "松手立即刷新..."
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
           
        }
    }
    //结束刷新
    private func endRefreshingAnimation() {
        titleLabel.text = "下拉更新"
        tmallGifView.image = UIImage.gif(name: "frontpage_refresh@2x")
        
    }
    //开始刷新
    private func startRefreshAnimation() {
        titleLabel.text = "正在刷新"
        
        tmallGifView.image = UIImage.gif(name: "frontpage_refresh_release@2x")
       
    }
}
