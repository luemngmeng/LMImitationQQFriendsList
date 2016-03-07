//
//  FriendGroup.h
//  LMCellMultilayerShowOrHideDemo
//
//  Created by mengmenglu on 3/7/16.
//  Copyright © 2016 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Friend.h"

@interface FriendGroup : NSObject

/**
 *  组名
 */
@property (nonatomic,strong) NSString *groupName;


/**
 *  好友信息的Model
 */
@property (nonatomic,strong) NSArray *friendArray;


/**
 *  伸展或者收缩
 */
@property (nonatomic, assign, getter = isExpand) BOOL isExpand;

@end
