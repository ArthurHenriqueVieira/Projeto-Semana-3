//
//  ListaRoles.m
//  Projeto03
//
//  Created by ARTHUR HENRIQUE VIEIRA DE OLIVEIRA on 11/03/14.
//  Copyright (c) 2014 ARTHUR HENRIQUE VIEIRA DE OLIVEIRA. All rights reserved.
//

#import "ListaRoles.h"
#import "Endereco.h"

@implementation ListaRoles

+(ListaRoles *)lista
{
    static ListaRoles *lista = nil;
    if (!lista)
    {
        lista = [[super allocWithZone:nil] init];
    }
    
    return lista;
}

+(id)allocWithZone: (struct _NSZone *)zone
{
    return [self lista];
}

-(id)init
{
    self = [super init];
    if (self) {
        tudo = [[NSMutableArray alloc] init];
        _id = 0;
    }
    return self;
}

-(void)removeEndereco: (Role *)r
{
    [tudo removeObjectIdenticalTo:r];
}

-(int)adicionarRoleDo:(Usuario *)dono noEndereco:(Endereco *)endereco comDescricao:(NSString *)descricao naData:(NSDate *)data comConvidados:(NSMutableArray *)convidados sendoPublico:(BOOL)publico
{
    Role *novoRole = [[Role alloc] init];
    novoRole.dono = dono;
    novoRole.endereco = endereco;
    novoRole.descricao = descricao;
    novoRole.data = data;
    novoRole.convidados = convidados;
    novoRole.publico = publico;
    novoRole._id = _id++;
    
    return novoRole._id;
}

-(bool)removerRole:(int)idRole
{
    for (Role *role in tudo)
    {
        if (role._id == idRole)
        {
            [tudo removeObject:role];
            
            return true;
        }
    }
    
    return false;
}

-(NSArray *)rolesDistando:(double)metros doLocal:(CLLocationCoordinate2D)origem
{
    NSMutableArray *roles = [[NSMutableArray alloc] init];
    
    for (Role *role in tudo)
    {
        CLLocation *localA = [[CLLocation alloc] initWithLatitude:origem.latitude longitude:origem.longitude];
        CLLocation *localB = [[CLLocation alloc] initWithLatitude:[role.endereco _coord].latitude longitude:[role.endereco _coord].longitude];
        CLLocationDistance distancia = [localA distanceFromLocation:localB];
        
        if (distancia <= metros)
            [roles addObject:role];
    }
    
    return roles;
}

@end
