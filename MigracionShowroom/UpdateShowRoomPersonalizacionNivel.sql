ALTER procedure [ShowRoom].[UpdateShowRoomPersonalizacionNivel]
@PersonalizacionNivelId int,
@Valor varchar(200)
as
begin
update ShowRoom.PersonalizacionNivel
	set Valor = @Valor
where PersonalizacionNivelId = @PersonalizacionNivelId
end