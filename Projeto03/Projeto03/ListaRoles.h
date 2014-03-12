//
//  ListaRoles.h
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Role.h"

@interface ListaRoles : NSObject
{
    NSMutableArray *tudo;
}

+(ListaRoles *) lista;

-(NSArray *) rolesDistando:(double)metros doLocal:(CLLocationCoordinate2D)origem;

@end
