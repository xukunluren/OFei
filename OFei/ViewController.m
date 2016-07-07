//
//  ViewController.m
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "ViewController.h"
#import "normal/NormalViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CCLocationManager.h"
#import "OFeiCommon.h"
#import "Reachability.h"



@interface ViewController ()<CLLocationManagerDelegate,MKReverseGeocoderDelegate>
@property(nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation ViewController
{
    NormalViewController *normal;
    CLLocationManager *locationmanager;
    NSString *_city;
    NSString *_location;
    NSMutableData *_backData;
    NSDictionary *_weatherDictory;
    NSString *_pm;
    NSString *_weather;
    NSString *_title;
    NSString *_tempMin;
    NSString *_temp;
    NSString *_wind;
    NSString *_windD;
    NSString *_windD1;
    NSString *_date;
    NSMutableDictionary *_dictory;
//    CLGeocoder *_geoCoder;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
    _myAppDelegate = [[UIApplication sharedApplication] delegate];
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView1 = [[UIImageView alloc] initWithFrame:mainView];
    imageView1.image = [UIImage imageNamed:@"mainBackImage.png"];
    //        _imageView.alpha = 1;
    imageView1.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView1];
    
    NSLog(@"你好");
//    if ([CLLocationManager locationServicesEnabled]) {
//        locationmanager = [[CLLocationManager alloc] init];
//        [locationmanager setDelegate:self];
//        [locationmanager startUpdatingLocation];
//        [locationmanager requestWhenInUseAuthorization];
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//            
//            [locationmanager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
//    }

 
    [self setlogin];
    
    
    //    画横线
//    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:imageView];
    
//    UIGraphicsBeginImageContext(imageView.frame.size);
//    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.2);
//    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
//    //    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 1, 0, 0);
//    [[UIColor redColor]setStroke];
//    CGContextBeginPath(UIGraphicsGetCurrentContext());
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), X*0.1+3, Y*0.2+39);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), X*0.1+397, Y*0.2+39);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    [self setShou];
    
}

-(void)setShou
{
    UILabel *shou = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height*0.9, self.view.frame.size.width, self.view.frame.size.height*0.1)];
    shou.text = @"©上海海洋大学 ~ 数字海洋研究所";
    shou.font = [UIFont systemFontOfSize:12.0f];
    shou.textAlignment = NSTextAlignmentCenter;
    shou.tintColor = [UIColor blueColor];
//    shou.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:shou];

}
-(void)setlogin
{
    
    
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [self drawGradient2:context];
    //登录界面
    CGFloat X = self.view.frame.size.width;
    CGFloat Y = self.view.frame.size.height;
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, Y*0.15, X, 100)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.font = [UIFont fontWithName:@"Arial" size:20];
//    title.text = @"瓯飞工程海洋预报\n信息服务移动平台";
//    title.numberOfLines = 0;
//    [self.view addSubview:title];
    
    UIImageView *title = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, Y*0.2, 300, 30)];
    //    [title.backgroundColor= [UIColor colorWithPatternImage:@"p1.png"]];
//    [title setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ofei3.png"]]];
    [title setImage:[UIImage imageNamed:@"ofei5"]];
    [self.view addSubview:title];
    UIImageView *Img =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"none.png"]];
    UIImageView *Img1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"none1.png"]];
    
    //用户名
    UITextField *name = [[UITextField alloc]initWithFrame:CGRectMake(X*0.5-100, Y*0.3, 200, 40)];
    //    [name setBorderStyle:UITextBorderStyleRoundedRect];
    //设置上边圆角
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:name.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1= [[CAShapeLayer alloc]init];
    maskLayer1.frame=name.bounds;
    maskLayer1.path=maskPath1.CGPath;
    name.layer.mask=maskLayer1;
    [name setBorderStyle:UITextBorderStyleRoundedRect];
    name.placeholder = @"  用户名";
