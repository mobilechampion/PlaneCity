//

//
//  PlaneCity
//
//  Created by Louis Laurent on 5/28/15.
//  Copyright (c) 2015 GlennChiu. All rights reserved.


#import <UIKit/UIKit.h>

#import "JSQMessages.h"
#import "RNGridMenu.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface ChatView : JSQMessagesViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, RNGridMenuDelegate>
//-------------------------------------------------------------------------------------------------------------------------------------------------

- (id)initWith:(NSString *)groupId_;

@end
