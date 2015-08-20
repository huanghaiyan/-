//
//  ViewController.m
//  滚动试图时隐藏底部导航栏
//
//  Created by lanbalanma on 15/8/20.
//  Copyright (c) 2015年 haiyan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    int _lastPosition;
}
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.tabBarController.tabBar.hidden = YES;
    [self addTableView];

}

-(void)addTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"hahah";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"开始滚动");
    int currentPostion = scrollView.contentOffset.y;
    
    if (currentPostion - _lastPosition > 20  && currentPostion > 0) {        //这个地方加上 currentPostion > 0 即可）
        
        _lastPosition = currentPostion;
        
        NSLog(@"ScrollUp now");
        
        self.tabBarController.tabBar.hidden = YES;
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    
    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) ) //这个地方加上后边那个即可，也不知道为什么，再减20才行
        
    {
        
        _lastPosition = currentPostion;
        
        NSLog(@"ScrollDown now");
        
        self.tabBarController.tabBar.hidden = NO;//隐藏时，没有动画效果
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
    

}
#pragma mark- 动画隐藏tabBar,navigationBar
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"开始滚动");
//    int currentPostion = scrollView.contentOffset.y;
//    
//    if (currentPostion - _lastPosition > 20  && currentPostion > 0) {        //这个地方加上 currentPostion > 0 即可）
//        
//        _lastPosition = currentPostion;
//        
//        NSLog(@"ScrollUp now");
//        
//        [UIView animateWithDuration:1 animations:^{
//            self.tabBarController.tabBar.hidden = YES;
//            
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//        }];
//        
//    }
//    
//    else if ((_lastPosition - currentPostion > 20) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-20) ) //这个地方加上后边那个即可，也不知道为什么，再减20才行
//        
//    {
//        
//        _lastPosition = currentPostion;
//        
//        NSLog(@"ScrollDown now");
//        
//        [UIView animateWithDuration:1 animations:^{
//            self.tabBarController.tabBar.hidden = NO;
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//        }];
//        
//    }
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
