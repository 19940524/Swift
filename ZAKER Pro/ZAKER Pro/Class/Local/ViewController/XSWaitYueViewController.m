//
//  XSWaitYueViewController.m
//  Diandian
//
//  Created by 红鹊豆 on 2018/1/27.
//  Copyright © 2018年 guobin. All rights reserved.
//

#import "XSWaitYueViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YSCRippleView.h"
#import "XSConfiguration.h"

#import "XSYingYueView.h"
#import "XSYingYueModel.h"
#import "XSYYRDetailsController.h"
#import "XSMeYueListViewController.h"

@interface XSWaitYueViewController () <MKMapViewDelegate> {
    BOOL _isCanQ;
    NSInteger _number_of;
}

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *revocationButton;

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) YSCRippleView *rippleView;
@property (nonatomic, strong) XSYingYueView *yingYueView;

@property (nonatomic, strong) NSMutableArray *yingYueList;

@property (nonatomic, assign) BOOL showYYTableView;

@end

@implementation XSWaitYueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
}

- (void)initialize {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeToOrderList) name:WAIT_YUE_COMPLETE object:nil];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setImage:[UIImage imageNamed:@"y_tzyf_fh"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(wyBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(STATUSBAR_HEIGHT);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(50);
    }];
    
    _revocationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _revocationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_revocationButton setTitle:@"撤销" forState:UIControlStateNormal];
    _revocationButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _revocationButton.layer.cornerRadius = 15;
    [_revocationButton addTarget:self action:@selector(revocationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_revocationButton];
    [_revocationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.equalTo(_backButton);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(60);
    }];
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.rippleView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.yingYueList.count == 0) {
            [_rippleView showWithRippleType:YSCRippleTypeCircle];
        }
    });
    
    [self yingYueView];
}

- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.mapType = MKMapTypeStandard;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        //CLLocationCoordinate2DMake：参数： 维度、经度、南北方宽度（km）、东西方宽度（km）
        NSArray *coor = [UserManage.coordinate componentsSeparatedByString:@","];
        if (coor.count == 2) {
            double lat = [coor[0] doubleValue];
            double lon = [coor[1] doubleValue];
            _mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lon), MKCoordinateSpanMake(0.1, 0.1));
            
        }
    }
    return _mapView;
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    NSLog(@"regionWillChangeAnimated");
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"regionDidChangeAnimated");
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    NSLog(@"mapViewWillStartLoadingMap");
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    NSLog(@"mapViewDidFinishLoadingMap");
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    NSLog(@"mapViewDidFailLoadingMap");
}

- (void)wyBackAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:YU_BACK_ACTION object:nil];
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
//
//    MKPinAnnotationView *aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKPinAnnotationView"];
//    aView.canShowCallout = YES;
//    aView.animatesDrop = YES;
//    UIImage *image = [UIImage imageNamed:@"mapCallout"];
//    CGFloat top = image.size.height/2.0;
//    CGFloat left = image.size.width/2.0;
//    CGFloat bottom = image.size.height/2.0;
//    CGFloat right = image.size.width/2.0;
//    [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
//    aView.frame = CGRectMake(0, 0, 100, 40);
//    return aView;
//}

#pragma mark - 撤销
- (void)revocationAction {
    WS(wSelf);
    UIAlertController *alert = [UIAlertController AlertWithTitle:@"亲!您确定撤销约会吗?"
                                                         message:@"撤销后赏金将全额返回到你的看吧账号上!"
                                                     cancelTitle:@"取消"
                                                destructiveTitle:nil
                                                 completionBlock:^(UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                     if (buttonIndex == 1) {
                                                         [MBProgressHUD showActivityMessageInView:@""];
                                                         NSMutableDictionary *params = [NSMutableDictionary dictionary];
                                                         [params setValue:self.yue_id forKey:@"yue_id"];
                                                         
                                                         [CYXSHelper cancelFaYue:params success:^(id obj) {
                                                             [MBProgressHUD hideHUD];
                                                             [wSelf wyBackAction];
                                                         } failure:^(id obj) {
                                                             [MBProgressHUD hideHUD];
                                                         }];
                                                     }
                                                 } otherTitles:@"确定", nil];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

- (YSCRippleView *)rippleView {
    if (!_rippleView) {
        _rippleView = [[YSCRippleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _rippleView.center = CGPointMake(self.view.centerX, self.view.centerY-self.view.centerY*0.3);
        _rippleView.refe_shu = self.refe_shu;
    }
    
    return _rippleView;
}

- (XSYingYueView *)yingYueView {
    if (!_yingYueView) {
        _yingYueView = [[XSYingYueView alloc] init];
        _yingYueView.yue_id = self.yue_id;
        [self.view addSubview:_yingYueView];
    }
    return _yingYueView;
}

- (void)setYingYueList:(NSMutableArray *)yingYueList {
    _yingYueList = yingYueList;
    
    self.showYYTableView = yingYueList.count ? YES : NO;
}

- (void)setShowYYTableView:(BOOL)showYYTableView {
    _showYYTableView = showYYTableView;
    
    _yingYueView.dataList = self.yingYueList;
    
    if (showYYTableView) {
        [_rippleView closeRippleTimer];
        
    } else {
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (showYYTableView) {
            _rippleView.transform = CGAffineTransformMakeTranslation(-SCREEN_WIDTH, 0);
            _yingYueView.transform = CGAffineTransformIdentity;
        } else {
            _rippleView.transform = CGAffineTransformIdentity;
            _yingYueView.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        }
    } completion:^(BOOL finished) {
        _rippleView.hidden = showYYTableView;
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.view bringSubviewToFront:_backButton];
    [self.view bringSubviewToFront:_revocationButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CYClassMethod setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isCanQ = YES;
    [self afterUpdateYingYueList:0];
}

- (void)afterUpdateYingYueList:(NSTimeInterval)interval {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_isCanQ) [self updateYingYueList];
    });
}

- (void)updateYingYueList {
    [CYXSHelper yingYueRenList:self.yue_id success:^(id obj) {
        NSLog(@"obj = %@",obj);
        NSArray *list = obj[@"result"];
        self.yingYueList = [[XSYingYueModel mj_objectArrayWithKeyValuesArray:list] mutableCopy];
        
        //        --number_of    订单所需人数 --user_cou     总应约人数  --kaishi_time   倒计时开始时间戳  --jieshu_time   倒计时结束时间戳
        NSString *number_of     = obj[@"number_of"];
        NSString *user_cou      = obj[@"user_cou"];
        NSString *yue_user_cou   = obj[@"yue_user_cou"];
        NSString *jieshu_time   = obj[@"jieshu_time"];
        _number_of = number_of.integerValue;
        
        [_yingYueView setParams:number_of cou:user_cou time:jieshu_time selCou:yue_user_cou];
        
        [self afterUpdateYingYueList:5];
    } failure:^(id obj) {
        self.yingYueList = nil;
        [self afterUpdateYingYueList:5];
    }];
}


- (void)completeToOrderList {
    NSArray *list = [self.yingYueList copy];
    int i = 0;
    for (XSYingYueModel *model in list) {
        if (model.yue_user_state.integerValue == 1) {
            i += 1;
            
            if (_number_of == i) {
                [self.navigationController pushViewController:[[XSMeYueListViewController alloc] init] animated:YES];
                return;
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _isCanQ = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    _mapView.delegate = nil;
    [self.mapView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

