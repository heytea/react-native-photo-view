//
//  PhotoCellCollectionViewCell.h
//  heyteago
//
//  Created by Chris Zhou on 2020/7/8.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCell: UICollectionViewCell

@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)void(^tabBlock)(void);

@end

NS_ASSUME_NONNULL_END
