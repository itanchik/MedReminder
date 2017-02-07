//
//  NewReminderViewController.swift
//  MedReminder
//
//  Created by Tanya Zhdanova on 04/02/2017.
//  Copyright © 2017 Tanya Zhdanova. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(NewReminderManager, NSObject)

RCT_EXTERN_METHOD(dismissPresentedViewController:(nonnull NSNumber *)reactTag)


RCT_EXTERN_METHOD(save:(nonnull NSNumber *)reactTag title:(NSString *)title time:(NSString *)time dosage:(NSString *)dosage appearance:(NSInteger *)appearance days:(NSInteger *)days forIdentifier:(NSInteger *)forIdentifier)

@end
