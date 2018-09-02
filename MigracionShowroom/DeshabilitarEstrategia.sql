ALTER PROCEDURE [dbo].[DeshabilitarEstrategia]
	@EstrategiaID INT,
	@UsuarioModificacion VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON
		UPDATE Estrategia SET activo = 0, UsuarioModificacion = @UsuarioModificacion, FechaModificacion = GETDATE()  where estrategiaID = @EstrategiaID
	SET NOCOUNT OFF
END