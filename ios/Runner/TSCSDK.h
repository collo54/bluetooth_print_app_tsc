//
//  TSCSDK.h
//  TSCSDK
//
//  Created by Muta Huang on 14/1/28.
//  Copyright (c) 2014年 TSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h> //BLE
@interface TSCSDK : NSObject{
}
- (NSInteger) openport: (NSString*) destination;
- (NSInteger) openport_ethernet: (NSString*) destination;
- (NSInteger) openport_ethernet:(NSString*) destination
                     portnumber:(int) portnumber;
- (NSInteger) openport_ethernet_delay: (NSString*) destination
                     delay:(double)delay;
- (NSInteger) openportMFI;
- (NSInteger) openportMFI_delay: (double) delay;
- (NSInteger) openportMFI: (NSString*) MFIdestination;
- (NSInteger) openportMFI_delay: (NSString*) MFIdestination
               delay:(double)delay;
- (NSInteger) openportMFI_withname: (NSString*) MFIname;
- (NSInteger) openportMFI_withname: (NSString*) MFIname
                    delay:(double)delay;
- (NSMutableArray*)searchBLEDevice:(NSInteger)Seconds;
- (NSInteger) openport_ble:(CBPeripheral *)peripheral;
- (NSInteger) openport_ble:(CBPeripheral *)peripheral
                    delay:(double)delay;
- (NSInteger) closeport;
- (NSInteger) closeport:(double)delay;
- (NSInteger) closeport_withtime:(double)delay;
- (NSInteger) setup: (NSString*) width
                     height: (NSString*) height
                      speed: (NSString*) speed
                    density: (NSString*) density
                     sensor: (NSString*) sensor
                   vertical: (NSString*) vertical
                     offset: (NSString*) offset;
- (NSInteger) setup: (NSString*) width
                     height: (NSString*) height
                      speed: (NSString*) speed
                    density: (NSString*) density
                     sensor: (NSString*) sensor
                   vertical: (NSString*) vertical
                     offset: (NSString*) offset
                      delay: (double)delay;
- (NSInteger) setupForWidth: (NSString*) width
                height: (NSString*) height
                 speed: (NSString*) speed
               density: (NSString*) density
                sensor: (NSString*) sensor
              vertical: (NSString*) vertical
                offset: (NSString*) offset;
- (NSInteger) setupForWidth: (NSString*) width
                height: (NSString*) height
                 speed: (NSString*) speed
               density: (NSString*) density
                sensor: (NSString*) sensor
              vertical: (NSString*) vertical
                offset: (NSString*) offset
                 delay: (double)delay;
- (NSInteger) clearBuffer;
- (NSInteger) clearBuffer:(double)delay;
- (NSInteger) barcode: (NSString*) x
                         y: (NSString*) y
               barcodeType: (NSString*) type
                    height: (NSString*) height
                  readable: (NSString*) readable
                  rotation: (NSString*) rotation
                    narrow: (NSString*) narrow
                      wide: (NSString*) wide
                      code: (NSString*) code;
- (NSInteger) barcode: (NSString*) x
                         y: (NSString*) y
               barcodeType: (NSString*) type
                    height: (NSString*) height
                  readable: (NSString*) readable
                  rotation: (NSString*) rotation
                    narrow: (NSString*) narrow
                      wide: (NSString*) wide
                      code: (NSString*) code
                     delay: (double) delay;
- (NSInteger) barcodeFromX: (NSString*) x
                    y: (NSString*) y
          barcodeType: (NSString*) type
               height: (NSString*) height
             readable: (NSString*) readable
             rotation: (NSString*) rotation
               narrow: (NSString*) narrow
                 wide: (NSString*) wide
                 code: (NSString*) code;
- (NSInteger) barcodeFromX: (NSString*) x
                    y: (NSString*) y
          barcodeType: (NSString*) type
               height: (NSString*) height
             readable: (NSString*) readable
             rotation: (NSString*) rotation
               narrow: (NSString*) narrow
                 wide: (NSString*) wide
                 code: (NSString*) code
                delay: (double) delay;
