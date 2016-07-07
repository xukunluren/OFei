//
//  RoutesPredictViewController.m
//  OFei
//
//  Created by admin on 15/10/30.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "RoutesPredictViewController.h"
#import "OFeiCommon.h"
#import <MapKit/MapKit.h>
#import "RoutesViewController.h"
#import "PellTableViewSelect.h"
#import <ArcGIS/ArcGIS.h>

@interface RoutesPredictViewController ()<AGSWebMapDelegate,AGSMapViewLayerDelegate,AGSLayerDelegate>

@end

@implementation RoutesPredictViewController
{
 MKMapView *_mapView;
    NSString *_title;
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
    NSString *title = @"航线预报";
    [self setNavTitle:title];
    //    self.title = @"分区预报";
//    [self.navigationController.navigationBar setBarTintColor:BarColor];//设置navigationbar的颜色
    [self setButton];
    [self initGUI];
}


//设置顶部右侧按钮
-(void)setButton
{
//    self.navigationController.navigationBar.barTintColor = BarColor;
    //词方法可以用来放置标题的下拉按钮
    //    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton1 addTarget:self action:@selector(selectRoutes) forControlEvents:UIControlEventTouchUpInside];
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
    //    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [AGSRuntimeEnvironment setClientID:@"kEpOhTfdwMTLW4St" error:nil];
    self.view.backgroundColor = [UIColor redColor];
    AGSMapView *mapview = [[AGSMapView alloc] initWithFrame:self.view.bounds];
    [mapview setGridLineWidth:0];
    [mapview setGridLineColor:[UIColor clearColor]];
    mapview.backgroundColor = [UIColor grayColor];
    mapview.layerDelegate = self;
    [self.view addSubview:mapview];
    
    NSURL *url_Tiled = [NSURL URLWithString:KMainMap];
    AGSDynamicMapServiceLayer *tiledLyr = [AGSDynamicMapServiceLayer dynamicMapServiceLayerWithURL:url_Tiled];
    [mapview addMapLayer:tiledLyr withName:@"TiledLayer"];
    tiledLyr.delegate = self;
    
    AGSGraphicsLayer* myGraphicsLayer = [AGSGraphicsLayer graphicsLayer];
    [mapview addMapLayer:myGraphicsLayer withName:@"Graphics Layer"];
    
    
    
    AGSSimpleMarkerSymbol *myMarkerSymbol =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol.color = [UIColor blueColor];
    myMarkerSymbol.outline.width = 3;
    
    
    AGSSimpleMarkerSymbol *myMarkerSymbol1 =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol1.color = [UIColor redColor];
    
    
    AGSSimpleFillSymbol *myMarkerSymbol2 =
    [AGSSimpleFillSymbol simpleFillSymbol];
    myMarkerSymbol2.color = [UIColor whiteColor];
    myMarkerSymbol2.outline.width = 5;
    //    myMarkerSymbol2.
    myMarkerSymbol2.outline.color = [UIColor whiteColor];
    
    
    
    //凤凰山南堤南段
    AGSMutablePolyline* poly1 = [[AGSMutablePolyline alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    [poly1 addPathToPolyline];
    //往轨迹中添加节点
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7302 y:27.6896 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7302 y:27.6847 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7343 y:27.6811 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7412 y:27.6774 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7521 y:27.6725 spatialReference:nil]];
    
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7621 y:27.6701 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7714 y:27.6701 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7837 y:27.6701 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.7947 y:27.6738 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.8016 y:27.6762 spatialReference:nil]];
    [poly1 addPointToPath:[AGSPoint pointWithX:120.8047 y:27.6770 spatialReference:nil]];
    
    AGSGraphic* myGraphic1 =
    [AGSGraphic graphicWithGeometry:poly1
                             symbol:myMarkerSymbol2
                         attributes:nil];
    [myGraphicsLayer addGraphic:myGraphic1];
    
    
    
    //凤凰山东堤南段航线数据
    AGSMutablePolyline* poly = [[AGSMutablePolyline alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    [poly addPathToPolyline];
    //往轨迹中添加节点
    [poly addPointToPath:[AGSPoint pointWithX:120.8047 y:27.6770 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8194 y:27.6823 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8277 y:27.6883 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8332 y:27.6956 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8345 y:27.7029 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8359 y:27.7090 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8304 y:27.7151 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8222 y:27.7187 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8139 y:27.7187 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.8030 y:27.7163 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.7933 y:27.7127 spatialReference:nil]];
    [poly addPointToPath:[AGSPoint pointWithX:120.7879 y:27.7127 spatialReference:nil]];
    AGSGraphic* myGraphic2 =
    [AGSGraphic graphicWithGeometry:poly
                             symbol:myMarkerSymbol2
                         attributes:nil];
    [myGraphicsLayer addGraphic:myGraphic2];
    
    
    //霓屿山东堤北段
    AGSMutablePolyline* poly3 = [[AGSMutablePolyline alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    [poly3 addPathToPolyline];
    //往轨迹中添加节点
    [poly3 addPointToPath:[AGSPoint pointWithX:120.8910 y:27.8556 spatialReference:nil]];
    [poly3 addPointToPath:[AGSPoint pointWithX:120.9404 y:27.8447 spatialReference:nil]];
    [poly3 addPointToPath:[AGSPoint pointWithX:120.9847 y:27.8333 spatialReference:nil]];
    AGSGraphic* myGraphic3 =
    [AGSGraphic graphicWithGeometry:poly3
                             symbol:myMarkerSymbol2
                         attributes:nil];
    [myGraphicsLayer addGraphic:myGraphic3];
    
    
    //霓屿山北堤
    AGSMutablePolyline* poly4 = [[AGSMutablePolyline alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    [poly4 addPathToPolyline];
    //往轨迹中添加节点
    [poly4 addPointToPath:[AGSPoint pointWithX:120.8939 y:27.9013 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:120.8996 y:27.9037 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:120.9119 y:27.8989 spatialReference:nil]];
    
    [poly4 addPointToPath:[AGSPoint pointWithX:120.9339 y:27.8807 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:120.9545 y:27.8625 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:120.9696 y:27.8491 spatialReference:nil]];
    
    [poly4 addPointToPath:[AGSPoint pointWithX:120.9916 y:27.8333 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:121.0039 y:27.8321 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:121.0135 y:27.8394 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:121.0163 y:27.8479 spatialReference:nil]];
    [poly4 addPointToPath:[AGSPoint pointWithX:121.0163 y:27.8540 spatialReference:nil]];
    
    AGSGraphic* myGraphic4 =
    [AGSGraphic graphicWithGeometry:poly4
                             symbol:myMarkerSymbol2
                         attributes:nil];
    [myGraphicsLayer addGraphic:myGraphic4];
    
    
    
    
    
    //设定地图初始化显示范围为中国
    AGSEnvelope *chinaEnv =[AGSEnvelope envelopeWithXmin:120.55707419812024
                                                    ymin:27.94215160670183
                                                    xmax:121.28245137296617
                                                    ymax:27.594495785487935
                                        spatialReference:mapview.spatialReference];
    [mapview zoomToEnvelope:chinaEnv animated:YES];



}



-(void)selectRoutes
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width-200, 64, 200, 190) selectData:@[@"霓屿山北堤航线",@"霓屿山东堤北段航线",@"凤凰山东堤南段航线",@"凤凰山南堤航线"] action:^(NSInteger index) {
        RoutesViewController *routes = [[RoutesViewController alloc] init];
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"霓屿山北堤航线";
        }
        if (index == 1) {
            _title = @"霓屿山东堤北段航线";
        }
        if (index == 2) {
            _title = @"凤凰山东堤南段航线";
        }
        if (index == 3) {
            _title = @"凤凰山南堤航线";
        }
        NSLog(@"%@",_title);
        //在此处传递选择的区域值到partition页面：使用通知中心的模式进行传值
        self.delegate = routes;
        [self.delegate sendTitle:_title];
        [self.navigationController pushViewController:routes animated:YES];
        
    } animated:YES];
}

-(void)back{
    //    normal = [[NormalViewController alloc] init];
    //    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:normal];
    //    [self presentViewController:navi animated:YES completion:^{
    //    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
