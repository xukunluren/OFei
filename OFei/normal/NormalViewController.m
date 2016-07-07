//
//  NormalViewController.m
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "NormalViewController.h"
#import "OFeiCommon.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CCLocationManager.h"
#import "ViewController.h"
#import "PointPredictViewController.h"
#import "AreaPredictViewController.h"
#import "RoutesPredictViewController.h"
#import "WarnInformationViewController.h"
#import "UIBarButtonItem+Badge.h"
#import "TyphoonPredictViewController.h"
#import "mainOfeiViewController.h"
#import "PartitionViewController.h"
#import "DKCircleButton.h"
#import "windViewController.h"
#import "waveViewController.h"
#import "flowViewController.h"
#import "longTideViewController.h"
#import "shortTideViewController.h"
#import "fllViewController.h"
#import "tidePositionViewController.h"
#import "warmOfeiViewController.h"
#import "TyphoneViewController.h"
#import "TOWebViewController.h"
#define BLUE_GREEN_COLOR @"#00C8D3"

@interface NormalViewController ()<CLLocationManagerDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITabBarControllerDelegate,locationDelegate>
{
    CLLocationManager *locationmanager;
    CLLocationManager *_locationManager;
     NSMutableData *_backData;
    NSString *_city;
    NSString *_location;
    NSString *_title;
    NSDictionary *_weatherDictory;
    
    NSString *weather24;
    NSString *visible24;
    NSString *weather48;
    NSString *visible48;
    NSString *weather72;
    NSString *visible72;

    
    DKCircleButton *button1;
    NSArray *_nameArray;
    
    BOOL buttonState;
    
    //天气信息获取
    UILabel *_24weather;
    UILabel *_48weather;
    UILabel *_72weather;
    UILabel *_24visible;
    UILabel *_48visible;
    UILabel *_72visible;
}
@property(nonatomic,strong)NSMutableArray * myRects;//存放所有的view
@property(nonatomic,strong)NSMutableArray * frames;//存放view的标准位置

@end

@implementation NormalViewController


#pragma mark - 视图将要出现
- (void)viewWillAppear:(BOOL)animated
{
    //导航栏背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bargound.png"] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏底部线
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"nav_bargound.png"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 定义所有子页面返回按钮的名称
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.tintColor = [UIColor whiteColor];
    backItem.title = @"返回";
    self.navigationController.navigationItem.backBarButtonItem = backItem;
//    self.title = @"瓯飞天气";
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    CGRect mainView = [UIScreen mainScreen].bounds;
//    [self setBackgroundImage];
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];


    // 创建按钮
    [self getUrl];
    [self setButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"test" object:nil];
    
    [self setNavTitle:@"瓯飞天气"];
    
    [self drawNormal];
    [self button];
    
    
}



#define 通知中心用于传递天气信息的数值
-(void)test:(NSNotification *)notification
{
//    id text = notification.object ;
//    NSDictionary *dataDictionary = text;
//    _normalView.weatherLabel.text = [dataDictionary objectForKey:@"1"];
//    _normalView.weatherLabel1.text = [dataDictionary objectForKey:@"2"];
//    
//    _normalView.windLabel.text = [dataDictionary objectForKey:@"3"];
//    _normalView.windLabel1.text = [dataDictionary objectForKey:@"4"];
//    
//    _normalView.pmLabel.text = [dataDictionary objectForKey:@"5"];
//     NSString *title = [dataDictionary objectForKey:@"6"];
//     _normalView.DataDate.text = [dataDictionary objectForKey:@"7"];
//    [self setNavTitle:title];
//    NSLog(@"通知中心传值%@",text);
}


