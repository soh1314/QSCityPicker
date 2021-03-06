//
//  BJCityPickerView.m
//  BJCityPicker
//
//  Created by zbj-mac on 16/4/8.
//  Copyright © 2016年 zbj. All rights reserved.
//

#import "QSCityPickerView.h"
@interface QSCityPickerView()
@property(nonatomic,strong)QSCityPicker*cityPicker;
/**
 *  选中回调
 */
@property(nonatomic,copy)citySelected citySelected;
@end
@implementation QSCityPickerView
-(QSCityPicker *)cityPicker{
    if (!_cityPicker) {
        _cityPicker=[QSCityPicker cityPicker];
        WS(ws);
        [_cityPicker cityPickerDidSelected:^(NSString *province, NSString *city, NSString *local) {
            !ws.citySelected?:ws.citySelected(province,city,local);
              [ws hidden];
        }];
    }
    return _cityPicker;
}
+(QSCityPickerView*)shareCityPickerView{
    static QSCityPickerView* instance;
    if (!instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[QSCityPickerView alloc] init];
        });
    }
    return instance;
}
+(instancetype)cityPickerView{
    return [[self alloc] init];
}
-(instancetype)init{
    if (self=[super init]) {
        [self addSubview:self.cityPicker];
    }
    return self;
}
-(void)cityPicekrViewDidSelected:(citySelected)citySelected{
    self.citySelected=citySelected;
}
-(void)show{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.frame=self.superview.bounds;
    [UIView animateWithDuration:0.25f animations:^{
        self.cityPicker.frame=CGRectMake(0, KDeviceHeight-226, KDeviceWidth, 226);
    }];
}
-(void)hidden{
    [UIView animateWithDuration:0.25f animations:^{
        self.cityPicker.frame=CGRectMake(0, KDeviceHeight,KDeviceWidth, 226);
    } completion:^(BOOL finished) {
        //更新数据
        [self.cityPicker reloadCityData];
        [self removeFromSuperview];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidden];
}

@end
