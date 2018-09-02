ALTER procedure [ShowRoom].[GetShowRoomPersonalizacionNivel]
@EventoId int,
@NivelId int = 0,
@CategoriaId int = 0
as
begin
select 
	PersonalizacionNivelId,
	EventoID,
	PersonalizacionId,
	isnull(NivelId,0) as NivelId,
	isnull(CategoriaId,0) as CategoriaId,
	isnull(Valor,'') as Valor
from ShowRoom.PersonalizacionNivel
where
	EventoID = @EventoId
	and (@NivelId = 0 or NivelId = @NivelId)
	and (@CategoriaId = 0 or CategoriaId = @CategoriaId)
end