-(void)drawNormal
{
    _showData = [[UIView alloc]init];
    _showData.frame = CGRectMake(5, 65, KWight-10, KHight*0.58);
    _showData.backgroundColor = [UIColor blackColor];
    _showData.alpha = 0.4;
    _showData.layer.cornerRadius = 10;
    [self.view addSubview:_showData];
    
    UILabel *head1 = [[UILabel alloc]initWithFrame:CGRectMake(8, KHight*0.13, 100, 200)];
    head1.text = @"天\n\n气";
    head1.numberOfLines = [head1.text length];
    head1.textColor = [UIColor whiteColor];
    [self.view addSubview:head1];
    UILabel *head2 = [[UILabel alloc]initWithFrame:CGRectMake(8, KHight*0.4, 100, 200)];
    head2.text = @"能\n见\n度\n(m)";
    head2.textColor = [UIColor whiteColor];
    head2.numberOfLines = [head2.text length];
    [self.view addSubview:head2];
    UILabel *time1 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.2, 65, 100, 40)];
    time1.text = @"24H";
    time1.textColor = [UIColor whiteColor];
    [self.view addSubview:time1];
    UILabel *time2 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.5, 65, 100, 40)];
    time2.text = @"48H";
    time2.textColor = [UIColor whiteColor];
    [self.view addSubview:time2];
    UILabel *time3 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.8, 65, 100, 40)];
    time3.text = @"72H";
    time3.textColor = [UIColor whiteColor];
    [self.view addSubview:time3];
  
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(_showData.frame.size.width*0.15,_showData.frame.size.height*0.3 , _showData.frame.size.width*0.85, 1)];
    line1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line1];
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(_showData.frame.size.width*0.15, KHight*0.42, _showData.frame.size.width*0.85, 1)];
    line2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:line2];
    
    //获取天气信息
    _24weather = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.1, KHight*0.35, 100, 40)];
    _24weather.textColor = [UIColor whiteColor];
//    _24weather.backgroundColor = [UIColor blackColor];
//    _24weather.text = @"123123";
    _24weather.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_24weather];
    _48weather = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.4, KHight*0.35, 100, 40)];
    _48weather.textColor = [UIColor whiteColor];
    _48weather.textAlignment = NSTextAlignmentCenter;
//    _48weather.text = @"123123";
    [self.view addSubview:_48weather];
    _72weather = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.7, KHight*0.35, 100, 40)];
    _72weather.textColor = [UIColor whiteColor];
    _72weather.textAlignment = NSTextAlignmentCenter;
//    _72weather.text = @"123123";
    [self.view addSubview:_72weather];
    
    _24visible = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.12, KHight*0.6, 100, 40)];
    _24visible.textColor = [UIColor whiteColor];
//    _24visible.backgroundColor = [UIColor blackColor];
//    _24visible.text = @"123123";
    _24visible.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_24visible];
    _48visible = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.42, KHight*0.6, 100, 40)];
    _48visible.textColor = [UIColor whiteColor];
//    _48visible.backgroundColor = [UIColor blackColor];
//    _48visible.text = @"123123";
    _48visible.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_48visible];
    _72visible = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.72, KHight*0.6, 100, 40)];
    _72visible.textColor = [UIColor whiteColor];
//    _72visible.backgroundColor = [UIColor blackColor];
//    _72visible.text = @"123123";
    _72visible.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_72visible];

}

