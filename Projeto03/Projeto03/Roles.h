//
//  Roles.h
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Usuario.h"

@interface Roles : NSObject

@property Usuario *dono;
@property NSString *endereco;
@property NSString *descricao;
@property NSDate *data;
@property NSMutableArray *convidados; // mutable array de Usuario
@property BOOL publico;

- (id)initWithEndereco:(NSString *)endereco;

@end