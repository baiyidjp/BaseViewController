# BaseViewController   
### 总结开发中封装的类和demo   

1. ##### MainTabBarController->tabBar控制器->包括中间的不规则按钮/点击tabbar按钮弹跳效果   
##### 2.BaseNavigationController->导航控制器->自定义左右Item     
##### 3.BaseViewController->Base控制器->自定义导航条实现全屏统一返回/加入BaseTableView默认加入自定义的上拉下拉刷新控件   
##### 4.OCJDRefreshControl-模仿京东的下拉刷新控件OC版[ Swift版](https://github.com/baiyidjp/SwiftJDRefreshControl)    
##### 5.JPLoopView->无限轮播图->不需要依赖第三方/使用系统的下载API   
##### 6.LoadingHUD->一个模仿UC浏览器的loading控件   
##### 7.Extensions->分类文件夹   
- ###### 7.1 MidLineLabel->在Label中间划线适用于价格打折     
- ###### 7.2 NSObject+runtime->Runtime字典转模型-比较简陋   
- ###### 7.3 UIView+Corner_Radius->使用Runtime为XIB中View添加可以设置圆角属性   
- ###### 7.4 UIViewController+NSLogAppear->使用Runtime监控控制器的弹出   
- ###### 7.5 UIButton+RemoveHighlightEffect->一句代码移除UIButton的高亮效果   
- ###### 7.6 UIColor+JP_Color->使用十六进制设置颜色   
- ###### 7.7 UIView+BlockGesture->使用block回掉UIView的手势   
- ###### 7.8 UIView+JP_Frame->重写UIView的frame的get/set方法 方便直接赋值或者调用   
- ###### 7.9 UIImage+Extension->图片切圆角,防止滚动离屏渲染   
- ###### 7.10 UIImageView+SDWebImage->封装SDWebImage 加入自动切圆角   
- ###### 7.11 UIImageView+JPWebImage->封装系统API,模仿SDWebimage下载图片 并加入切圆角   
- ###### 7.12 UIBarButtonItem+Extension->自定义Item   
