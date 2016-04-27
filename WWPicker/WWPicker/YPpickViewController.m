//
//  YPpickViewController.m
//  testUIPickView
//
//  Created by Friend on 16/3/17.
//  Copyright © 2016年 WW. All rights reserved.
//

#import "YPpickViewController.h"
///获取当前屏幕的高度
#define kMainScreenHeight ([UIScreen mainScreen].bounds.size.height)
///获取当前屏幕的宽度
#define kMianScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface YPpickViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *_yearArray;
    NSMutableArray *_mothArray;
    NSMutableArray *_dayArray ;
    UIView *_view;
}
@end

@implementation YPpickViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

#pragma mark - dataSource
-(void)initData{
    NSArray *array = [self getsystemtime];
    self.model = [[YPpickViewModel alloc]init];
    self.model.year = array[0];
    self.model.moth = array[1];
    self.model.day = array[2];
    _yearArray = [NSMutableArray array];
    NSString *yearSystem = array[0];
    int yearCount = [yearSystem intValue];
    for (int i = 2000; i<yearCount+1; i++) {
        NSString *year = [NSString stringWithFormat:@"%d",i];
        [_yearArray addObject:year];
    }
    _mothArray = [NSMutableArray array];
    for (int i = 1; i<13; i++) {
        NSString *moth = [NSString stringWithFormat:@"%d",i];
        [_mothArray addObject:moth];
    }
    _dayArray = [NSMutableArray array];
    for (int i = 1; i<32; i++) {
        NSString *day = [NSString stringWithFormat:@"%d",i];
        [_dayArray addObject:day];
    }
}

-(void)initView {
    [self setTitle:@"选择日期"];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 160, kMianScreenWidth, 40)];
    NSArray *array = @[@"年",@"月",@"日"];
    for (int i = 0; i<3; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(((self.view.frame.size.width)/3)*i, 0, kMianScreenWidth/3, 40)];
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:22];
        label.textAlignment = NSTextAlignmentCenter ;
        [self createBorderView:label];
        [_view addSubview:label];
    }
    [self.view addSubview:_view];
    NSArray *array1 = [self getsystemtime];
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, kMianScreenWidth, 162)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    NSString  *yearRow = array1[0];
    int year = [yearRow intValue]-2000;
    
    NSString *mothStr = array1[1];
    int moth = [mothStr intValue];
    
    NSString *dayStr = array1[2];
    int day = [dayStr intValue];
    //  设置默认选中日期
    [self.pickerView selectRow:year inComponent:0 animated:YES];
    [self.pickerView selectRow:(moth-1) inComponent:1 animated:YES];
    [self.pickerView selectRow:(day-1) inComponent:2 animated:YES];
    
    [self.view addSubview:self.pickerView];
    
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(100, 300, 80, 35);
    btn.center = CGPointMake(self.view.bounds.size.width/2, CGRectGetMaxY(self.pickerView.frame)+40);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn setTitle:@"确定" forState:0];
    [btn setBackgroundImage:[UIImage imageNamed:@"but7_off.png"] forState:0];
    [btn setTitleColor:[UIColor blackColor] forState:0];
    //刷新UIPickerView
    [self.pickerView reloadAllComponents];
}

//   选择日期回调
-(void)btnClick{
    
     self.calendarblock (self.model);
    [self.navigationController popViewControllerAnimated:YES];

}


#pragma mark pickerviewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return  _yearArray.count;
    } else if(component==1){
        
        return  _mothArray.count;
    }
       return _dayArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {
        return  self.view.frame.size.width/3;
    } else if(component==1){
        return  self.view.frame.size.width/3;
    }
       return  self.view.frame.size.width/3;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kMianScreenWidth/3, 30)];
    
    text.font = [UIFont systemFontOfSize:20];
    text.textAlignment = NSTextAlignmentCenter;
    if (component==0) {
        text.text = [_yearArray objectAtIndex:row];
    }
    if (component==1) {
        text.text = [_mothArray objectAtIndex:row];
    }
    if (component==2) {
        text.text = [_dayArray objectAtIndex:row];
    }
    [view addSubview:text];
    
    return view;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = @"";
    if (component==0) {
        str = [_yearArray objectAtIndex:row];
    }
    if (component==1) {
        str = [_mothArray objectAtIndex:row];
    }
    if (component==2) {
        str = [_dayArray objectAtIndex:row];
    }
    return str;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str = @"";
    if (component==0) {
        str = [_yearArray objectAtIndex:row];
    }
    if (component==1) {
        str = [_mothArray objectAtIndex:row];
    }
    if (component==2) {
        str = [_dayArray objectAtIndex:row];
    }

    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, [AttributedString  length])];
    
    return AttributedString;
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component==0) {
        self.model.year = [_yearArray objectAtIndex:row];
    }
    
    if (component==1) {
        self.model.moth = [_mothArray objectAtIndex:row];
    }
    if (component==2) {
        self.model.day = [_dayArray objectAtIndex:row];
    }
}
#pragma mark - 创建边框
-(void)createBorderView:(UILabel*)lab{
    
    lab.layer.borderWidth = 0.5;
//    // 设置圆角
    lab.layer.cornerRadius = 4.5;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    // 新建一个红色的ColorRef，用于设置边框（四个数字分别是 r, g, b, alpha）
    CGColorRef borderColorRef = CGColorCreate(colorSpace,(CGFloat[]){ 214.0/255.0, 214.0/255.0, 214.0/255.0, 1 });
    lab.layer.borderColor = borderColorRef;
    lab.backgroundColor = [UIColor whiteColor];
    
}

// 获取系统时间
-(NSArray*)getsystemtime{

    NSDate *date = [NSDate date];
    NSTimeInterval  sec = [date timeIntervalSinceNow];
    NSDate *currentDate = [[NSDate alloc]initWithTimeIntervalSinceNow:sec];
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *na = [df stringFromDate:currentDate];
    return [na componentsSeparatedByString:@"-"];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_yearArray removeAllObjects];
    [_mothArray removeAllObjects];
    [_dayArray removeAllObjects];
    [_pickerView removeFromSuperview];
   
}

@end