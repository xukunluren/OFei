//
//  OFeiCommon.h
//  OFei
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 xukun. All rights reserved.
//

#ifndef OFeiCommon_h
#define OFeiCommon_h

//#define BarColor         [UIColor colorWithRed:0.f green:166.f/255.f blue:240.f/255.f alpha:1.f] //#00a6f0

#define MENU_POPOVER_FRAME  CGRectMake(8, 0, 140, 88)


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

#define kDockHeight 44
#define DockColor   [UIColor colorWithRed:0.f green:166.f/255.f blue:240.f/255.f alpha:1.f]

#define DockColor   [UIColor colorWithRed:0.f green:166.f/255.f blue:240.f/255.f alpha:1.f]

//
#define  KTextColor  [UIColor colorWithRed:26.f/255.f green:188.f/255.f blue:156.f/255.f alpha:1.f]

#define kDockHeight 44
#define DockColor   [UIColor colorWithRed:0.f green:166.f/255.f blue:240.f/255.f alpha:1.f]

#define KDockHeight 44
#define KkeyWordColor   [UIColor colorWithRed:0.f green:166.f/255.f blue:240.f/255.f alpha:1.f]
#define KWight self.view.frame.size.width
#define KHight self.view.frame.size.height
#define KNaviHight self.navigationController.navigationBar.frame.size.height

////点预报中风数据获取路径
//#define KPointwind "http://10.200.21.14:8080/OFT/GetTBVECGRIDWIND"
//#define KPointwindA  "http://10.200.21.14:8080/OFT/GetTBVECGRIDWIND_A"
//#define KPointwindB  "http://10.200.21.14:8080/OFT/GetTBVECGRIDWIND_B"
//#define KPointwindC  "http://10.200.21.14:8080/OFT/GetTBVECGRIDWIND_C"
//#define KPointwindD  "http://10.200.21.14:8080/OFT/GetTBVECGRIDWIND_D"
//
////点预报中浪数据获取路径
//#define KPointwave " http://10.200.21.14:8080/OFT/GetTBVECGRIDWAVE"
//#define KPointwaveA "http://10.200.21.14:8080/OFT/GetTBVECGRIDWAVE_A"
//#define KPointwaveB "http://10.200.21.14:8080/OFT/GetTBVECGRIDWAVE_B"
//#define KPointwaveC "http://10.200.21.14:8080/OFT/GetTBVECGRIDWAVE_C"
//#define KPointwaveD "http://10.200.21.14:8080/OFT/GetTBVECGRIDWAVE_D"
//
////点预报中流数据获取路径
//#define KPointcurrent "http://10.200.21.14:8080/OFT/GetTBVECGRIDCURRENT"
//#define KPointcurrentA "http://10.200.21.14:8080/OFT/GetTBVECGRIDCURRENT_A"
//#define KPointcurrentB "http://10.200.21.14:8080/OFT/GetTBVECGRIDCURRENT_B"
//#define KPointcurrentC "http://10.200.21.14:8080/OFT/GetTBVECGRIDCURRENT_C"
//#define KPointcurrentD "http://10.200.21.14:8080/OFT/GetTBVECGRIDCURRENT_D"
//
////点预报中短潮数据获取路径
//#define KPointSTideA "http://10.200.21.14:8080/OFT/GetTBRASGRID_A_S"
//#define KPointSTideB "http://10.200.21.14:8080/OFT/GetTBRASGRID_B_S"
//#define KPointSTideC "http://10.200.21.14:8080/OFT/GetTBRASGRID_C_S"
//#define KPointSTideD "http://10.200.21.14:8080/OFT/GetTBRASGRID_D_S"
//
////点预报中长潮数据获取路径
//#define KPointLTideA "http://10.200.21.14:8080/OFT/GetTBRASGRID_A_L"
//#define KPointLTideB "http://10.200.21.14:8080/OFT/GetTBRASGRID_B_L"
//#define KPointLTideC "http://10.200.21.14:8080/OFT/GetTBRASGRID_C_L"
//#define KPointLTideD "http://10.200.21.14:8080/OFT/GetTBRASGRID_D_L"
//
////分区预报连接
//#define urlZoneA24 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_A24"
//#define urlZoneA48 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_A48"
//#define urlZoneA72 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_A72"
//
//#define urlZoneB24 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_B24"
//#define urlZoneB48 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_B48"
//#define urlZoneB72 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_B72"
//
//#define urlZoneC24 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_C24"
//#define urlZoneC48 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_C48"
//#define urlZoneC72 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_C72"
//
//#define urlZoneD24 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_D24"
//#define urlZoneD48 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_D48"
//#define urlZoneD72 @"http://10.200.21.14:8080/OFT/GetTBSEAVECGRID_D72"

//分区预报 外部
//#define KmapZoneA @"http://202.121.66.51:8080/arcgis/rest/services/zoneA/MapServer"
//#define KmapZoneB @"http://202.121.66.51:8080/arcgis/rest/services/zoneB/MapServer"
//#define KmapZoneC @"http://202.121.66.51:8080/arcgis/rest/services/zoneC/MapServer"
//#define KmapZoneD @"http://202.121.66.51:8080/arcgis/rest/services/zoneD/MapServer"

