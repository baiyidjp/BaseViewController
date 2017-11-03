//
//  SecondViewController.m
//  BaseViewController
//
//  Created by Keep丶Dream on 17/1/4.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "SecondViewController.h"
#import "UIImage+Extension.h"
#import "UIImageView+JPWebImage.h"
#import "BaseTableTextController.h"

@interface SecondViewController ()<CAAnimationDelegate>
/** l */
@property(nonatomic,strong) CALayer *heartLayer;
/** nsmu */
@property(nonatomic,strong) NSMutableArray *layerArrM;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *L = [[UILabel alloc] initWithFrame:CGRectMake(50, NAVIGATION_BAR_HEIGHT+10, 300, 20)];
    L.text = @"UIImageView+JPWebImage";
    [self.view addSubview:L];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, NAVIGATION_BAR_HEIGHT+40, 200, 100)];
    [self.view addSubview:imageView];
    UIImage *image = [UIImage imageNamed:@"曼巴谢幕"];
    [imageView jp_setImageWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/pic/item/e4210760fc19c67cb9998f60.jpg"] placeholderImage:image];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(50, NAVIGATION_BAR_HEIGHT+200, 100, 100)];
    [self.view addSubview:imageView1];
    [imageView1 jp_setCornerImageWithURL:[NSURL URLWithString:@"http://image.bitauto.com/dealer/news/100074966/2a6cf934-f0c4-46b2-940e-c7cced949b4e.jpg"] placeholderImage:image];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, NAVIGATION_BAR_HEIGHT+340, 150, 100)];
    [self.view addSubview:imageView2];
    [imageView2 jp_setImageWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0e7551694ded2e73fcbc8e28b2318dbd/4610b912c8fcc3cefbf277de9545d688d43f2028.jpg"] placeholderImage:image cornerRadius:10];
    
    [self setLoveBtn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" fontSize:16 target:self action:@selector(clickBtn) isBack:NO];
    self.baseNavigationItem.rightBarButtonItem = rightItem;
   
}

#pragma mark -点赞
- (void)setLoveBtn {
    
    UIButton *loveBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-100, self.view.bounds.size.height-50-TAB_BAR_HEIGHT, 60, 30)];
    [loveBtn setTitle:@"点赞" forState:UIControlStateNormal];
    [loveBtn addTarget:self action:@selector(loveClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loveBtn];
}

#pragma mark -love
- (void)loveClick {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSString *imageName = [NSString stringWithFormat:@"D_fei_%d",arc4random_uniform(3)+1];
    imageView.image = [UIImage imageNamed:imageName];
    CALayer *heartLayer = imageView.layer;
    heartLayer.bounds = CGRectMake(0, 0, 30, 30);
    heartLayer.position = CGPointMake(self.view.bounds.size.width-20, self.view.bounds.size.height-20);
    [self.view.layer addSublayer:heartLayer];
    [self.layerArrM addObject:heartLayer];
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    baseAnimation.fromValue = @1;
    baseAnimation.toValue = @0;
    baseAnimation.autoreverses = YES;
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat baseY = self.view.bounds.size.height-50-49;
    CGFloat y = baseY;
    CGFloat x = self.view.bounds.size.width-20;
    while (y > self.view.bounds.size.height*0.5) {
        x = arc4random_uniform(20) + self.view.bounds.size.width - 40;
        if (y == baseY) {
            [path moveToPoint:CGPointMake(x, y)];
        } else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
        y -= 20;
    }
    keyAnimation.path = path.CGPath;
    keyAnimation.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[baseAnimation,keyAnimation];
    group.duration = 6;
    group.delegate = self;
    [heartLayer addAnimation:group forKey:nil];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        NSLog(@"结束");
        CALayer *layer = self.layerArrM[0];
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
        [self.layerArrM removeObjectAtIndex:0];
    }
}

- (NSMutableArray *)layerArrM{
    
    if (!_layerArrM) {
        
        _layerArrM = [NSMutableArray array];
    }
    return _layerArrM;
}

- (void)clickBtn {
    
    [self.navigationController pushViewController:[[BaseTableTextController alloc] init] animated:YES];
}

@end
