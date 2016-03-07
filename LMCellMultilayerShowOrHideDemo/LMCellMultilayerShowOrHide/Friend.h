//
//  Friend.h
//  LMCellMultilayerShowOrHideDemo
//
//  Created by mengmenglu on 3/7/16.
//  Copyright © 2016 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

/**
 *  头像图片名称
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  简介
 */
@property (nonatomic, copy) NSString *intro;

/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  是否是VIP
 */
@property (nonatomic, assign, getter = isVip) BOOL vip;

@end
