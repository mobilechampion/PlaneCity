//
// RECommonFunctions.h
// REFrostedViewController
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.

//

#import <Foundation/Foundation.h>

#ifndef REUIKitIsFlatMode
#define REUIKitIsFlatMode() REFrostedViewControllerUIKitIsFlatMode()
#endif

BOOL REFrostedViewControllerUIKitIsFlatMode(void);