- (NSInteger) printerfont: (NSString*) x
                             y: (NSString*) y
                      fontName: (NSString*) fontName
                      rotation: (NSString*) rotation
            magnificationRateX: (NSString*) xmul
            magnificationRateY: (NSString*) ymul
                       content: (NSString*) content;
- (NSInteger) printerfont: (NSString*) x
                             y: (NSString*) y
                      fontName: (NSString*) fontName
                      rotation: (NSString*) rotation
            magnificationRateX: (NSString*) xmul
            magnificationRateY: (NSString*) ymul
                       content: (NSString*) content
                         delay: (double) delay;
- (NSInteger) printerfontFromX: (NSString*) x
                        y: (NSString*) y
                 fontName: (NSString*) fontName
                 rotation: (NSString*) rotation
       magnificationRateX: (NSString*) xmul
       magnificationRateY: (NSString*) ymul
                  content: (NSString*) content;
- (NSInteger) printerfontFromX: (NSString*) x
                        y: (NSString*) y
                 fontName: (NSString*) fontName
                 rotation: (NSString*) rotation
       magnificationRateX: (NSString*) xmul
       magnificationRateY: (NSString*) ymul
                  content: (NSString*) content
                    delay: (double) delay;
- (NSInteger) printerfont_GB2321: (NSString*) x
                        y: (NSString*) y
                 fontName: (NSString*) fontName
                 rotation: (NSString*) rotation
       magnificationRateX: (NSString*) xmul
       magnificationRateY: (NSString*) ymul
                  content: (NSString*) content;
- (NSInteger) printerfont_GB2321: (NSString*) x
                          y: (NSString*) y
                   fontName: (NSString*) fontName
                   rotation: (NSString*) rotation
         magnificationRateX: (NSString*) xmul
         magnificationRateY: (NSString*) ymul
                    content: (NSString*) content
                      delay: (double) delay;
- (NSInteger) printerfont_BIG5: (NSString*) x
                          y: (NSString*) y
                   fontName: (NSString*) fontName
                   rotation: (NSString*) rotation
         magnificationRateX: (NSString*) xmul
         magnificationRateY: (NSString*) ymul
                    content: (NSString*) content;
- (NSInteger) printerfont_BIG5: (NSString*) x
                          y: (NSString*) y
                   fontName: (NSString*) fontName
                   rotation: (NSString*) rotation
         magnificationRateX: (NSString*) xmul
         magnificationRateY: (NSString*) ymul
                    content: (NSString*) content
                      delay: (double) delay;
- (NSInteger) printerfont_UTF8: (NSString*) x
                          y: (NSString*) y
                   fontName: (NSString*) fontName
                   rotation: (NSString*) rotation
         magnificationRateX: (NSString*) xmul
         magnificationRateY: (NSString*) ymul
                    content: (NSString*) content;
- (NSInteger) printerfont_UTF8: (NSString*) x
                          y: (NSString*) y
                   fontName: (NSString*) fontName
                   rotation: (NSString*) rotation
         magnificationRateX: (NSString*) xmul
         magnificationRateY: (NSString*) ymul
                    content: (NSString*) content
                      delay: (double) delay;
- (NSInteger) sendCommand: (NSString*) commandText;
- (NSInteger) sendCommand: (NSString*) commandText
               delay:(NSUInteger) delay;
- (NSInteger) sendCommand_utf8: (NSString*) commandText;
- (NSInteger) sendCommand_utf8: (NSString*) commandText
               delay:(NSUInteger) delay;
- (NSInteger) sendCommand_gb2312: (NSString*) commandText;
- (NSInteger) sendCommand_gb2312: (NSString*) commandText
                    delay:(NSUInteger) delay;
- (NSInteger) sendCommand_big5: (NSString*) commandText;
- (NSInteger) sendCommand_big5: (NSString*) commandText
                    delay:(NSUInteger) delay;
