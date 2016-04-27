//
//  ViewController.m
//  WWPicker
//
//  Created by ww on 16/4/27.
//  Copyright © 2016年 ww. All rights reserved.
//

#import "ViewController.h"
#import "YPpickViewController.h"

///获取当前屏幕的高度
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
///获取当前屏幕的宽度
#define kMianScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface ViewController ()
{
    UILabel *_timeLable;
    
}
@end 

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIPickerView";
    self.view.backgroundColor = [UIColor whiteColor];
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,150, 30)];
    _timeLable.text = @"2016-11-11";
    _timeLable.center = CGPointMake(kMianScreenWidth/2, kMainScreenHeight/2-40);
    _timeLable.textAlignment = NSTextAlignmentCenter ;
    _timeLable.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_timeLable];
    
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(0, 0, 120, 40);
    [btn setTitle:@"选择日期" forState:0];
    btn.center = CGPointMake(kMianScreenWidth/2, kMainScreenHeight/2+10);
    [btn setTitleColor:[UIColor whiteColor] forState:0];
    btn.backgroundColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)btnClick{
    //  调用灰常简单，如下所示，点击确定回调选择的日期
    YPpickViewController *ypVC  = [[YPpickViewController alloc]init];
    ypVC.calendarblock = ^(YPpickViewModel *model){
        
        NSLog(@"%@\n",model.year);
        NSLog(@"%@\n",model.moth);
        NSLog(@"%@\n",model.day);
        _timeLable.text = [NSString stringWithFormat:@"%@-%@-%@",model.year,model.moth,model.day];
    };
    
    [ self.navigationController pushViewController:ypVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
