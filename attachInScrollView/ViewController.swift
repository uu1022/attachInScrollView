//
//  ViewController.swift
//  attachInScrollView
//
//  Created by 张聪 on 2020/7/6.
//  Copyright © 2020 Touch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let count = 10
    let scrollView = UIScrollView()
    var label : UILabel?
    var subView : UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }else{
            automaticallyAdjustsScrollViewInsets = false
        }
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        let vh: CGFloat = 200.0
        
        scrollView.frame = .init(x: 0, y: 0, width: width, height: height)
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        for i in 0..<count {
            let v1 = UIView(frame: .init(x: 0, y: CGFloat(i) * vh, width: width, height: vh))
            v1.backgroundColor = randcomColor()
            scrollView.addSubview(v1)
            
            //添加label
            if i==4 {
                subView = v1
                let label = UILabel(frame: v1.bounds)
                label.textAlignment = .center
                label.font = .systemFont(ofSize: 18)
                label.text = "tommy"
                label.backgroundColor = randcomColor()
                self.label = label
                v1.addSubview(label)
            }
            
        }
        scrollView.contentSize = CGSize(width: width, height: CGFloat(count)*vh)
        //将self.label移至最上层
        scrollView .bringSubviewToFront(self.label!)
    }
    func randcomColor() -> UIColor {
        let red = arc4random()%255
        let blue = arc4random()%255
        let green = arc4random()%255
        let color = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
        return color;
    }
    func mj_statusBarHeight() -> CGFloat {
//        if #available(iOS 13.0, *) {
//            return self.view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
//        } else {
//            return UIApplication.shared.statusBarFrame.height
//        }
        return UIApplication.shared.statusBarFrame.height

    }
}
extension ViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let v1 = subView!
        let transPoint = scrollView.convert(v1.frame.origin, to: view)
        let y = transPoint.y
        
        if y < 0 {
            label?.frame.origin = .init(x: 0, y: 0)
            view.addSubview(self.label!)
        }else{
            
//            let scroll_point = view.convert(CGPoint.zero, to: scrollView)
            label?.frame.origin = .init(x: 0, y: 0)
            v1.addSubview(self.label!)
        }
    }
}
