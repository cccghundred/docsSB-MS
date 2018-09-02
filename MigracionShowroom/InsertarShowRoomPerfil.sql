ALTER procedure [ShowRoom].[InsertarShowRoomPerfil]
@NumeroPerfiles int,
@FormatoPerfiles varchar(50),
@EventoID int
as
begin
	declare @Contador int = 1
	declare @NumeroPerfil varchar(2) = ''
	while (@Contador <= @NumeroPerfiles)
	begin
		set @NumeroPerfil = RIGHT('0'+ convert(varchar(2),@Contador), 2)
		insert into ShowRoom.Perfil (PerfilDescripcion,EventoID)
		values (@FormatoPerfiles + @NumeroPerfil, @EventoId)
		set @Contador = @Contador + 1 
	end
end
