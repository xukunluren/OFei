//
//  waveViewController.m
//  OFei
//
//  Created by zey on 15/11/4.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "waveViewController.h"
#import "CustomTableView.h"
#import "threeTableViewCell.h"
#import "OFeiCommon.h"
#import <ArcGIS/ArcGIS.h>
#import "PellTableViewSelect.h"
#import "NormalViewController.h"
#import "dataAnaly.h"
#import "DiyTheme.h"



@interface waveViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,AGSWebMapDelegate,AGSMapViewLayerDelegate,AGSLayerDelegate,AGSMapViewTouchDelegate,CPTPlotSpaceDelegate,CPTScatterPlotDelegate>


    
    {
        
        double xl[KtableNum];//散点的x坐标
        double y1[KtableNum];//第1个散点图的y坐标
        
    }
    


@end

@implementation waveViewController
{
    AGSGraphicsLayer *_myGraphicsLayer;
    AGSMapView *_mapview;
    
    NSString *_title;
    UILabel *_titleLabel;
    NSMutableArray *_datetimeArray;
    NSMutableArray *_valueArray;
    NSMutableArray *_keduArray;
    NSMutableArray *_waveDirForTu;
    dataAnaly *_datAnaly;
    NSMutableArray *datasForPlot;
    UIImageView *_zoneA;
    NSMutableArray *_dataJQ;
    NSMutableArray *_similarLength;
    NSString *_publishTime;
    
    CGPoint _pointOfTouch;
    NSUInteger _indexOfSymbol;
    
    UILabel *detail;
    
    UILabel *releaseTime;
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
    //可变数组的初始化
    _datetimeArray = [[NSMutableArray alloc] init];
    _valueArray = [[NSMutableArray alloc] init];
    _keduArray = [[NSMutableArray alloc] init];
    _waveDirForTu = [[NSMutableArray alloc] init];
    _datAnaly = [[dataAnaly alloc] init];
    datasForPlot = [[NSMutableArray alloc] init];
    
    _dataJQ = [[NSMutableArray alloc]init];
    _similarLength = [[NSMutableArray alloc]init];

    _indexOfSymbol = 200;
    
    //设置背景图片
    [self setbackImage];
   
    _title = @"A点";

    self.tabBarController.tabBar.hidden = NO;
//    [self setMapView:_title];
    //显示详细；
    detail = [[UILabel alloc]initWithFrame:CGRectMake(40, KHight*0.4, KWight-40, 100)];
    detail.textColor = [UIColor blackColor];
    detail.font = [UIFont fontWithName:@"Arial" size:14];
    detail.textAlignment = NSTextAlignmentLeft;
    detail.numberOfLines = 0;
    //    detial.backgroundColor = [UIColor blackColor];
    //    detial.alpha = 0.4;
    //    detial.text = @"日期:  潮高(m):";
    [self.view addSubview:detail];
 
    [self setButton];
    [self setNavTitle:_title];
    [self initTableAndPicture];
    NSArray *dateArray1 = [self getDataFromNet:_title];
    [self setXY:dateArray1];
    [self setTextNoRefesh];
    
}


-(void)setbackImage
{
    
    CGRect mainView = [UIScreen mainScreen].bounds;
    //设置背景图片
    UIImageView  *imageView = [[UIImageView alloc] initWithFrame:mainView];
    imageView.image = [UIImage imageNamed:@"mainBackImage"];
    //        _imageView.alpha = 1;
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:imageView];
}

//- (void)viewWillDisappear:(BOOL)animated
//{
//    self.tabBarController.tabBar.hidden = YES;
//    
//}
-(void)setNavTitle:(NSString *)title
{
//    UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
//    select.frame = CGRectMake(15, 0, 40, 40);
//    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
//    [select addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//    label.backgroundColor = [UIColor clearColor];
//    label.frame = CGRectMake(0, 10, 40, 40);
//    label.font = [UIFont boldSystemFontOfSize:16.0];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor]; // change this color
//    _titleLabel = label;
//    _titleLabel.text = _title;
//    [_titleLabel sizeToFit];
//    [middle addSubview:select];
//    [middle addSubview:label];
//    
//    [label sizeToFit];
//    self.navigationItem.titleView = middle;
    UIButton *select = [UIButton buttonWithType:UIButtonTypeCustom];
    select.frame = CGRectMake(0, 0, 60, 40);
    _titleLabel.text = _title;
    [select setTitle:_title forState:UIControlStateNormal];
    select.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0,  0);
    [select setImage:[UIImage imageNamed:@"SortDown50@2x.png"] forState:UIControlStateNormal];
    select.imageEdgeInsets = UIEdgeInsetsMake(0,  0, 0, -60);
    [select addTarget:self action:@selector(selectPoint) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = select;
    
}