//分区预报  内部
#define KmapZoneA @"http://10.200.21.14:6080/arcgis/rest/services/zoneA/MapServer"
#define KmapZoneB @"http://10.200.21.14:6080/arcgis/rest/services/zoneB/MapServer"
#define KmapZoneC @"http://10.200.21.14:6080/arcgis/rest/services/zoneC/MapServer"
#define KmapZoneD @"http://10.200.21.14:6080/arcgis/rest/services/zoneD/MapServer"

//点预报中风数据获取路径
#define KPointwind "http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND"
#define KPointwindA  "http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_A"
#define KPointwindB  "http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_B"
#define KPointwindC  "http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_C"
#define KPointwindD  "http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_D"

//点预报中浪数据获取路径
#define KPointwave "http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE"
#define KPointwaveA "http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_A"
#define KPointwaveB "http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_B"
#define KPointwaveC "http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_C"
#define KPointwaveD "http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_D"

//点预报中流数据获取路径
#define KPointcurrent "http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT"
#define KPointcurrentA "http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_A"
#define KPointcurrentB "http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_B"
#define KPointcurrentC "http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_C"
#define KPointcurrentD "http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_D"

//点预报中短潮数据获取路径
#define KPointSTideA "http://202.121.66.51:8080/OFT/GetTBRASGRID_A_S"
#define KPointSTideB "http://202.121.66.51:8080/OFT/GetTBRASGRID_B_S"
#define KPointSTideC "http://202.121.66.51:8080/OFT/GetTBRASGRID_C_S"
#define KPointSTideD "http://202.121.66.51:8080/OFT/GetTBRASGRID_D_S"

//点预报中长潮数据获取路径
#define KPointLTideA "http://202.121.66.51:8080/OFT/GetTBRASGRID_A_L"
#define KPointLTideB "http://202.121.66.51:8080/OFT/GetTBRASGRID_B_L"
#define KPointLTideC "http://202.121.66.51:8080/OFT/GetTBRASGRID_C_L"
#define KPointLTideD "http://202.121.66.51:8080/OFT/GetTBRASGRID_D_L"

//分区预报连接
#define urlZoneA24 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_A24"
#define urlZoneA48 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_A48"
#define urlZoneA72 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_A72"

#define urlZoneB24 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_B24"
#define urlZoneB48 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_B48"
#define urlZoneB72 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_B72"

#define urlZoneC24 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_C24"
#define urlZoneC48 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_C48"
#define urlZoneC72 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_C72"

#define urlZoneD24 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_D24"
#define urlZoneD48 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_D48"
#define urlZoneD72 @"http://202.121.66.51:8080/OFT/GetTBSEAVECGRID_D72"

//航线预报--潮位
#define KRouteTideP1 @"http://202.121.66.51:8080/OFT/GetTBRASGRID_P1"
#define KRouteTideP2 @"http://202.121.66.51:8080/OFT/GetTBRASGRID_P2"
#define KRouteTideP3 @"http://202.121.66.51:8080/OFT/GetTBRASGRID_P3"
#define KRouteTideP4 @"http://202.121.66.51:8080/OFT/GetTBRASGRID_P4"

//航线预报--风
#define KRouteWindP1 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_P1"
#define KRouteWindP2 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_P2"
#define KRouteWindP3 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_P3"
#define KRouteWindP4 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWIND_P4"

//航线预报--浪
#define KRouteWaveP1 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_P1"
#define KRouteWaveP2 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_P2"
#define KRouteWaveP3 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_P3"
#define KRouteWaveP4 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDWAVE_P4"

//航线预报--流
#define KRouteFlowP1 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_P1"
#define KRouteFlowP2 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_P2"
#define KRouteFlowP3 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_P3"
#define KRouteFlowP4 @"http://202.121.66.51:8080/OFT/GetTBVECGRIDCURRENT_P4"


//地图服务数据
#define KMainMap @"http://101.231.140.173:6081/arcgis/rest/services/BaseMap/MapServer"
#define KmapZone @"http://101.231.140.173:6081/arcgis/rest/services/zoneOfei/MapServer"
#define KPointTableHight 40

//常规预报
#define Knrmal @"http://202.121.66.51:8080/OFT/GetTBFORECASTCONTENTS_OFT"
#define Knormal24 @"http://202.121.66.51:8080/OFT/GetTBFORECASTCONTENTS_OFT24"
#define Knormal48 @"http://202.121.66.51:8080/OFT/GetTBFORECASTCONTENTS_OFT48"
#define Knormal72 @"http://202.121.66.51:8080/OFT/GetTBFORECASTCONTENTS_OFT72"


#define KtableNum 100


//瓯飞Web端页面地址 ：http://xxs.dhybzx.org:8003/Map/Map.aspx?ur=1&sysid=5&ln=admin&up=c476828335d08283a50682832367f1c63bce35d0&ilp=1&randomNumber=922

#endif /* OFeiCommon_h */
