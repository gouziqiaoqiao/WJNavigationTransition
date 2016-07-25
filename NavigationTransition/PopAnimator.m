//
//  PopAnimator.m
//  NavigationTransition
//
//  Created by 王钧 on 16/7/25.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "PopAnimator.h"
#import "ViewController.h"
#import "DetailViewController.h"


@implementation PopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    return 0.5;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    DetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 视图容器
    UIView *containerV = [transitionContext containerView];
    
    //
    [containerV addSubview:toVC.view];
    
    //
    [containerV sendSubviewToBack:toVC.view];
    
    //
    UIView *snapShot = [fromVC.bigImageView snapshotViewAfterScreenUpdates:NO];
    
    [containerV addSubview:snapShot];
    
    snapShot.frame = [containerV convertRect:fromVC.bigImageView.frame fromView:fromVC.view];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //
        snapShot.frame = [containerV convertRect:toVC.cell.itemImageView.frame fromView:toVC.cell];
        fromVC.view.alpha = 0;
        
        
    } completion:^(BOOL finished) {
        toVC.cell.itemImageView.hidden = NO;
        [snapShot removeFromSuperview];
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
    
    
}


@end