//    name.text = @" ";
    name.backgroundColor=[UIColor whiteColor];
    name.autocapitalizationType = UITextAutocorrectionTypeNo;
    name.clearButtonMode=UITextFieldViewModeWhileEditing;
    name.returnKeyType=UIReturnKeyNext;
    //设置左右图片
    name.leftView=Img;
    //    name.rightView=Img;
    name.leftViewMode=UITextFieldViewModeAlways;

    //    [name setDelegate:self];
    [self.view addSubview:name];
    
    
    //密码
    UITextField *pwd = [[UITextField alloc]initWithFrame:CGRectMake(X*0.5-100, Y*0.3+40, 200, 40)];
    //    [pwd setBorderStyle:UITextBorderStyleRoundedRect];
    pwd.placeholder = @"  密    码";
    //设置下面圆角
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:pwd.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer2= [[CAShapeLayer alloc]init];
    maskLayer2.frame=pwd.bounds;
    maskLayer2.path=maskPath2.CGPath;
    pwd.layer.mask=maskLayer2;
    [pwd setBorderStyle:UITextBorderStyleRoundedRect];
    //设置左右图片
    pwd.leftView=Img1;
    pwd.leftViewMode=UITextFieldViewModeAlways;

    pwd.backgroundColor=[UIColor whiteColor];
    pwd.autocapitalizationType = UITextAutocorrectionTypeNo;
    pwd.clearButtonMode=UITextFieldViewModeWhileEditing;
    pwd.returnKeyType=UIReturnKeySend;
//    pwd.text = @" ";
    //    pwd.keyboardType=UIKeyboardTypeDefault;
    pwd.secureTextEntry=YES;
    [self.view addSubview:pwd];
    
    UIButton *button = [[UIButton alloc]init];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.layer.cornerRadius=5.0;
    [button setFrame:CGRectMake(X*0.5-100, Y*0.5, 200, 40)];
    [button setTitle:@"登   录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //横线
//    UIImageView *imageView=[[UIImageView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:imageView];
//    UIGraphicsBeginImageContext(imageView.frame.size);
//    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.2);
//    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
//    //    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 1, 0, 0);
//    [[UIColor grayColor]setStroke];
//    CGContextBeginPath(UIGraphicsGetCurrentContext());
//    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), X*0.2+3, Y*0.3+39);
//    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), X*0.2+197, Y*0.3+39);
//    CGContextStrokePath(UIGraphicsGetCurrentContext());
//    imageView.image=UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

}

#pragma 获取位置的代理函数
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
//{
//    
//    CLLocation * currLocation = [locations lastObject];
//    
//    
//    NSLog(@"%@",[NSString stringWithFormat:@"%.3f",currLocation.coordinate.latitude]);
//    
//    NSLog(@"%@",[NSString stringWithFormat:@"%.3f",currLocation.coordinate.longitude]);
//    //    NSLog(@"%@",locations);
//  
//    
//    if (_geocoder==nil) {
//        _geocoder=[[CLGeocoder alloc]init];
//    }
//  [  _geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//      
//
//                CLPlacemark *placemark = placemarks[0];
//                NSLog(@"%@",placemark);
//        if (!error && [placemarks count] > 0)  {
//        for (CLPlacemark * placemark in placemarks) {
//            
//            NSDictionary *test = [placemark addressDictionary];
//            //  Country(国家)  State(城市)  SubLocality(区)
//            
//            _city = [test objectForKey:@"State"];
//            //获取当地的当天天气信息
////            [self getWeatherData:_city];
//            _location = [test objectForKey:@"SubLocality"];
//            NSString *title = [NSString stringWithFormat:@"%@  %@",_city,_location];
//            _title = title;
//            NSLog(@"====%@",title);
//        }
//        }
//    }];
//     NSLog(@"你好1");
//    
//}




//获取天气信息
-(void)getWeatherData:(NSString *)location
{
    //    NSLog(@"%@",location);
    NSString *city = [location substringToIndex:2];
    
    NSLog(@"%@",city);
    if(city.length == 0){
    city = @"上海";
    }
    //第一步，创建url
    NSString * URLString1 = @"http://api.lib360.net/open/weather.json?city=";
    NSString *URLString = [NSString stringWithFormat:@"%@%@",URLString1,city];
    NSURL * URL = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //    NSURL * URL = [NSURL URLWithString:URLString];
    
    NSLog(@"%@",URL);
    
    //    NSURL *url = [NSURL URLWithString:@"http://api.lib360.net/open/weather.json?city=苏州"];
    //第二步，创建请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //第三步，连接服务器
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
        [connection start];
}

