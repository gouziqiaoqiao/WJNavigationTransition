//
//  PushAnimator.m
//  NavigationTransition
//
//  Created by 王钧 on 16/7/25.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "PushAnimator.h"
#import "ViewController.h"
#import "DetailViewController.h"

@implementation PushAnimator


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取来源视图控制器
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 获取目标视图控制器
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 容器视图
    UIView *containerView = [transitionContext containerView];
    
    // 将目标视图添加到容器视图中
    [containerView addSubview:toVC.view];
    
    // 交换层次,移到最后
    [containerView sendSubviewToBack:toVC.view];
    
    // 截取单元格上的图片,避免对cell的操作
    UIView *snapShot = [fromVC.cell.itemImageView snapshotViewAfterScreenUpdates:NO];
    
    [containerView addSubview:snapShot];
    
    // 获取最终效果
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat imageW = screenSize.width;
    CGFloat imageH = imageW * 3 / 2;
    CGFloat imageX = 0;
    CGFloat imageY = (screenSize.height - imageH) / 2;
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    
        snapShot.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
    } completion:^(BOOL finished) {
        // 隐藏图片
        fromVC.cell.itemImageView.hidden = YES;
        [snapShot removeFromSuperview];
        toVC.image = fromVC.cell.itemImageView.image;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
