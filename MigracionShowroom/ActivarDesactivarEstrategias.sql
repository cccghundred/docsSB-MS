ALTER PROCEDURE [dbo].[ActivarDesactivarEstrategias] @UsuarioModificacion VARCHAR(100)
	,@EstrategiasActivas VARCHAR(500)
	,@EstrategiasDesactivas VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @resultado INT = 0
	DECLARE @TipoEstrategia NVARCHAR(90)

	SELECT @TipoEstrategia = TipoEstrategia.DescripcionEstrategia
	FROM estrategia
	INNER JOIN TipoEstrategia ON estrategia.Tipoestrategiaid = TipoEstrategia.Tipoestrategiaid
	WHERE estrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
			
			UNION
			
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)

	SELECT DISTINCT E.EstrategiaID
	INTO #ESTRATEGIASNOACTIVAS
	FROM Estrategia E
	WHERE E.EstrategiaID IN (
			SELECT splitdata
			FROM dbo.fnSplitString(@EstrategiasActivas, ',')
			)
		AND (
			(
				E.LimiteVenta IS NULL
				OR E.LimiteVenta = 0
				)
			OR (
				E.ImagenURL IS NULL
				OR E.ImagenURL = ''
				)
			)

	SELECT splitdata
	INTO #ESTRATEGIASACTIVAR
	FROM dbo.fnSplitString(@EstrategiasActivas, ',') EA
	WHERE EA.splitdata NOT IN (
			SELECT EstrategiaID
			FROM #ESTRATEGIASNOACTIVAS
			)

	IF (@TipoEstrategia != 'ShowRoom')
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM #ESTRATEGIASACTIVAR
					)
		END

		SELECT @resultado = COUNT(*)
		FROM #ESTRATEGIASNOACTIVAS
	END
	ELSE
	BEGIN
		-- Activar
		IF (
				(
					SELECT count(splitdata)
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					) > 0
				)
		BEGIN
			UPDATE Estrategia
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)

			UPDATE EstrategiaProducto
			SET activo = 1
				,UsuarioModificacion = @UsuarioModificacion
				,FechaModificacion = GETDATE()
			WHERE activo !=1 AND estrategiaID IN (
					SELECT splitdata
					FROM dbo.fnSplitString(@EstrategiasActivas, ',')
					)
		END

		SET @resultado = 0
	END

	-- Desactivar
	IF (
			(
				SELECT count(splitdata)
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				) > 0
			)
	BEGIN
		UPDATE Estrategia
		SET activo = 0
			,UsuarioModificacion = @UsuarioModificacion
			,FechaModificacion = GETDATE()
		WHERE estrategiaID IN (
				SELECT splitdata
				FROM dbo.fnSplitString(@EstrategiasDesactivas, ',')
				)
	END

	SELECT @resultado

	SET NOCOUNT OFF
END
