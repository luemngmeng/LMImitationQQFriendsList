//
//  LMCellMultilayerShowOrHideViewController.h
//  LMCellMultilayerShowOrHideDemo
//
//  Created by mengmenglu on 3/4/16.
//  Copyright © 2016 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMCellMultilayerShowOrHideViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

/**
 *   定义外部可编辑的UITableView
 */
@property (nonatomic,strong) UITableView *tableView;

@end
