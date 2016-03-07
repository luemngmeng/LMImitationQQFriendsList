//
//  LMCellMultilayerShowOrHideViewController.m
//  LMCellMultilayerShowOrHideDemo
//
//  Created by mengmenglu on 3/4/16.
//  Copyright © 2016 Hangzhou TaiXuan Network Technology Co., Ltd. All rights reserved.
//

#import "LMCellMultilayerShowOrHideViewController.h"

#import "LMTableHeaderView.h"
#import "FriendGroup.h"

@interface LMCellMultilayerShowOrHideViewController ()<LMTableHeaderViewDelegate>{
    BOOL __isExpand;
}

/**
 *  titleArray
 */
@property (nonatomic, strong) NSArray *titleArray;

/**
 *  friednArray
 */
@property (nonatomic, strong) NSArray *friendsArray;

/**
 *  headerViewArray
 */
@property (nonatomic, strong) NSMutableArray *headerViewArray;

/**
 *  默认的cell重用标示符
 */
@property (nonatomic, strong) NSString *defaultCellReuseIdentifier;

/**
 *  TableHeaderView
 */
@property (nonatomic,strong) LMTableHeaderView *headerView;

@end

@implementation LMCellMultilayerShowOrHideViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"多层cell显示和隐藏的Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.headerViewArray = [[NSMutableArray alloc] init];
    self.friendsArray = [[NSMutableArray alloc] init];
    
    
    // 添加UITableView视图
    [self.view addSubview:self.tableView];
    
    
    // 配置UITableView视图
    [self setupTableView];
    
    
    // 刷新数据
    [self refreshTableViewDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

#pragma mark Getter Method
- (UITableView *)tableView {
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return _tableView;
}

#pragma mark 通过nib文件名称注册Cell
- (void)registerCellWithNibName:(NSString *)nibName reuseIdentifier:(NSString *)identifier {
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    
    if (!nib){
        return;
    }
    
    self.defaultCellReuseIdentifier = identifier;
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}

#pragma mark 通过类名注册Cell
- (void)registerCellWithClassName:(NSString *)className reuseIdentifier:(NSString *)identifier {
    Class class = NSClassFromString(className);
    
    if (!class){
        return;
    }
    
    self.defaultCellReuseIdentifier = identifier;
    [self.tableView registerClass:class forCellReuseIdentifier:identifier];
}

#pragma mark scrollView内容移动到顶层
- (void)scrollToTop:(BOOL)animated {
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:animated];
}


#pragma mark scrollView内容移动到底层
- (void)scrollToBottom:(BOOL)animated {
    
    if (self.tableView.contentSize.height < self.tableView.frame.size.height){
         return;
    }
    
    NSUInteger sectionCount = [self.tableView numberOfSections];
    
    if (sectionCount)
    {
        NSUInteger rowCount = [self.tableView numberOfRowsInSection:0];
        
        if (rowCount)
        {
            NSUInteger i[2] = {0, rowCount - 1};
            NSIndexPath * indexPath = [NSIndexPath indexPathWithIndexes:i length:2];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        }
    }
}

#pragma mark - UITableView Delegate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.titleArray.count !=0 ){
        FriendGroup *friendGroup = self.titleArray[section];
        if (friendGroup.isExpand){
            return 0;
        } else {
            NSArray *friendArray = friendGroup.friendArray;
            return friendArray.count;
        }
    }

    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.titleArray.count !=0) {
        return self.titleArray.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSInteger row = [indexPath row];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:self.defaultCellReuseIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.defaultCellReuseIdentifier];
    }

    [cell.textLabel setText:@"测试"];
    
    return cell;
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *headerViewIdenfier = @"header";
    LMTableHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdenfier];
    if (headerView == nil){
        headerView = [[LMTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0f)];
    }
    
    if(section < self.titleArray.count) {
        headerView.delegate = self;
        headerView.tag = section + 10010;
        [headerView setUpViewWith:self.titleArray[section]];
    }
    
    [self.headerViewArray addObject:headerView];
    return headerView;
}

#pragma mark - Public Method
- (void)setupTableView {
    
    self.tableView.sectionFooterHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // 注册cell
    [self registerCellWithClassName:NSStringFromClass([UITableViewCell class]) reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
}

#pragma mark 刷新数据
- (void)refreshTableViewDataSource{
    // 后期需加上服务器返回的数据
    Friend *friend1 = [Friend new];
    friend1.name = @"小明";
    
    Friend *friend2 = [Friend new];
    friend2.name = @"小花";
    
    Friend *friend3 = [Friend new];
    friend3.name = @"小户";
    
    Friend *friend4 = [Friend new];
    friend4.name = @"小美";
    
    self.friendsArray = @[friend1,friend2,friend3,friend4];
    
    
    FriendGroup *friendGroup1 = [[FriendGroup alloc] init];
    friendGroup1.groupName = @"我的好友";
    friendGroup1.isExpand = 1;
    friendGroup1.friendArray = self.friendsArray;
    
    FriendGroup *friendGroup2 = [[FriendGroup alloc] init];
    friendGroup2.groupName = @"同学";
    friendGroup2.isExpand = 1;
    friendGroup2.friendArray = self.friendsArray;
    
    FriendGroup *friendGroup3 = [[FriendGroup alloc] init];
    friendGroup3.groupName = @"朋友";
    friendGroup3.isExpand = 1;
    friendGroup3.friendArray = self.friendsArray;
    
    FriendGroup *friendGroup4 = [[FriendGroup alloc] init];
    friendGroup4.groupName = @"家人";
    friendGroup4.isExpand = 1;
    friendGroup4.friendArray = self.friendsArray;
    
    self.titleArray = @[friendGroup1,friendGroup2,friendGroup3,friendGroup4];
}

#pragma mark LMTableHeaderViewDelaget 
- (void)tableHeaderViewClickWith:(NSInteger)tag {
    
    // 刷新页面
    FriendGroup *friednGroup = self.titleArray[tag - 10010];
    friednGroup.isExpand = !friednGroup.isExpand;
    
    [self.tableView reloadData];
}


@end
