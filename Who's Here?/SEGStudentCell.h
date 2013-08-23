//
//  SEGStudentCell.h
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/12/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEGStudentCell : UITableViewCell {
    @public
    bool untouched;
}

@property (weak, nonatomic) IBOutlet UILabel *studentName;
@property (weak, nonatomic) IBOutlet UILabel *studentAttendance;

@end