-(void)setButton
{
    
    UIButton *exampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton.frame = CGRectMake(0, 2, 30, 40);
    [exampleButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton setImage:[UIImage imageNamed:@"left-25.png"] forState:UIControlStateNormal];
    UIBarButtonItem *left= [[UIBarButtonItem alloc] initWithCustomView:exampleButton];
    
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *exampleButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    exampleButton1.frame = CGRectMake(0, 2, 30, 40);
//    [exampleButton1 addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    [exampleButton1 setImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];

    
}

#pragma 设置初始化图表控件----xk
-(void)initTableAndPicture

{
    
    graph = [[CPTXYGraph alloc] initWithFrame:self.view.bounds];
    //给画板添加一个主题
    DiyTheme *theme = [[DiyTheme alloc] init];
    [graph applyTheme:theme];
    
    /* 添加hostingView作为graph的容器，因为graph只能在这上面显示 */
    //创建主画板视图添加画板
    _hostView = [[CPTGraphHostingView alloc] initWithFrame:CGRectMake(0, 0.4*KHight, KWight, KHight*0.6-44)];
    _hostView.hostedGraph = graph;
    _hostView.alpha = 0.6;
    _hostView.collapsesLayers = NO;
    [self.view addSubview:_hostView];
    
    //设置留白
    graph.paddingLeft = 3;
    graph.paddingTop = 20;
    graph.paddingRight = 3;
    graph.paddingBottom = 10;
    
    graph.plotAreaFrame.paddingLeft = 30.0;
    graph.plotAreaFrame.paddingTop = 20.0;
    graph.plotAreaFrame.paddingRight = 5.0;
    graph.plotAreaFrame.paddingBottom = 20.0;
    //设置坐标范围
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    //允许用户交互
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0)   lengthDecimal:CPTDecimalFromFloat(15.0)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocationDecimal:CPTDecimalFromFloat(0.0) lengthDecimal:CPTDecimalFromFloat(3.0)];
    plotSpace.delegate = self;
    
    plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocation:@(0) length:@(80)];
    //            plotSpace.globalXRange = [CPTPlotRange plotRangeWithLocationDecimal];
    
    
    _waveTable = [[UITableView alloc] initWithFrame:CGRectMake(0+KWight, 0.4*KHight, KWight, KHight*0.6 - 44)];
    _waveTable.layer.cornerRadius = 10;
    _waveTable.layer.masksToBounds = YES;
    _waveTable.alpha = 0.6;
    [_waveTable setDelegate:self];
    _waveTable.backgroundColor = [UIColor clearColor];
    
    [_waveTable setDataSource:self];
    [self.view addSubview:_waveTable];
    
    
}

