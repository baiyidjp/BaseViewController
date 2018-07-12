# BaseViewController    
### `一个通用的带导航栏的基础控制器+封装库/类`    

```
--Classes     //模块。包含各个模块的Model,View,Controller,Manager
--categories  //类目。包含各种类的分类 和 继承
--Frameworks  //系统框架。包含导入的系统的框架
--Helpers     //帮助类。包含网络，数据库，归档，定位等操作类的封装和实现
--Utilites    //工具类，一些非对象的，而是类方法调用的类
--Vendors     //第三方库。部分需要修改或者不支持cocoapod的第三方的框架引入
--Config      //配置。包含宏定义文件，全局配置文件，全局常量文件，颜色配置文件
--Resources   //资源。包含plist,image,html,bundle，Localizable.strings等

```
## Classes
```
1. JPTabBarController:包含MainTabBarController和自定义(JPTabBar)
  1.1 JPTabBar:实现UITabBarButton的点击动画,控制中间的不规则UITabBarButton的显示与隐藏

2. JPNavigationView:自定义一套导航栏,取代系统导航栏,完美适配iOS11.
  2.1 JPBaseViewController:基础控制器,所有的控制器都是继承这个.提供自定义导航栏和Item的API.
  2.2 JPNavigationController:自定义导航控制器
  2.3 UIBarButtonItem+JPItem:UIBarButtonItem的分类,可以方便快捷创建一个UIBarButtonItem.
  2.4 JPNavigationBar:自定义的UINavigationBar,适配iOS 11的精髓所在^_^.

3. LiveMessageList:使用YYText框架组建直播聊天的消息界面.

4. Login(MVVM):最简单的MVVM应用demo.

5. MapController:使用协议打开地图的一个demo

6. BigImageListController:使用Runloop优化cell加载大图卡顿的demo.
```
## Vendors

```
1. BaseMapView:加载地图所需的view

2. JPLoopView:轮播图.使用代理/数据源启用
  2.1 UIImageView+JPWebImage:封装一套模仿SDWebImage的图片下载,并加入 UIImage+Extension 自动切圆角,减少列表滑动时离屏渲染!

3. LoadingHUD:一个有意思的loading动画实现(对组动画的一个demo).

4. OCJDRefreshControl:仿京东的下拉刷新OC版本.Swift版本:https://github.com/baiyidjp/SwiftJDRefreshControl)
```
## Categories

```
1. NSObject+runtime:runtime的基本探究.字典转模型

2. UIView+Corner_Radius:使用runtime实现直接在xib中给UIView添加圆角等属性的功能.

3. UIButton+RemoveHighlightEffect:按钮的分类,使用runtime移除按钮的高亮状态.

4. UIImage+Extension:UIImage的分类,可对图片直接进行圆角剪切,增加性能.

5. UIImageView+SDWebImage:对SDImageView的再次封装,使用 UIImage+Extension 实现切圆角.用于列表中,减少离屏渲染,增加性能.
```

![1](https://github.com/baiyidjp/BaseViewController/blob/master/BaseViewController/Resources/Gif/base1.gif)
![2](https://github.com/baiyidjp/BaseViewController/blob/master/BaseViewController/Resources/Gif/base2.gif)
![3](https://github.com/baiyidjp/BaseViewController/blob/master/BaseViewController/Resources/Gif/base23.gif)
