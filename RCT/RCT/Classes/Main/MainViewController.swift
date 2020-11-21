//
//  MainViewController.swift
//  SwiftMRK
//
//  Created by Mark on 2020/3/23.
//  Copyright © 2020年 markmarklewis. All rights reserved.
//export PATH=~/Documents/flutte/bin:$PATH
//  AppDelegate导入的第一个页面
import UIKit
class MainViewController: UITabBarController {
    /// 监听加号按钮点击
    @objc private func compseBtnClick(btn: UIButton)
    {
        print()
        let sb = UIStoryboard(name: "ComposeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()!
        vc.modalPresentationStyle = .custom
        present(vc, animated: true) {
            //
        }
    }
    
    
    // MARK: - 懒加载
    private lazy var composeButton: UIButton = {
        () -> UIButton
        in
        /*
         // 1.创建按钮
         let btn = UIButton()
         
         // 2.设置前景图片
         btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
         btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
         // 3.设置背景图片
         btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
         btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
         
         // 4.调整按钮尺寸
         btn.sizeToFit()
         */
        
        //        [[UIButton alloc] init];
        //        UIButton()
        //        [[UIButton alloc] initWithFrame: CGRect()];
        //        UIButton(frame: CGRect())
        
        // 1.创建按钮
        let btn = UIButton(imageName:"tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        
        
        // 2.监听按钮点击        
        btn.addTarget(self, action: #selector(compseBtnClick(btn:)), for: .touchUpInside)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.添加所有子控制器
        addChildViewControllers()
        // iOS7以后只需要设置tintColor, 那么图片和文字都会按照tintColor渲染 242 78 86
        tabBar.tintColor = UIColor.init(red: 255/255.0, green: 119/255.0, blue: 0/255.0, alpha: 1)
        
        
        var car  = "11111";
        
        let closure = {[car] in
            print("i drive \(car)")
        }
        car = "BMW"
        closure()
    }
    
    /**
     添加所有子控制
     */
    private func addChildViewControllers() {
        // 1.获取json文件路径
        let jsonPath = Bundle.main.path(forResource: "MainVCSettings", ofType: "json")
        // 2.加载json数据
        let jsonData = NSData(contentsOfFile: jsonPath!)
        
        /*
         3.序列化json
         throws是XCode7最大的变化, 异常处理机制
         */
        
        guard let dictArray = try? JSONSerialization.jsonObject(with: jsonData! as Data, options: .mutableContainers) else
        {
            addChildViewController(childControllerName: "HomeTableViewController", title: "首页", imageName: "tabbar_home")
            // 失败就本地创建
            addChildViewController(childControllerName: "MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            addChildViewController(childControllerName: "SquareTableViewController", title: "发现", imageName: "tabbar_discover")
            addChildViewController(childControllerName: "ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            return
            // 否则通过服务器中的JSON文件进行创建
        }
        
        // 4.遍历字典时候需要明确指明数组中的数据类型
        for dict in dictArray  as! [[String:String]]
        {
            // 由于addChildVC方法参数不能为nil, 但是字典中取出来的值可能是nil, 所以需要加上!
            // 这里是否还要判断一下dict字典内的每个值是否为空
            addChildViewController(childControllerName: dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
        }
        
    }
    
    /**
     初始化子控制器
     
     :param: childControllerName 需要初始化的子控制器名称
     :param: title           初始化的标题
     :param: imageName       初始化的图片
     */
    func addChildViewController(childControllerName: String, title:String, imageName:String) {
        
        // 0.动态获取命名空间
        let namespace = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
        //print(namespace)
        // 1.拼接命名空间并生成Class
        let cls:AnyClass = NSClassFromString(namespace + "." + childControllerName)!
        
        // 2.告诉编译器真实类型是UIViewController
        let vcCls = cls as! UITableViewController.Type
        
        // 3.实例化控制器
        let childController = vcCls.init()
        
        // 4.从内像外设置, nav和tabbar都有
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        
        // 注意: Xocde7之前只有文字有效果, 还需要设置图片渲染模式
        tabBar.tintColor = UIColor.orange
        
        // 5.创建导航控制器
        let nav = MainNavigationViewController()
        nav.addChildViewController(childController)
        
        // 6.添加控制器到tabbarVC  需要iOS5
        addChildViewController(nav)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.barStyle = UIBarStyle.black
        tabBar.addSubview(composeButton)
        
        // 保存按钮尺寸
        let rect = composeButton.frame
        // 计算宽度
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        // 设置按钮的位置
        composeButton.frame = CGRect(x: 2 * width, y: 0, width: width, height: rect.height)
        //        composeButton.frame = CGRectOffset(rect, 2 * width, 0)
    }

}
