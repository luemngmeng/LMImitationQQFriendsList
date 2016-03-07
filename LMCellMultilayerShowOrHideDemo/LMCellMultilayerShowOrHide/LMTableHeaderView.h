//
//  LMTableHeaderView.h
//  LMCellMultilayerShowOrHideDemo
//
//  Created by mengmenglu on 3/7/16.
//  Copyright © 2016 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//  采用代理的方式进行传值

#import <UIKit/UIKit.h>

#import "FriendGroup.h"

/**
 *  定义头部是视图的点击事件的block
 */
typedef void(^LMTabelHeaderViewTapClickBlock)(void);


/**
 *  定义代理协议
 */
@protocol LMTableHeaderViewDelegate <NSObject>

/**
 *  每个头部视图的点击事件
 */
- (void)tableHeaderViewClickWith:(NSInteger)tag;

@end

@interface LMTableHeaderView : UITableViewHeaderFooterView


/**
 *   定义外部可编辑文字Label
 */
@property (nonatomic,strong) UILabel *titleLabel;


/**
 *   定义外部自定义的图片视图UIImageView
 */
@property (nonatomic,strong) UIImageView *imageView;


/**
 *   点击headerView可伸展和收回的BOOL值
 */
//@property (nonatomic,assign) BOOL isExpanded;

/**
 *  头部是视图的点击事件的block
 */
//@property (nonatomic, strong) LMTabelHeaderViewTapClickBlock TabelHeaderViewTapClickBlock;

/**
 *  根据传入的UITableView初始化
 */
//+ (instancetype)headerViewWithTableView:(UITableView *)tableView ;


/**
 *  定义代理属性
 */
@property (nonatomic, weak) id<LMTableHeaderViewDelegate> delegate;


/**
 *  根据数据model配置界面
 */
- (void)setUpViewWith:(id)model;

@end
