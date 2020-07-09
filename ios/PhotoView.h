//
//  PhotoView.h
//  heyteago
//
//  Created by Chris Zhou on 2020/7/7.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>
#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoViewDelegeate <NSObject>
-(void)singleTap;
@end

@interface PhotoView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UICollectionView *myCollectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,assign)NSInteger selectedIndex;

@property(nonatomic,weak) id<PhotoViewDelegeate> delegate;

@property(nonatomic,weak)RCTBubblingEventBlock onSingleTap;

@end

NS_ASSUME_NONNULL_END
