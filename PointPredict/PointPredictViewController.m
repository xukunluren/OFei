//
//  PointPredictViewController.m
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "PointPredictViewController.h"
#import "OFeiCommon.h"
#import <MapKit/MapKit.h>
#import "PellTableViewSelect.h"
#import "PointViewController.h"
#import <ArcGIS/ArcGIS.h>

@interface PointPredictViewController ()<AGSWebMapDelegate,AGSMapViewLayerDelegate,AGSLayerDelegate,AGSMapViewTouchDelegate>

@end

@implementation PointPredictViewController
{
//   MKMapView *_mapView;
    NSString *_title;
    AGSGraphicsLayer *_myGraphicsLayer;
    AGSMapView *_mapview;
    
}

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
  
    NSString *title = @"点预报";
    [self setNavTitle:title];
    [self setButton];
    [self initGUI];
}


//设置顶部右侧按钮
-(void)setButton
{
//    self.navigationController.navigationBar.barTintColor = BarColor;
    //词方法可以用来放置标题的下拉按钮
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton1 addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"down-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:exampleButton1];
    self.navigationItem.rightBarButtonItem = right;
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    
    self.navigationItem.leftBarButtonItem = left;
    
}



-(void)selectPoint
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width-100, 64, 100, 190) selectData:@[@"A点",@"B点",@"C点",@"D点"] action:^(NSInteger index) {
        PointViewController *point = [[PointViewController alloc] init];
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A点";
        }
        if (index == 1) {
            _title = @"B点";
        }
        if (index == 2) {
            _title = @"C点";
        }
        if (index == 3) {
            _title = @"D点";
        }
        NSLog(@"%@",_title);
        //在此处传递选择的区域值到partition页面：使用通知中心的模式进行传值
        self.delegate = point;
        [self.delegate sendTitle:_title];
        
        
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//        backItem.title = @"返回";
//        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//        self.navigationItem.backBarButtonItem = backItem;
//        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//

        //自定义返回按钮
        UIImage *backButtonImage = [[UIImage imageNamed:@"left-25.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //将返回按钮的文字position设置不在屏幕上显示
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
        //        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left-25.png"] style:UIBarButtonItemStylePlain target:self action:nil];
//
//        [self.navigationItem setBackBarButtonItem:backItem];
        [self.navigationController pushViewController:point animated:YES];
        
    } animated:YES];
}

-(void)setNavTitle:(NSString *)text
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor]; // change this color
    self.navigationItem.titleView = label;
    label.text = text;
    [label sizeToFit];
    
}
-(void)initGUI{
    [AGSRuntimeEnvironment setClientID:@"kEpOhTfdwMTLW4St" error:nil];
    self.view.backgroundColor = [UIColor redColor];
    AGSMapView *mapview = [[AGSMapView alloc] initWithFrame:self.view.bounds];
    [mapview setGridLineWidth:0];
    [mapview setGridLineColor:[UIColor clearColor]];
    mapview.backgroundColor = [UIColor grayColor];
    mapview.layerDelegate = self;
    mapview.touchDelegate = self;
    _mapview = mapview;
    [self.view addSubview:mapview];
    
    NSURL *url_Tiled = [NSURL URLWithString:KMainMap];
    AGSDynamicMapServiceLayer *tiledLyr = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:url_Tiled];
    [mapview addMapLayer:tiledLyr withName:@"TiledLayer"];
   
     _myGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [mapview addMapLayer:_myGraphicsLayer withName:@"Graphics Layer"];
    
    AGSSimpleMarkerSymbol *myMarkerSymbol =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol.color = [UIColor blueColor];
    myMarkerSymbol.outline.width = 3;

    
    AGSMutableMultipoint *multiPoint = [[AGSMutableMultipoint alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    [multiPoint addPoint: [AGSPoint pointWithX:120.9297 y:27.8633 spatialReference:nil]];
    [multiPoint addPoint: [AGSPoint pointWithX:120.9173 y:27.7844 spatialReference:nil]];
    [multiPoint addPoint: [AGSPoint pointWithX:120.8431 y:27.7236 spatialReference:nil]];
    [multiPoint addPoint: [AGSPoint pointWithX:120.7552 y:27.6640 spatialReference:nil]];
    
    AGSGraphic* myGraphic =
    [AGSGraphic graphicWithGeometry:multiPoint
                             symbol:myMarkerSymbol
                         attributes:nil];
    [_myGraphicsLayer addGraphic:myGraphic];
    
    //设定地图初始化显示范围为中国
    AGSEnvelope *chinaEnv =[AGSEnvelope envelopeWithXmin:120.55707419812024
                                                    ymin:27.94215160670183
                                                    xmax:121.28245137296617
                                                    ymax:27.594495785487935
                                        spatialReference:mapview.spatialReference];
    [mapview zoomToEnvelope:chinaEnv animated:YES];
}


- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features
{
     NSLog(@"你好");
}

-(void)back{
   
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