//设置XY轴的坐标样式
-(void)setXY:(NSArray *)dateArray
{
    
    //    // 1 - Create styles
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor blackColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 10.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 1.5f;
    axisLineStyle.lineColor = [CPTColor blackColor];
    CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
    axisTextStyle.color = [CPTColor blackColor];
    axisTextStyle.fontName = @"Helvetica-Bold";
    axisTextStyle.fontSize = 11.0f;
    CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
    tickLineStyle.lineColor = [CPTColor blackColor];
    tickLineStyle.lineWidth = 2.0f;
    CPTMutableLineStyle *gridLineStyle = [CPTMutableLineStyle lineStyle];
    gridLineStyle.lineColor = [CPTColor grayColor];
    gridLineStyle.lineWidth = 0.5f;
    // 2 - Get axis set
    CPTXYAxisSet *axisSet =(CPTXYAxisSet *)graph.axisSet;
    // 3 - Configure x-axis
    CPTAxis *X = axisSet.xAxis;
    X.title = @"DateTime";
    X.titleTextStyle = axisTitleStyle;
    X.titleOffset = 85.0f;
    X.axisLineStyle = axisLineStyle;
    X.labelingPolicy = CPTAxisLabelingPolicyNone;
    X.labelTextStyle = axisTextStyle;
    X.majorTickLineStyle = axisLineStyle;
    X.majorTickLength = 4.0f;
    X.tickDirection = CPTSignNegative;
    
    
    
    //构造MutableArray，用于存放自定义的轴标签
    NSMutableArray*customLabels = [NSMutableArray arrayWithCapacity:_valueArray.count];
    //构造一个TextStyle
    static CPTTextStyle*labelTextStyle=nil;
    labelTextStyle=[[CPTTextStyle alloc]init];
 
    NSString *text = @"nihao";
    NSString *labelText;
    //做判断，若缩放则展示的日期数据就3个，若不缩放则展示全部的数据
    for (int i=0;i<_valueArray.count;) {
        NSString *textdate = dateArray[i];
//        if ([[textdate substringToIndex:5] isEqualToString:text]) {
//            labelText = [textdate substringFromIndex:6];
//        }else{
            labelText = textdate;
            text = [textdate substringToIndex:6];
//        }
        if ([_dataJQ[i] isEqualToString:_publishTime]) {
            
            CPTAxisLabel *newLabel =[[CPTAxisLabel alloc] initWithText:text textStyle:labelTextStyle];
            //更改显示位置
            newLabel.tickLocation = @(i+_similarLength.count/2);
            newLabel.offset = 5;  //X.labelOffset + X.majorTickLength
            newLabel.rotation = 2*M_PI;
            [customLabels addObject:newLabel];
            [_keduArray addObject:[NSNumber numberWithInt:i]];
            
            i=i+_similarLength.count;
        }else{
        
        CPTAxisLabel *newLabel =[[CPTAxisLabel alloc] initWithText:text textStyle:labelTextStyle];
        
        newLabel.tickLocation = @(i+12);
        newLabel.offset = 5;//X.labelOffset + X.majorTickLength
        newLabel.rotation = 2*M_PI;
        [customLabels addObject:newLabel];
        [_keduArray addObject:[NSNumber numberWithInt:i]];
        i=i+24;
        
        }
    }

     X.majorTickLocations = [NSSet setWithArray:_keduArray];
    X.axisLabels =  [NSSet setWithArray:customLabels];
    
    
    
    //y轴
    CPTXYAxis *y =axisSet.yAxis;
    //y轴：不显示小刻度线
    y.minorTickLineStyle = nil;
    //大刻度线间距：50单位
    
    y.majorIntervalLength = @(0.5);
    y.orthogonalPosition = @(50);
    y.titleLocation = @(3.1);
    y.titleOffset = 0.f;
    //坐标原点：0
    y.titleRotation=2*M_PI;
    y.title= @"m";
    //    y.labelingPolicy = CPTAxisLabelingPolicyNone;
    //固定XY轴的显示位置，使其不随屏幕的滑动而移动
    axisSet.yAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    axisSet.xAxis.axisConstraints = [CPTConstraints constraintWithRelativeOffset:0.0];
    
    
    //    创建蓝色区域
    CPTScatterPlot *boundLinePlot = [[CPTScatterPlot alloc] init];
    boundLinePlot.plotSymbolMarginForHitDetection = 10.0f;
    boundLinePlot.delegate = self;

    //    设置绿色区域边框的样式
    CPTMutableLineStyle *lineStlye = [CPTMutableLineStyle lineStyle];
    
    
    
    lineStlye.miterLimit = 1.0f;
    lineStlye.lineWidth  = 1.0f;
    lineStlye.lineColor  = [CPTColor blackColor];
    boundLinePlot.dataLineStyle = lineStlye;
    boundLinePlot.identifier = @"Blue Plot";
     //设置数据源代理
    boundLinePlot.dataSource = self;
    [graph addPlot:boundLinePlot];
}


//获取网络数据
-(NSArray *)getDataFromNet:(NSString *)title
{
    
    NSLog(@"标题是===%@",title);
    NSURL *url = [self judgePoint:title];
    NSLog(@"url是===%@",url);
    //第一步，创建URL
    
    
    
    //第二步，通过URL创建网络请求
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
    //第三步，连接服务器
    
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:received options:NSJSONReadingMutableContainers error:nil];
    [_datetimeArray removeAllObjects];
    [_valueArray removeAllObjects];
    [_waveDirForTu removeAllObjects];
    [_dataJQ removeAllObjects];
    [datasForPlot removeAllObjects];
    
    NSString *pubtime = [array[0] objectForKey:@"publishtime"];
    NSString *pubtime1 = [pubtime substringToIndex:10];
    _publishTime = pubtime1;