//设置顶部右侧按钮
-(void)setButton
{
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    self.navigationController.navigationBar.barTintColor = BarColor;
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    exampleButton1.contentMode = UIViewContentModeScaleAspectFit;
//    [exampleButton1 addTarget:self action:@selector(GoToMapView) forControlEvents:UIControlEventTouchUpInside];
//    [exampleButton1 addTarget:self action:@selector(goToNext) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
     [exampleButton1 setImage:[UIImage imageNamed:@"home_25.png"] forState:UIControlStateHighlighted];
     _right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
    
//    self.navigationItem.rightBarButtonItem = _right;
 
    
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"export.png"] forState:UIControlStateNormal];
     [exampleButton setImage:[UIImage imageNamed:@"export_25.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    self.navigationItem.leftBarButtonItem = left;
    

}

-(void)exit
{
   [self dismissViewControllerAnimated:YES completion:^{
   }];

}

-(void)goToNext
{
    
    mainOfeiViewController *main = [[mainOfeiViewController alloc] init];
    //自定义返回按钮
    UIImage *backButtonImage = [[UIImage imageNamed:@"left-25.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController pushViewController:main animated:YES];

}
//#define  进入地图服务界面
//-(void)GoToMapView
//{
//    
//  
//    UITabBarController *tabBarController = [[UITabBarController alloc]init];
//   
//    //用于设置字体的问题（颜色和大小等）
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateNormal];
//    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor blackColor]} forState:UIControlStateSelected];
//    
//
//    PartitionViewController *home = [[PartitionViewController alloc]init];
//    home.title = @"分区预报";
//    //可用于解决图片灰色问题
//    home.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"分区预报" image:[[UIImage imageNamed:@"zone-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"zone_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    
//    PointPredictViewController *two = [[PointPredictViewController alloc]init];
//    two.title = @"点预报";
//    //    two.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:1];
//     //可用于解决图片灰色问题
//     two.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"点预报" image:[[UIImage imageNamed:@"point.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"point_select.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    AreaPredictViewController *three = [[AreaPredictViewController alloc]init];
//    three.title = @"大面预报";
//     //可用于解决图片灰色问题
//     three.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"大面预报" image:[[UIImage imageNamed:@"zone.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"zone_select.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    RoutesPredictViewController *four = [[RoutesPredictViewController alloc]init];
//    four.title = @"航线预报";
//     //可用于解决图片灰色问题
//    four.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"航线预报" image:[[UIImage imageNamed:@"route-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"route_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    WarnInformationViewController *five = [[WarnInformationViewController alloc]init];
//    five.title = @"预警信息";
//     //可用于解决图片灰色问题
//    five.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"预警信息" image:[[UIImage imageNamed:@"warn-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"warn_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    //navigation
//    
//    UINavigationController *navFrist = [[UINavigationController alloc]initWithRootViewController:home];
////    navFrist.title = @"分区预报";
////    navFrist.navigationBar.backgroundColor = BarColor;
//    
//    [tabBarController addChildViewController:navFrist];
//    
//    UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:two];
////    navSecond.navigationBar.backgroundColor = BarColor;
//    [tabBarController addChildViewController:navSecond];
//    
//    UINavigationController *navThrid = [[UINavigationController alloc]initWithRootViewController:three];
////    navThrid.navigationBar.backgroundColor = BarColor;
//    [tabBarController addChildViewController:navThrid];
//    
//    UINavigationController *navForth = [[UINavigationController alloc]initWithRootViewController:four];
////    navForth.navigationBar.backgroundColor = BarColor;
//    
//    [tabBarController addChildViewController:navForth];
//    
//    UINavigationController *navFifth = [[UINavigationController alloc]initWithRootViewController:five];
////    navFifth.navigationBar.backgroundColor = BarColor;
//    [tabBarController addChildViewController:navFifth];
////    [tabBarController.tabBar setBarTintColor:[UIColor grayColor]];//设置navigationbar的颜色
////    [self.navigationController pushViewController:tabBarController animated:YES];
//    [self presentViewController:tabBarController animated:YES completion:nil];
//}

//设置标题
-(void)setNavTitle:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = @"瓯飞天气";
    [label sizeToFit];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- 设置button
-(void)button
{
    self.myRects = [NSMutableArray arrayWithCapacity:10];
    self.frames = [NSMutableArray arrayWithCapacity:10];
    _nameArray = [[NSArray alloc] initWithObjects:@"分区预报", @"点位预报", @"航线预报", @"预警信息", @"台风路径",nil];
    
    NSLog(@"数组大小是多少：%lu",(unsigned long)_nameArray.count);
    CGFloat withOfButton = self.view.frame.size.width;
    CGFloat heighOfButton = self.view.frame.size.height;
    //初始化页面，加9宫格
    for (int i = 0; i < _nameArray.count; i++)
    {
        button1 = [[DKCircleButton alloc] init];
        
            button1.center = CGPointMake(10, 10);
//        button1.frame = CGRectMake(35 + i%2 * withOfButton*0.42, 80 + i/2 * heighOfButton*0.28,withOfButton*0.36,withOfButton*0.36);
        button1.frame = CGRectMake(i%3 * withOfButton*0.3 + 30, i/3 * heighOfButton*0.13 + KHight*0.72, KWight*0.22, KWight*0.22);
        if (i > 2) {
            button1.frame = CGRectMake(i%3 * withOfButton*0.3 + KWight/4, i/3 * heighOfButton*0.13+ KHight*0.72, KWight*0.22, KWight*0.22);
        }
        button1.titleLabel.font = [UIFont systemFontOfSize:15];
        button1.titleLabel.tintColor = [UIColor blackColor];
        button1.tag = i;
        
        button1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBackImage"]];
        [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateSelected];
        [button1 setTitleColor:[UIColor colorWithWhite:1 alpha:1.0] forState:UIControlStateHighlighted];
        
        [button1 setTitle:NSLocalizedString(_nameArray[i], nil) forState:UIControlStateNormal];
        button1.tintColor = [UIColor blackColor];
        
        [button1 addTarget:self action:@selector(tapOnButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button1];
    }
}
- (void)tapOnButton:(UIButton *)button {
    
    if (button.tag==0) {
        
        button.tintColor = [UIColor whiteColor];
        PartitionViewController *partition = [[PartitionViewController alloc]init];
        [self.navigationController pushViewController:partition animated:YES];
        
    }
    if (button.tag==1) {
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        //用于设置字体的问题（颜色和大小等）
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor:KTextColor} forState:UIControlStateSelected];
        
        
        windViewController *wind = [[windViewController alloc]init];
        wind.point = @"A点";
        //可用于解决图片灰色问题
        wind.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"风" image:[[UIImage imageNamed:@"wind-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wind_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        waveViewController *wave = [[waveViewController alloc]init];
        wave.point = @"A点";
        
        //可用于解决图片灰色问题
        wave.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"浪" image:[[UIImage imageNamed:@"wave-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wave_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        flowViewController *flow = [[flowViewController alloc]init];
        flow.point = @"A点";
        //可用于解决图片灰色问题
        flow.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"流" image:[[UIImage imageNamed:@"flow-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"flow_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        shortTideViewController *four = [[shortTideViewController alloc]init];
        four.point = @"A点";
        //可用于解决图片灰色问题
        four.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"短潮" image:[[UIImage imageNamed:@"STide-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"STide_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        longTideViewController *longTide = [[longTideViewController alloc]init];
        longTide.point = @"A点";
        //可用于解决图片灰色问题
        longTide.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"长潮" image:[[UIImage imageNamed:@"LTide-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"LTide_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        //navigation
        
        UINavigationController *navFrist = [[UINavigationController alloc]initWithRootViewController:wind];
        
        [tabBarController addChildViewController:navFrist];
        
        UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:wave];
        //    navSecond.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navSecond];
        
        UINavigationController *navThrid = [[UINavigationController alloc]initWithRootViewController:flow];
        //    navThrid.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navThrid];
        
        UINavigationController *navForth = [[UINavigationController alloc]initWithRootViewController:four];
        //    navForth.navigationBar.backgroundColor = BarColor;
        
        [tabBarController addChildViewController:navForth];
        
        UINavigationController *navFifth = [[UINavigationController alloc]initWithRootViewController:longTide];
        //    navFifth.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navFifth];
        [self presentViewController:tabBarController animated:YES completion:nil];
        
        
    }
    if (button.tag==2) {
        
        
        UITabBarController *tabBarController = [[UITabBarController alloc]init];
        
        //用于设置字体的问题（颜色和大小等）
        UIColor *color = [UIColor colorWithRed:26 green:188 blue:156 alpha:1];
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateNormal];
        
        [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeFont : [UIFont systemFontOfSize:12],UITextAttributeTextColor:KTextColor} forState:UIControlStateSelected];
        
        
        fllViewController *fill = [[fllViewController alloc]init];
        //        fill.point = @"A点";
        //可用于解决图片灰色问题
        fill.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"风浪流" image:[[UIImage imageNamed:@"wind-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wind_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        tidePositionViewController *tide = [[tidePositionViewController alloc]init];
        //        wave.point = @"A点";
        
        //可用于解决图片灰色问题
        tide.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"潮" image:[[UIImage imageNamed:@"wave-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"wave_select-25.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        
        //navigation
        
        UINavigationController *navFrist = [[UINavigationController alloc]initWithRootViewController:fill];
        
        [tabBarController addChildViewController:navFrist];
        
        UINavigationController *navSecond = [[UINavigationController alloc]initWithRootViewController:tide];
        //    navSecond.navigationBar.backgroundColor = BarColor;
        [tabBarController addChildViewController:navSecond];
        
        
        //    navFifth.navigationBar.backgroundColor = BarColor;
        [self presentViewController:tabBarController animated:YES completion:nil];
        
    }
    if (button.tag==3) {
        warmOfeiViewController *warm = [[warmOfeiViewController alloc] init];
        [self.navigationController pushViewController:warm animated:YES];
        
        
    }
    if (button.tag==4) {
        
        NSString *urlstring = @"http://typhoon.zjwater.gov.cn/wap.htm?from=groupmessage&isappinstalled=0";
        //        NSString *urlstring = @"http://www.wztf121.com/";
        NSURL *url = [NSURL URLWithString:urlstring];
        TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:url];
        [self.navigationController pushViewController:webViewController animated:YES];
        
        
        //        TyphoneViewController *typhone =[[TyphoneViewController alloc] init];
        //
        //        [self.navigationController pushViewController:typhone animated:YES];
        
    }
    
    buttonState = !buttonState;
}

#pragma mark -- 获取数据
-(void)getUrl
{
    NSURL *url_24 = [NSURL URLWithString:Knormal24];
    NSURLRequest *requst_24 = [NSURLRequest requestWithURL:url_24 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:requst_24 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       weather24 = [rootDic[0] objectForKey:@"WEATHER"];
       visible24 = [rootDic[0] objectForKey:@"VIS"];
        
        _24weather.text = [self chinese:weather24];
        _24visible.text = visible24;
        
        [self addPicture];
       

    }];
    NSURL *url_48 = [NSURL URLWithString:Knormal48];
    NSURLRequest *requst_48 = [NSURLRequest requestWithURL:url_48 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:requst_48 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        weather48 = [rootDic[0] objectForKey:@"WEATHER"];
        visible48 = [rootDic[0] objectForKey:@"VIS"];
        
        _48weather.text = [self chinese:weather48];
        _48visible.text = visible48;
        [self addPicture];
    }];
    NSURL *url_72 = [NSURL URLWithString:Knormal72];
    NSURLRequest *requst_72 = [NSURLRequest requestWithURL:url_72 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:requst_72 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *rootDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        weather72 = [rootDic[0] objectForKey:@"WEATHER"];
        visible72 = [rootDic[0] objectForKey:@"VIS"];
        
        _72weather.text = [self chinese:weather72];
        _72visible.text = visible72;
        [self addPicture];
    }];
}

-(void)addPicture
{
    //字符串名字进行更改   能见度也要改，数据确认
    UIImageView *weather1 = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.1 , KHight*0.2, KWight*0.28, KWight*0.28)];
    if ([weather24 isEqualToString:@"sunny"]) {
        [weather1 setImage:[UIImage imageNamed:@"sun.png"]];
    }else if ([weather24 isEqualToString:@"cloudy"]){
        [weather1 setImage:[UIImage imageNamed:@"cloudy.png"]];
    }else if ([weather24 isEqualToString:@"rainy"])
    {
        [weather1 setImage:[UIImage imageNamed:@"rainy.png"]];
    }
    [self.view addSubview:weather1];
    UIImageView *weather2 = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.4, KHight*0.2, KWight*0.28, KWight*0.28)];
    if ([weather48 isEqualToString:@"sunny"]) {
        [weather2 setImage:[UIImage imageNamed:@"sun.png"]];
    }else if ([weather48 isEqualToString:@"cloudy"]){
        [weather2 setImage:[UIImage imageNamed:@"cloudy.png"]];
    }else if ([weather48 isEqualToString:@"rainy"])
    {
        [weather2 setImage:[UIImage imageNamed:@"rainy.png"]];
    }
    [self.view addSubview:weather2];
    UIImageView *weather3 = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.7, KHight*0.2, KWight*0.28, KWight*0.28)];
    if ([weather72 isEqualToString:@"sunny"]) {
        [weather3 setImage:[UIImage imageNamed:@"sun.png"]];
    }else if ([weather72 isEqualToString:@"cloudy"]){
        [weather3 setImage:[UIImage imageNamed:@"cloudy.png"]];
    }else if ([weather72 isEqualToString:@"rainy"])
    {
        [weather3 setImage:[UIImage imageNamed:@"rainy.png"]];
    }
    [self.view addSubview:weather3];
    
    UIImageView *visible1 = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.13, KHight*0.45, KWight*0.25, KWight*0.25)];
    if ([visible24 isEqualToString:@"10-15"]) {
        [visible1 setImage:[UIImage imageNamed:@"vis2.png"]];
    }else if ([visible24 isEqualToString:@"15-25"]){
        [visible1 setImage:[UIImage imageNamed:@"vis1.png"]];
    }
//    [visible1 setImage:[UIImage imageNamed:@"visibility.png"]];
    [self.view addSubview:visible1];
    UIImageView *visible2 = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.43, KHight*0.45, KWight*0.25, KWight*0.25)];
    if ([visible48 isEqualToString:@"10-15"]) {
        [visible2 setImage:[UIImage imageNamed:@"vis2.png"]];
    }else if ([visible48 isEqualToString:@"15-25"]){
        [visible2 setImage:[UIImage imageNamed:@"vis1.png"]];
    }