- (NSInteger) sendBinaryData: (NSData*) data;
- (NSInteger) sendCommandWithData: (NSData*) data;
- (NSInteger) sendCommandWithData: (NSData*) data
                       delay:(NSUInteger) delay;
- (NSInteger) printlabel: (NSString*) sets
                                  copies: (NSString*) copies;
- (NSInteger) printlabel: (NSString*) sets
                                  copies: (NSString*) copies
                                   delay: (double) delay;
- (NSInteger) printLabelWithNumberOfSets: (NSString*) sets
                             copies: (NSString*) copies;
- (NSInteger) printLabelWithNumberOfSets: (NSString*) sets
                             copies: (NSString*) copies
                              delay: (double) delay;
- (NSInteger) downloadPCX: (NSString*) srcPath
              asName: (NSString*) name;
- (NSInteger) downloadData: (NSData*) data
               asName: (NSString*) name;
- (NSInteger) sendfile: (NSString*) srcPath
              asName: (NSString*) name;
- (NSInteger) formfeed;
- (NSInteger) formfeed:(double)delay;
- (NSInteger) nobackfeed;
- (NSInteger) nobackfeed:(double)delay;
- (NSInteger) windowsfont: (int) x
                             y: (int) y
                        height: (int) height
                      rotation: (int) rotation
                         style: (int) style
                 withUnderline: (int) withUnderline
                      fontName: (NSString*) fontName
                       content: (NSString*) content;
- (NSInteger) windowsfont: (int) x
                             y: (int) y
                        height: (int) height
                      rotation: (int) rotation
                         style: (int) style
                 withUnderline: (int) withUnderline
                      fontName: (NSString*) fontName
                       content: (NSString*) content
                         delay: (double) delay;
- (NSInteger) windowsfontFromX: (int) x
                        y: (int) y
                   height: (int) height
                 rotation: (int) rotation
                    style: (int) style
            withUnderline: (int) withUnderline
                 fontName: (NSString*) fontName
                  content: (NSString*) content;
- (NSInteger) windowsfontFromX: (int) x
                        y: (int) y
                   height: (int) height
                 rotation: (int) rotation
                    style: (int) style
            withUnderline: (int) withUnderline
                 fontName: (NSString*) fontName
                  content: (NSString*) content
                    delay: (double) delay;
- (void) searchMFI;
-(NSData *) printer_name;
-(NSData *) printer_codepage;
-(NSData *) printer_mileage;
-(NSData *) printer_freememory;
-(NSData *) printer_files;
-(NSData *) printer_status;
-(NSData *) sendcommand_getstring: (NSString*)commandText;
-(NSData *) sendcommand_getstring: (NSString*)commandText
                            delay:(double)delay;
-(NSString *) BTMAC;
-(NSString *) WiFi_Default;
-(NSString *) WiFi_SSID:(NSString*)SSID;
-(NSString *) WiFi_WPA:(NSString*)WPA;
-(NSString *) WiFi_WEP:(NSInteger)number
                   WEP:(NSString*)WEP;
-(NSString *) WiFi_DHCP;
-(NSString *) WiFi_Port:(NSInteger)port;
-(NSString *) WiFi_StaticIP:(NSString*)IP
                       mask:(NSString*)mask
                    gateway:(NSString*)gateway;
-(int *) stream_status;
-(void) about;
- (NSString*) smartbattery_status:(NSInteger)index;
-(void) sendpicture_monochrome:(UIImage*)image
                           x_pos:(int)x_pos
                           y_pos:(int)y_pos;
-(void) sendpicture_monochrome:(UIImage*)image
                           x_pos:(int)x_pos
                           y_pos:(int)y_pos
                           delay:(double) delay;
-(void)sendpicture_halftone:(UIImage*)image
                            x_pos:(int)x_pos
                            y_pos:(int)y_pos;
-(void)sendpicture_halftone:(UIImage*)image
                            x_pos:(int)x_pos
                            y_pos:(int)y_pos
                            delay:(double) delay;
@end