//    for (NSDictionary *dic in array) {
//        
//        
//        NSString *dateString1 = [dic objectForKey:@"dataTime"];
//        NSString *dateString = [_datAnaly stringForAnaly:dateString1];
//        NSNumber *windspeed = [dic objectForKey:@"POWER"];
//        
//        NSNumber *winddir = [dic objectForKey:@"DIR"];
//        NSString *windDirecion =[_datAnaly judgeDirectionPower:winddir];
//        
//        
//        [_datetimeArray addObject:dateString];
//        [_valueArray addObject:windspeed];
//        [_waveDirForTu addObject:windDirecion];
//        [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:dateString,@"date",windspeed,@"speed",windDirecion,@"direct", nil]];
//        
//    }
    for (int i = 0; i<array.count; i++) {
        NSString *publishtime = [array[i] objectForKey:@"publishtime"];
        NSString *publishtime1 = [publishtime substringToIndex:10];
        if ([publishtime1 isEqualToString:pubtime1]) {
            NSString *dateString1 = [array[i] objectForKey:@"datatime"];
            NSString *jiequ = [dateString1 substringToIndex:10];
            if ([jiequ isEqualToString:publishtime1]) {
                [_similarLength addObject:jiequ];
            }
            NSString *dateString = [_datAnaly stringForAnaly:dateString1];
            NSNumber *windspeed = [array[i] objectForKey:@"power"];
            
            NSNumber *winddir = [array[i] objectForKey:@"dir"];
            NSString *windDirecion =[_datAnaly judgeDirectionPower:winddir];
            
            
            [_datetimeArray addObject:dateString];
            [_valueArray addObject:windspeed];
            [_waveDirForTu addObject:windDirecion];
            [_dataJQ addObject:jiequ];
            [datasForPlot addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:dateString,@"date",windspeed,@"speed",windDirecion,@"direct", nil]];
        }
    }
    
    
    
    for (int i=0; i<_valueArray.count; i++) {
        NSLog(@"你好-----%@",_valueArray[i]);
        
        NSString  *value = _valueArray[i];
        double yy = value.doubleValue;
        y1[i] = yy;
        xl[i] = i;
        NSLog(@"%@===%f",_datetimeArray[i],y1[i]);
    }
    return _datetimeArray;
    
}

//初始化不需要刷新的控件
-(void)setTextNoRefesh
{
//    UILabel *unitName = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.5, 0.15*KHight, 100, 40)];
//    unitName.text = @"国家海洋局";
//    unitName.textAlignment = UITextAlignmentCenter;
//    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:18];
//    [self.view addSubview:unitName];
//    UILabel *unitName1 = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.5, 0.2*KHight, 150, 40)];
//    unitName1.text = @"东海预报中心";
//    //    unitName1.textAlignment = NSTextAlignmentCenter;
//    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:18];
//    [self.view addSubview:unitName1];
//    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(KWight*0.5, 0.19*KHight, KWight*0.5, 0.2*KHight)];
//    label2.text = @"数据时间:2015-11-25 09:30";
//    label2.font = [UIFont systemFontOfSize:12.0];
//    label2.textColor = [UIColor blackColor];
//    [self.view addSubview:label2];
    
    UILabel *unitName = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.15, 0.08 *KHight, KWight*0.5, 0.2*KHight)];
    unitName.numberOfLines = 0;
    unitName.text = @"国家海洋局\n东海预报中心";
    unitName.textAlignment = UITextAlignmentCenter;
    unitName.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:16];
    [self.view addSubview:unitName];
    
    UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake(15,KHight*0.12,KWight*0.19,KWight*0.19)];
    logo.image=[UIImage imageNamed:@"LOGO.png"];
    [self.view addSubview:logo];
    
   releaseTime = [[UILabel alloc]initWithFrame:CGRectMake(KWight*0.05, KHight*0.2 , 200, 100)];
    //releaseTime.text = @"发布时间:2015-11-16 09:00";
    releaseTime.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:14];
    [self.view addSubview:releaseTime];
    
    //不要写死不要写死
    _zoneA = [[UIImageView alloc]initWithFrame:CGRectMake(KWight*0.58, 65, KWight*0.38, KWight*0.38)];
    _zoneA.layer.cornerRadius = 10.0;
    _zoneA.layer.masksToBounds = YES;
    _zoneA.image = [UIImage imageNamed:@"pointA"];
    [self.view addSubview:_zoneA];
    
    NSArray *arr = [[NSArray alloc]initWithObjects:@"图",@"表", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    //在没有设置[segment setApportionsSegmentWidthsByContent:YES]时，每个的宽度按segment的宽度平分
    segment.frame = CGRectMake(KWight*0.23,0.33 *KHight,KWight*0.625,KWight*0.125);
    //    [segment setBackgroundColor:[UIColor redColor]];
    //    [segment setTintColor:[UIColor whiteColor]];
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
    segment.tintColor = [UIColor colorWithRed:26/255.0 green:188/255.0 blue:156/255.0 alpha:1];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
}



-(void)segmentChange:(UISegmentedControl *)object
{
    int Index = (int)object.selectedSegmentIndex;
    NSLog(@"序号是多少=====%d",Index);
    switch (Index) {
        case 0:
            [self firstSegment];//调用firstsegment方法
            break;
        case 1:
            [self secondSegment];//
            break;
        default:
            break;
    }
    
}


- (void)firstSegment
{
    _waveTable.frame  = CGRectMake(0+KWight, 0.4*KHight,KWight,KHight*0.6-44);
    _waveTable.hidden  = YES;
    _hostView.frame = CGRectMake(0 ,0.4*KHight,KWight,KHight*0.6-44);
    graph.hidden = NO;
    detail.hidden = NO;
    _hostView.hidden = NO;
}

