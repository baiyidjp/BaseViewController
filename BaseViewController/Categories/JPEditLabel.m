//
//  JPEditLabel.m
//  BaseViewController
//
//  Created by Keep丶Dream on 2017/11/29.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPEditLabel.h"

@implementation JPEditLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self attachTapHandler];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    return (action == @selector(copy:)||action == @selector(paste:)||action == @selector(selectAll:));
}

-(void)copy:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

- (void)paste:(id)sender {
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

-(void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    touch.numberOfTapsRequired = 2;
    [self addGestureRecognizer:touch];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    longPress.minimumPressDuration = 2;
    [self addGestureRecognizer:longPress];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (self.isFirstResponder) {
        [menu setMenuVisible:NO animated:YES];
        [self resignFirstResponder];
    }else {
        [self becomeFirstResponder];
        [menu setTargetRect:self.frame inView:self.superview];
        menu.arrowDirection = UIMenuControllerArrowDown;
        [menu setMenuVisible:YES animated:YES];
    }
}

@end