#pragma 获取天气信息的代理方法
//接收到服务器回应的时候调用此方法
//接受到respone,这里面包含了HTTP请求状态码和数据头信息，包括数据长度、编码格式等
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
    _backData = [[NSMutableData alloc]init];
}
//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次

//接受到数据时调用，完整的数据可能拆分为多个包发送，每次接受到数据片段都会调用这个方法，所以需要一个全局的NSData对象，用来把每次的数据拼接在一起
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_backData appendData:data];
}

//数据接受结束时调用这个方法，这时的数据就是获得的完整数据了，可以使用数据做之后的处理了
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //    NSLog(@"你好%@",[[NSString alloc]initWithData:_backData encoding:NSUTF8StringEncoding]);
    _weatherDictory = [NSJSONSerialization JSONObjectWithData:_backData options:NSJSONReadingMutableContainers error:nil];
    //    NSLog(@"霓虹%@",_weatherDictory);
    //data、datanow\pm25
    [self weatherDataAnalysis:_weatherDictory];
    //    NSLog(@"")
}
//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
-(void)connection:(NSURLConnection *)connection
 didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}



#pragma 天气数据解析
-(void)weatherDataAnalysis:(NSDictionary *)weatherData
{
    NSArray *weatherArray = [weatherData objectForKey:@"data"];
    NSLog(@"%@",weatherArray.firstObject);
    NSDictionary *datanow = weatherArray.firstObject;
    NSDictionary *datanow1 = [weatherData objectForKey:@"datanow"];
    NSNumber *pm1 = [weatherData objectForKey:@"pm25"];
    
    NSString *pm = pm1.description;

    NSString *weather = [datanow objectForKey:@"Weather"];
    
    NSString *tempMax = [datanow objectForKey:@"TempMax"];
    NSString *tempMin = [datanow objectForKey:@"TempMin"];
    NSString *wind = [datanow objectForKey:@"Wind"];
    NSString *windD = [datanow objectForKey:@"WindB"];
    NSString *windD1 = [datanow1 objectForKey:@"Wind"];
    NSString *date = [datanow objectForKey:@"Date"];
    NSLog(@"%@==%@==%@==%@==%@==%@==%@",pm,weather,tempMax,tempMin,wind,windD,date);
    if (tempMax!=nil&&tempMin!=nil) {
        NSString *zhi = @" ~ ";
        NSString *du = @"℃";
        NSString *temp = [NSString stringWithFormat:@"%@%@%@%@",tempMin,zhi,tempMax,du];
        _temp = temp;
    }
    if (weather!=nil) {
        NSLog(@"%@",weather);
        _weather = weather;
    }
    if (wind!=nil&&windD!=nil) {
        if (windD.length<2) {
            _windD = windD1;
        }else{
            _windD = windD;
        }
        _wind = wind;
    }
    if (_title!=nil&&date!=nil) {
        
        NSString *xinxi = [NSString stringWithFormat:@"%@%@",_title,date];
        _date = xinxi;
    }
    if (pm!=nil) {
        _pm = pm;
    }
    _dictory = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:_weather forKey:@"1"];
    [dictionary setObject:_temp forKey:@"2"];
    [dictionary setObject:_windD forKey:@"3"];
    [dictionary setObject:_wind forKey:@"4"];
    [dictionary setObject:_pm forKey:@"5"];
    [dictionary setObject:_title forKey:@"6"];
    [dictionary setObject:_date forKey:@"7"];
    _dictory = dictionary;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"test" object:_dictory];


}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)login{
    normal = [[NormalViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *normalView = [[UINavigationController alloc] initWithRootViewController:normal];
    self.delegate = normal;
    //    [self.navigationController pushViewController:normal animated:true];
    
    [self presentViewController:normalView animated:YES completion:^{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"test" object:_dictory];
    }];


}


@end