- (void)secondSegment
{
    
    _hostView.frame  = CGRectMake(0+ KWight,0.4*KHight,KWight,KHight*0.6-44);
    NSLog(@"%f",_hostView.frame.origin.x);
    _hostView.hidden  = YES;
    graph.hidden = YES;
    detail.hidden = YES;
    _waveTable.hidden = NO;
    _waveTable.frame = CGRectMake(0,0.4*KHight,KWight,KHight*0.6-44);
    
    NSLog(@"%f",_waveTable.frame.origin.x);
}



- (void)backHome
{
    NormalViewController *normal = [[NormalViewController alloc]init];
    [self.navigationController pushViewController:normal animated:NO];
}

-(void)selectPoint
{
    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:CGRectMake(self.view.bounds.size.width*0.4, 64, 100, 190) selectData:@[@"A点",@"B点",@"C点",@"D点"] action:^(NSInteger index) {
        //        PointViewController *point = [[PointViewController alloc] init];
        
        
        NSLog(@"您选择了%ld",(long)index);
        if (index == 0) {
            _title = @"A点";
            _zoneA.image = [UIImage imageNamed:@"pointA"];
        }
        if (index == 1) {
            _title = @"B点";
            _zoneA.image = [UIImage imageNamed:@"pointB"];
        }
        if (index == 2) {
            _title = @"C点";
            _zoneA.image = [UIImage imageNamed:@"pointC"];
        }
        if (index == 3) {
            _title = @"D点";
            _zoneA.image = [UIImage imageNamed:@"pointD"];
        }
        [self viewDidAppear:YES];
        NSLog(@"%@",_title);
        
        [self setNavTitle:_title];
//        [self setMapView:_title];
        [self judgePoint:_point];
        [_waveTable reloadData];
        [self getDataFromNet:_title];
        //NSArray *dateArray1 = [self getDataFromNet:_title];
        //NSLog(@"%@",dateArray1);
        //[self setXY:dateArray1];
        detail.text = @" ";
        _indexOfSymbol = 200;
        [graph reloadData];
    } animated:YES];
}

//返回
-(void)back{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)setMapView:(NSString *)title
{
    [AGSRuntimeEnvironment setClientID:@"kEpOhTfdwMTLW4St" error:nil];
    AGSMapView *mapview = [[AGSMapView alloc] initWithFrame:CGRectMake(5,60, KWight*0.45, 0.35*KHight-44)];
    mapview.layer.cornerRadius = 10;
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
    
    AGSSimpleMarkerSymbol *myMarkerSymbol1 =
    [AGSSimpleMarkerSymbol simpleMarkerSymbol];
    myMarkerSymbol1.color = [UIColor redColor];
    myMarkerSymbol1.outline.width = 3;
    
    
    AGSMutableMultipoint *multiPoint = [[AGSMutableMultipoint alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    
    AGSMutableMultipoint *multiPoint1 = [[AGSMutableMultipoint alloc] initWithSpatialReference:[AGSSpatialReference spatialReferenceWithWKID:4326 WKT:nil]];
    if ([title isEqualToString:@"A点"]) {
        [multiPoint1 addPoint: [AGSPoint pointWithX:120.9297 y:27.8633 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.9173 y:27.7844 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.8431 y:27.7236 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.7552 y:27.6640 spatialReference:nil]];
    }
    if ([title isEqualToString:@"B点"]) {
        [multiPoint addPoint: [AGSPoint pointWithX:120.9297 y:27.8633 spatialReference:nil]];
        [multiPoint1 addPoint: [AGSPoint pointWithX:120.9173 y:27.7844 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.8431 y:27.7236 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.7552 y:27.6640 spatialReference:nil]];
    }
    if ([title isEqualToString:@"C点"]) {
        [multiPoint addPoint: [AGSPoint pointWithX:120.9297 y:27.8633 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.9173 y:27.7844 spatialReference:nil]];
        [multiPoint1 addPoint: [AGSPoint pointWithX:120.8431 y:27.7236 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.7552 y:27.6640 spatialReference:nil]];
    }
    if ([title isEqualToString:@"D点"]) {
        [multiPoint addPoint: [AGSPoint pointWithX:120.9297 y:27.8633 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.9173 y:27.7844 spatialReference:nil]];
        [multiPoint addPoint: [AGSPoint pointWithX:120.8431 y:27.7236 spatialReference:nil]];
        [multiPoint1 addPoint: [AGSPoint pointWithX:120.7552 y:27.6640 spatialReference:nil]];
    }
    
    //用于设置当前点为红色
    AGSGraphic* myGraphic =
    [AGSGraphic graphicWithGeometry:multiPoint
                             symbol:myMarkerSymbol
                         attributes:nil];
    [_myGraphicsLayer addGraphic:myGraphic];
    
    AGSGraphic* myGraphic1 =
    [AGSGraphic graphicWithGeometry:multiPoint1
                             symbol:myMarkerSymbol1
                         attributes:nil];
    [_myGraphicsLayer addGraphic:myGraphic1];
    
    //设定地图初始化显示范围为中国
    AGSEnvelope *chinaEnv =[AGSEnvelope envelopeWithXmin:120.55707419812024
                                                    ymin:27.94215160670183
                                                    xmax:121.28245137296617
                                                    ymax:27.594495785487935
                                        spatialReference:mapview.spatialReference];
    [mapview zoomToEnvelope:chinaEnv animated:YES];
    
}
#pragma 设置滚动页面代码部分
-(void)createScrollView
{
    
    //scrollView   设置滚动页面
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.4*KHight, KWight, KHight*0.6-44 )];
    
    //设置分页、弹簧效果、水平滚动条、滚动区域大小
    [_scrollView setPagingEnabled:YES];
    [_scrollView setBounces:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width * 2, _scrollView.bounds.size.height)];
    [_scrollView setDelegate:self];
    
    //分页控件
    NSInteger pages = 2;
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0.4*KHight, KWight, KHight)];
    NSLog(@"%f",self.view.frame.size.height-self.view.frame.size.height/10);
    pageControl.numberOfPages = pages;
    [pageControl setCenter:CGPointMake(KWight/2, KHight-50)];
    pageControl.currentPage = 0;
    [pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
    [pageControl setPageIndicatorTintColor:[UIColor blueColor]];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    [self createPages:pages];
    [self.view addSubview:_scrollView];
    
}

