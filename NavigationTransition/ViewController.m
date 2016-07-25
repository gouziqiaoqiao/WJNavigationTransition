//
//  ViewController.m
//  NavigationTransition
//
//  Created by 王钧 on 16/7/25.
//  Copyright © 2016年 王钧. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "DetailViewController.h"
#import "PushAnimator.h"
#import "PopAnimator.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.collectionView reloadData];
    
    // 设置UINavigationController的委托
    self.navigationController.delegate = self;
    
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 15;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    // 图片名称
    NSString *imageName = [NSString stringWithFormat:@"圣斗士%02ld.jpg",indexPath.item + 1];
    cell.itemImageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    // 选中的item
    _cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    detailVC.image = _cell.itemImageView.image;
    
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UINavigationControllerDelegate
// 在navigationController自定义转场动画
// operation Push/Pop
// fromVC 来源视图控制器
// toVC 目标视图控制器
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return [[PushAnimator alloc] init];
    }
    else if (operation == UINavigationControllerOperationPop) {
        return [[PopAnimator alloc] init];
    }
    else
        return nil;
}

@end
