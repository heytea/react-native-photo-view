//
//  PhotoView.m
//  heyteago
//
//  Created by Chris Zhou on 2020/7/7.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "PhotoView.h"
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

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

-(UICollectionView *)myCollectionView{
  if (_myCollectionView == nil) {

    _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44) collectionViewLayout:self.layout];
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

- (void)setData:(NSArray *)data{
  _data = data;
  _label.text = [NSString stringWithFormat:@"%ld / %lu",(long)self.selectedIndex+1 ,(unsigned long)data.count];
}

- (NSArray *)data{
    return _data;
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
  self.label.frame = CGRectMake(0, 0, self.frame.size.width, 44);
  self.layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height-44);
  self.myCollectionView.frame = CGRectMake(0, 44, self.frame.size.width, self.frame.size.height-44);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  NSInteger page =  scrollView.contentOffset.x / self.frame.size.width;
  self.label.text = [NSString  stringWithFormat:@"%ld / %ld",page+1 ,self.data.count];
}




@end