//设置页面
- (void)createPages:(NSInteger)pages {
    for (int i = 0; i < pages; i++) {
        
        if (i == 0) {
            _waveTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWight, KHight) style:UITableViewStylePlain];
            _waveTable.layer.cornerRadius = 10;
            _waveTable.layer.masksToBounds = YES;
            _waveTable.alpha = 0.4;
            [_waveTable setDelegate:self];
            
            [_waveTable setDataSource:self];
            
            [_scrollView addSubview:_waveTable];
            
        }else if (i == 1){
            _picture = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i,0,self.view.frame.size.width,self.view.frame.size.height)];
            _picture.alpha = 0.4;
            _picture.backgroundColor = [UIColor yellowColor];
            [_scrollView addSubview:_picture];
            
        }
        
    }
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"123123");
    NSUInteger pageNo = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    [self.pageControl setCurrentPage:pageNo];
}



#pragma 对表头进行设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewaa = [[UIView alloc] init];
    viewaa.backgroundColor = KTextColor;
    viewaa.backgroundColor = [UIColor groupTableViewBackgroundColor];
    

    //添加表格第一行日期、数据等信息
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, 0.3*KWight, 40)];
    [dateLabel setText:@"日期"];
    [dateLabel setFont:[UIFont systemFontOfSize:12.0]];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:dateLabel];
    
    UILabel *fensuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.4*KWight,0, 0.3*KWight, 40)];
    [fensuLabel setText:@"浪高（m）"];
    [fensuLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fensuLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fensuLabel];
    
    UILabel *fengliLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*KWight, 0, 0.3*KWight, 40)];
    [fengliLabel setText:@"浪向"];
    [fengliLabel setFont:[UIFont systemFontOfSize:12.0]];
    [fengliLabel setTextAlignment:NSTextAlignmentCenter];
    [viewaa addSubview:fengliLabel];
    
    return viewaa;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datetimeArray.count;
}



-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TableViewCell";
    //自定义cell类
    threeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"threeTableViewCell" owner:self options:nil] lastObject];
    }
    
    //在该方法中设置每行内容
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

