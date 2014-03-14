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

+ (ListaRoles *)lista
{
    static ListaRoles *lista = nil;
    if (!lista)
    {
        lista = [[super allocWithZone:nil] init];
    }
    
    return lista;
}

+ (id)allocWithZone: (struct _NSZone *)zone
{
    return [self lista];
}

- (id)init
{
    self = [super init];
    if (self) {
        listaDeUsuarios = [[NSMutableArray alloc] init];
        listaDeRoles = [[NSMutableArray alloc] init];
        _idUsuarios = 0;
        _idRoles = 0;
    }
    return self;
}

- (void)removeEndereco: (Role *)r
{
    [listaDeRoles removeObjectIdenticalTo:r];
}

// Gerenciamento de Usuários
- (int)adicionarUsuario:(NSString*)nome avatar:(UIImage*)avatar
{
    Usuario *user = [[Usuario alloc] init];
    user._nome = nome;
    user._avatar = avatar;
    user._id = _idUsuarios++;
    
    return _idUsuarios;
}
- (bool)removerUsuario:(int)idUsuario
{
    Usuario *user = [self getUsuarioPorId:idUsuario];
    
    if(user != nil)
    {
        [listaDeUsuarios removeObjectIdenticalTo:user];
        return true;
    }
    
    return false;
}
- (Usuario*)getUsuarioPorId:(int)idUsuario
{
    for(Usuario *usuario in listaDeUsuarios)
    {
        if(usuario._id == idUsuario)
        {
            return usuario;
        }
    }
    
    return nil;
}
- (int)atualizarUsuario:(Usuario*)usuario
{
    Usuario *usuarioAtual = [self getUsuarioPorId:usuario._id];
    
    if(usuarioAtual == nil)
    {
        return -1;
    }
    
    [usuarioAtual copiarCamposDe:usuario];
    
    return 0;
}


// Gerenciamento de Roles
- (int)adicionarRoleDo:(Usuario *)dono noEndereco:(Endereco *)endereco comDescricao:(NSString *)descricao naData:(NSDate *)data comConvidados:(NSMutableArray *)convidados sendoPublico:(BOOL)publico
{
    Role *novoRole = [[Role alloc] init];
    novoRole.dono = dono;
    novoRole.endereco = endereco;
    novoRole.descricao = descricao;
    novoRole.data = data;
    novoRole.convidados = convidados;
    novoRole.publico = publico;
    novoRole._id = _idRoles++;
    
    return novoRole._id;
}

- (bool)removerRole:(int)idRole
{
    Role *role = [self getRolePorId:idRole];
    
    if(role != nil)
    {
        [listaDeRoles removeObjectIdenticalTo:role];
        return true;
    }
    
    return false;
}

- (Role*)getRolePorId:(int)idRole
{
    for(Role *role in listaDeRoles)
    {
        if(role._id == idRole)
        {
            return role;
        }
    }
    
    return nil;
}

- (int)atualizarRole:(Role*)role
{
    Role *roleAtual = [self getRolePorId:role._id];
    
    if(roleAtual == nil)
    {
        return -1;
    }
    
    [roleAtual copiarCamposDe:role];
    
    return 0;
}

- (NSArray *)rolesDistando:(double)metros doLocal:(CLLocationCoordinate2D)origem
{
    NSMutableArray *roles = [[NSMutableArray alloc] init];
    
    for (Role *role in listaDeRoles)
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
