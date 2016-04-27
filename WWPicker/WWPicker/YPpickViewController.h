//
//  YPpickViewController.h
//  testUIPickView
//
//  Created by Friend on 16/3/17.
//  Copyright © 2016年 WW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPpickViewModel.h"

//回掉代码块
typedef void (^CalendarBlock)(YPpickViewModel *model);
@interface YPpickViewController : UIViewController
@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, copy) CalendarBlock calendarblock;//回调
@property (nonatomic, strong)YPpickViewModel *model ;
@end