//    [visible2 setImage:[UIImage imageNamed:@"visibility.png"]];
    [self.view addSubview:visible2];
    UIImageView *visible3 = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.73, KHight*0.45, KWight*0.25, KWight*0.25)];
    if ([visible72 isEqualToString:@"10-15"]) {
        [visible3 setImage:[UIImage imageNamed:@"vis2.png"]];
    }else if ([visible72 isEqualToString:@"15-25"]){
        [visible3 setImage:[UIImage imageNamed:@"vis1.png"]];
    }
//    [visible3 setImage:[UIImage imageNamed:@"visibility.png"]];
    [self.view addSubview:visible3];

}

-(NSString *)chinese:(NSString *)weatherChange
{
    NSString *chinese;
    if ([weatherChange isEqualToString:@"sunny"]) {
        chinese = @"晴天";
    }else if ([weatherChange isEqualToString:@"cloudy"]){
        chinese = @"多云";
    }
    return chinese;
}
//-(UIImage *)selectImage:(NSString *)weatherChange
//{
//    UIImage *selectImage;
//    if ([weatherChange isEqualToString:@"sunny"]) {
//        [selectImage setImage:[UIImage imageNamed:@"sun.png"]];
//    }else if ([weatherChange isEqualToString:@"cloudy"]){
//        [selectImage setImage:[UIImage imageNamed:@"cloudy.png"]];
//    }
//    return selectImage;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
