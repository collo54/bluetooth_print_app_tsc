#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#include "TSCSDK.h"
//#include <TSCLIB/TSCLIB.h>

TSCSDK *lib = [TSCSDK new];
NSMutableArray* deviceList;
CBPeripheral* CP;
NSString *TargetName;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                          methodChannelWithName:@"samples.flutter.io/bluetooth"
                                          binaryMessenger:controller.binaryMessenger];
   
  __weak typeof(self) weakSelf = self;
  [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    // This method is invoked on the UI thread.
  if ([@"getBluetooth" isEqualToString:call.method]) {
    
    NSArray *args = call.arguments;
    if (![args isKindOfClass:[NSArray class]]) {
     return;
    }

    NSDictionary *firstArg = args[0];
    if (![firstArg isKindOfClass:[NSDictionary class]]) {
     return;
    }

     NSString *blePrinter = firstArg[@"mac"];
    if (![blePrinter isKindOfClass:[NSString class]]) {
     return;
    }

     NSDictionary *secondArg = args[1];
    if (![secondArg isKindOfClass:[NSDictionary class]]) {
     return;
    }

    NSString *printingstring = secondArg[@"print"];
    if (![printingstring isKindOfClass:[NSString class]]) {
     return;
    }

    [weakSelf viewLoad];
    [weakSelf tscTestPrint: blePrinter];
    int batteryLevel = [weakSelf getBatteryLevel];

    if (batteryLevel == -1) {
      result([FlutterError errorWithCode:@"UNAVAILABLE"
                                 message:@"Battery level not available."
                                 details:nil]);
    } else {
      result(@(batteryLevel));
    }
  } else {
    result(FlutterMethodNotImplemented);
  }
  }];

  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (int)getBatteryLevel {
  UIDevice* device = UIDevice.currentDevice;
  device.batteryMonitoringEnabled = YES;
  if (device.batteryState == UIDeviceBatteryStateUnknown) {
    return -1;
  } else {
    return (int)(device.batteryLevel * 100);
  }
}

- (void)viewLoad {
    //[super viewDidLoad];
    lib = [TSCSDK new];
    deviceList = [lib searchBLEDevice: 2];
}

//- (IBAction)send:(UIButton *)sender
- (void) tscTestPrint:(NSString *)myString {
    /*
    for(int i=0;i<deviceList.count;i++)
    {
        //NSLog(@"peripheral\n%@\n",deviceList[i]);
        if([((CBPeripheral *)deviceList[i]).name isEqualToString: myString])//BLE NAME
        {
            [lib openportBLE:((CBPeripheral *)deviceList[i])];
        }
    } */
    
    [lib openportMFI:@"com.issc.datapath"];
    //NSData *status = [lib printer_status];
    //0x00:Normal, 0x01:Head opened, 0x10:Pause
    
    [lib sendCommand:@"DIRECION 1\r\n"];
    [lib setup:@"100" height:@"120" speed:@"4" density:@"10" sensor:@"0" vertical:@"2" offset:@"0"];
    [lib sendCommand:@"SIZE 100 mm, 120 mm\r\n"];
    [lib sendCommand:@"SPEED 4\r\n"];
    [lib sendCommand:@"DENSITY 10\r\n"];
    [lib sendCommand:@"GAP 2 mm, 0 mm\r\n"];
    //[lib sendCommand:@"BLINE 2 mm, 0 mm\r\n"];
    
    [lib clearBuffer];
    
    //Using downloaded font to print text
    /*[lib sendCommand:@"CODEPAGE UTF-8\r\n"];
     [lib sendCommand_utf8:@"TEXT 30,30,\"ARIALUNI.TTF\",0,8,8,\"中文Englishにほンゴ한국어\"\r\n"];*/
    [lib sendCommand:@"TEXT 30,30,\"2\",0,2,2,\"1234567\"\r\n"];
    [lib printerfont:@"30" y:@"100" fontName:@"2" rotation:@"0" magnificationRateX:@"2" magnificationRateY:@"2" content:@"Printer Font Test works!"];
    //[lib windowsfont:30 y:170 height:32 rotation:0 style:0 withUnderline:0 fontName:@"Arial" content:@"中文Englishにほンゴ한국어"];
    //fontName: Please refer to "iosfonts.com"
    
    [lib barcode:@"30" y:@"300" barcodeType:@"39" height:@"70" readable:@"1" rotation:@"0" narrow:@"2" wide:@"6" code:@"12345"];
    
    //Download PCX
    /*NSBundle *mainBunle = [NSBundle mainBundle];
    NSString *absolutePath = [mainBunle pathForResource:@"UL" ofType:@"pcx"];
    [lib downloadPCX:absolutePath asName:@"UL.PCX"];
    [lib sendCommand:@"PUTPCX 300,250,\"UL.PCX\"\r\n"];*/
    
    [lib printlabel:@"1" copies:@"1"];
    
    [lib closeport:2.0];
    //[lib closeport:10.0]; //With Windowsfont
    //[lib closeport:30.0]; //With Windowsfont & downloadPCX
}

@end