#pragma 对表中每一行需要填充的内容进行设置------xk
- (void)configureCell:(threeTableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"标题是===%@",_title);
    NSURL *url = [self judgePoint:_title];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //异步链接(形式1,较少用)
    [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *dateArray = [[NSMutableArray alloc] init];
        NSMutableArray *windHighArray = [[NSMutableArray alloc] init];
        NSMutableArray *windDirection = [[NSMutableArray alloc] init];
        
        NSString *pubtime = [array[0] objectForKey:@"publishtime"];
        NSString *pubtime2=[pubtime substringToIndex:16];
        releaseTime.text= [NSString stringWithFormat:@"发布时间:%@",pubtime2];
        NSString *pubtime1 = [pubtime substringToIndex:10];
        
        
//        for (NSDictionary *dic in array) {
//            
//            
//            NSString *dateString1 = [dic objectForKey:@"dataTime"];
//           
//            NSNumber *windhigh1 = [dic objectForKey:@"POWER"];
//            CGFloat windhigh2 = [windhigh1 doubleValue];
//            NSString *windhigh = [NSString stringWithFormat:@"%.2f",windhigh2];
//            
//            NSNumber *winddir = [dic objectForKey:@"DIR"];
//          
//            NSString *windDirecion = [_datAnaly judgeDirectionPower:winddir];
//            NSString *dateString = [_datAnaly stringForAnaly:dateString1];
//            
//            
//            
//            [dateArray addObject:dateString];
//            [windHighArray addObject:windhigh];
//            [windDirection addObject:windDirecion];
//            
//        }
        
        for (int i = 0; i<array.count; i++) {
            NSString *publishtime = [array[i] objectForKey:@"publishtime"];
            NSString *publishtime1 = [publishtime substringToIndex:10];
            if ([publishtime1 isEqualToString:pubtime1]) {
                NSString *dateString1 = [array[i] objectForKey:@"datatime"];
                
                NSNumber *windhigh1 = [array[i] objectForKey:@"power"];
                CGFloat windhigh2 = [windhigh1 doubleValue];
                NSString *windhigh = [NSString stringWithFormat:@"%.2f",windhigh2];
                
                NSNumber *winddir = [array[i] objectForKey:@"dir"];
                
                NSString *windDirecion = [_datAnaly judgeDirectionPower:winddir];
                NSString *dateString = [_datAnaly stringForAnaly:dateString1];
                
                
                
                [dateArray addObject:dateString];
                [windHighArray addObject:windhigh];
                [windDirection addObject:windDirecion];
                
            }
            
            
            
        }
        
        cell.data1.text = dateArray[indexPath.row];
        cell.data2.text = windHighArray[indexPath.row];
        cell.data3.text = windDirection[indexPath.row];
        NSLog(@"数据大小是多少：%lu",(unsigned long)dateArray.count);
    }];
}

#pragma 判断点位
-(NSURL *)judgePoint:(NSString *)point
{
    NSURL *url;
    if ([point isEqualToString:@"A点"]) {
        url= [NSURL URLWithString:@KPointwaveA];
    }
    if ([point isEqualToString:@"B点"]) {
        url= [NSURL URLWithString:@KPointwaveB];
    }
    if ([point isEqualToString:@"C点"]) {
        url= [NSURL URLWithString:@KPointwaveC];
    }
    if ([point isEqualToString:@"D点"]) {
        url= [NSURL URLWithString:@KPointwaveD];
    }
    return url;
}



//代理函数
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return _valueArray.count;
}

//每个点的数据是什么
-(double*)doublesForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndexRange:(NSRange)indexRange{
    
    //返回类型：一个double指针（数组）
    double *values = NULL;
    
    switch (fieldEnum){
            //如果请求的数据是散点x坐标,直接返回x坐标（两个图形是一样的），否则还要进一步判断是那个图形
        case CPTScatterPlotFieldX:
            values= xl ;
            break;
        case CPTScatterPlotFieldY:
            //如果请求的数据是散点y坐标，则对于图形1，使用y1数组，对于图形2，使用y2数组
            values=y1;
            break;
    }
    //数组指针右移个indexRage.location单位，则数组截去indexRage.location个元素
    return values+indexRange.location ;
}


