//
//  LMTableHeaderView.m
//  LMCellMultilayerShowOrHideDemo
//
//  Created by mengmenglu on 3/7/16.
//  Copyright © 2016 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define THEFEFF4  UIColorFromRGB(0xefeff4)

#import "LMTableHeaderView.h"

@interface LMTableHeaderView (){
    BOOL __isExpand;
}

/**
 *   定义背景视图BgView
 */
@property (nonatomic,strong) UIView *bgView;

@end

@implementation LMTableHeaderView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self addCustomSubView];
    }
    
    return self;
}

#pragma mark 添加可自定义的显示视图
- (void)addCustomSubView {
        
    _bgView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:_bgView];
    
    // 添加文本视图
    [self addTitleLabel];
    
    
    // 添加图片视图
    [self addImageView];
    
    
    // 添加底部的横线
    [self addLineLabel];
    
    
    // 添加点击手势
    UITapGestureRecognizer *tapReconginzer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableHeaderViewTapClick:)];
    [self addGestureRecognizer:tapReconginzer];
}


#pragma mark - Private Method
#pragma mark 外部可编辑的文本视图
- (void)addTitleLabel {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width, 25)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.text = @"测试";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLabel];
}


#pragma mark 外部可编辑的文本视图
- (void)addImageView {

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 -20, 20, 8, 5)];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = [UIImage imageNamed:@"expandableImage@2x.png"];
    [self addSubview:_imageView];
}


#pragma mark 添加底部横线
- (void)addLineLabel {

    UILabel *linebale = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    linebale.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    [self addSubview:linebale];
}



#pragma mark - Public Method
#pragma mark 点击手势的点击事件
- (void)tableHeaderViewTapClick:(UITapGestureRecognizer *)tap {

    // 添加点击效果
    __weak __typeof(self) weakSelf = self;
    _bgView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    
    [UIView animateWithDuration:0.08 animations:^{
        weakSelf.bgView.backgroundColor = [THEFEFF4 colorWithAlphaComponent:1.0];
    } completion:^(BOOL finished) {
        
        //显示多层cell或者隐藏
        if ([weakSelf.delegate respondsToSelector:@selector(tableHeaderViewClickWith:)]){
            [weakSelf.delegate tableHeaderViewClickWith:self.tag];
        }
    }];
    
}


#pragma mark 根据数据model配置界面
- (void)setUpViewWith:(id)model{
    
    if ([model isKindOfClass:[FriendGroup class]]){
        FriendGroup *friednGroup = (FriendGroup *)model;
        
        if (friednGroup.groupName.length !=0){
            _titleLabel.text = friednGroup.groupName;
        }
        
        _imageView.transform = friednGroup.isExpand ? CGAffineTransformMakeRotation(0) : CGAffineTransformMakeRotation(M_PI);
    }
}
@end
