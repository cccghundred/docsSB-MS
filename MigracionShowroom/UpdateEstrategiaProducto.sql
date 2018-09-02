ALTER PROCEDURE [dbo].[UpdateEstrategiaProducto]
@EstrategiaId INT
,@CUV VARCHAR(20)
,@Precio MONEY
,@NombreProducto VARCHAR(150)
,@Descripcion1 VARCHAR(255)
,@ImagenProducto VARCHAR(150)
,@IdMarca TINYINT
,@Activo TINYINT
,@UsuarioModificacion VARCHAR(30)
AS
BEGIN
	UPDATE EstrategiaProducto
	SET  
		Precio = @Precio
		,NombreProducto = @NombreProducto
		,Descripcion1 = @Descripcion1
		,ImagenProducto = @ImagenProducto
		,IdMarca = @IdMarca
		,Activo = @Activo
		,UsuarioModificacion = @UsuarioModificacion
		,FechaModificacion = GETDATE()
	WHERE EstrategiaId = @EstrategiaId AND CUV = @CUV
END