//添加箭头部分
-(CPTPlotSymbol *)symbolForScatterPlot:(CPTScatterPlot *)plot
                           recordIndex:(NSUInteger)index
{
    NSLog(@"%@",_waveDirForTu[index]);
    NSLog(@"%lu",(unsigned long)_indexOfSymbol);
    
    CPTMutableLineStyle * symbolLineStyle = [CPTMutableLineStyle lineStyle];
    
    symbolLineStyle.lineColor = [CPTColor clearColor];
    
    symbolLineStyle.lineWidth = 1.0;
    
    CPTPlotSymbol * plotSymbol = [CPTPlotSymbol  ellipsePlotSymbol];
    
    if ([_waveDirForTu[index] isEqualToString:@"E"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"E-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"ENE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"ENE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"ESE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"ESE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"N"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"N-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"NE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"NNE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NNE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"NNW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NNW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"NW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"NW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"S"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"S-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"SE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"SSE"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SSE-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"SSW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SSW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"SW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"SW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"W"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"W-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"WNW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"WNW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }else if ([_waveDirForTu[index] isEqualToString:@"WSW"]) {
        
        CPTImage *image = [CPTImage imageNamed:@"WSW-15.png"];
        
        plotSymbol.fill = [CPTFill fillWithImage:image];
        
        plotSymbol.lineStyle = symbolLineStyle;
    }
    
    if (_indexOfSymbol == index) {
        
        plotSymbol.fill = [CPTFill fillWithColor:[CPTColor redColor]];
    }
    
    plotSymbol.size = CGSizeMake(15.0,15.0);
    
    return plotSymbol;
}
//添加数据标签
-(CPTLayer*)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    //定义一个白色的TextStyle
    static CPTTextStyle *whiteText= nil;
    
    if (!whiteText ) {
        whiteText= [[CPTTextStyle alloc] init];
        
        //        whiteText.color = [CPTColor whiteColor];
    }
    //定义一个TextLayer
    CPTTextLayer *newLayer =nil;
    
    //    NSString*identifier=(NSString*)[plot identifier];
    NSLog(@"-----------%f",y1[index]);
    if (index%3 == 0) {
//        newLayer= [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%.2f", y1[index]] style:whiteText];
    }
    return newLayer;
}
-(CPTPlotRange *)plotSpace:(CPTPlotSpace *)space
     willChangePlotRangeTo:(CPTPlotRange *)newRange
             forCoordinate:(CPTCoordinate)coordinate{
    //限制缩放和移动的时候。不超过原始范围
    //    if ( coordinate == CPTCoordinateX)
    //    {
    //        if ([ _xPlotRange containsRange:newRange])
    //        {
    //            //如果缩放范围在 原始范围内。则返回缩放范围
    //            return newRange;
    //
    //        }else if([newRange containsRange:_xPlotRange])
    //        {
    //            //如果缩放范围在原始范围外，则返回原始范围
    //            return _xPlotRange;
    //        }
    //        return newRange;
    //    }else{
    //        return _yPlotRange;
    //    }
    
    if (coordinate == CPTCoordinateY)
    {
        newRange = ((CPTXYPlotSpace*)space).yRange;
    }
    //    if (coordinate == CPTCoordinateX) {
    //        newRange = ((CPTXYPlotSpace*)space).xRange;
    //    }
    NSLog(@"Plot changes %@", newRange);
    return newRange;
    
}


//#pragma mark -
//#pragma mark Rotation
//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return  YES;
//}
//-(BOOL)shouldAutorotate
//{
//    return YES;
//}

#pragma mark -
#pragma mark CPTPlotSpaceDelegate methods
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceCancelledEvent:(UIEvent *)event
{
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceUpEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDownEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    NSLog(@"you putdown at point:%@",[NSValue valueWithCGPoint:point]);
    _pointOfTouch = point;
    return YES;
}
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDraggedEvent:(UIEvent *)event atPoint:(CGPoint)point
{
    return YES;
}


#pragma mark -
#pragma mark CPTScatterPlotDelegate
//当我们选择相应的点时，弹出注释：
-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolWasSelectedAtRecordIndex:(NSUInteger)idx withEvent:(UIEvent *)event
{
    _indexOfSymbol = idx;
    
    if (symbolTextAnnotation ) {
        [graph.plotAreaFrame.plotArea removeAnnotation:symbolTextAnnotation];
        symbolTextAnnotation = nil;
    }
    // Setup a style for the annotation
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
//    hitAnnotationTextStyle.color    = [CPTColor colorWithComponentRed:26 green:188 blue:156 alpha:1];
    hitAnnotationTextStyle.color = [CPTColor blackColor];

    
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    // Determine point of symbol in plot coordinates
    NSNumber *x          =
    [[datasForPlot objectAtIndex:idx] valueForKey:@"date"];
    NSNumber *y          = [[datasForPlot objectAtIndex:idx] valueForKey:@"speed"];
    CGFloat y1 = [y doubleValue];
    NSString *date = [[datasForPlot objectAtIndex:idx]valueForKey:@"direct"];
    
    NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
    // Add annotation
    // First make a string for the y value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:3];
    NSString *yString = [formatter stringFromNumber:y];
    NSString *myString = [NSString stringWithFormat:@"日期：%@\n浪高：%.2f\n浪向：%@",x,y1,date];
    detail.text = myString;
    // Now add the annotation to the plot area
//    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:myString/*yString*/ style:hitAnnotationTextStyle];
//    symbolTextAnnotation              = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:graph.defaultPlotSpace anchorPlotPoint:anchorPoint];
//    symbolTextAnnotation.contentLayer = textLayer;
//    
//    if (idx>50) {
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20) - 100;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,30.0);
//    }else{
//        float viewWidth=_hostView.frame.size.width ;
//        float coorX = idx*(viewWidth/20) - 0.4*viewWidth;
//        symbolTextAnnotation.displacement = CGPointMake(coorX,30.0);
//        
//    }
//    
//    [graph.plotAreaFrame.plotArea addAnnotation:symbolTextAnnotation];
    [graph reloadData];
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
