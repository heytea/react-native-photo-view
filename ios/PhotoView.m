//
//  PhotoView.m
//  heyteago
//
//  Created by Chris Zhou on 2020/7/7.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "PhotoView.h"
#import "Constants.h"
#import "PhotoCell.h"

static NSString *const cellID = @"PhotoView";

@interface PhotoView()

@end


@implementation PhotoView

@synthesize data = _data;
@synthesize selectedIndex = _selectedIndex;

-(instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    [self setupSubviews];
    self.selectedIndex = 0;
  }
  return self;
}

/**
 setter
 */

-(UILabel *)label{
  if (!_label) {
    _label = [[UILabel alloc] init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:16];
    _label.text = [NSString stringWithFormat:@"%ld / %lu",(long)self.selectedIndex+1 ,(unsigned long)self.data.count];
    _label.textColor = [UIColor whiteColor];
  }
  return _label;
}

-(UICollectionView *)myCollectionView{
  if (_myCollectionView == nil) {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(MScreenWidth, MScreenHeight-64);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MScreenWidth, MScreenHeight-64) collectionViewLayout:layout];
    [_myCollectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:cellID];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.pagingEnabled = YES;
  }
  return _myCollectionView;
}


/**
 getter
 */

- (void)setData:(NSMutableArray *)data{
  _data = data;
}


-(void)setSelectedIndex:(NSInteger)selectedIndex{
  _selectedIndex = selectedIndex;
}

- (NSInteger)selectedIndex{
  return  _selectedIndex;
}



-(void)setupSubviews{
  [self addSubview:self.label];
  [self addSubview:self.myCollectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return self.data.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
  cell.tabBlock = ^{
    if ([self.delegate respondsToSelector:@selector(singleTap)]) {
      [self.delegate singleTap];
    }
  };
  cell.imageUrl = self.data[indexPath.row];
  return cell;
}


-(void)layoutSubviews{
  [super layoutSubviews];
  self.backgroundColor= [UIColor blackColor];
  self.label.frame = CGRectMake(0, 20, MScreenWidth, 44);
  self.myCollectionView.frame = CGRectMake(0, 64, MScreenWidth, MScreenHeight-60);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  NSInteger page =  scrollView.contentOffset.x / MScreenWidth;
  self.label.text = [NSString  stringWithFormat:@"%ld / %ld",page+1 ,self.data.count];
}




@end
