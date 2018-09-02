ALTER procedure [ShowRoom].[InsertShowRoomPersonalizacionNivel]
@EventoID int,
@PersonalizacionId int,
@NivelId int,
@CategoriaId int = 0,
@Valor varchar(200)
as
begin
insert into ShowRoom.PersonalizacionNivel (EventoID, PersonalizacionId, NivelId, CategoriaId, Valor)
values (@EventoID, @PersonalizacionId, @NivelId, @CategoriaId, @Valor)
end