class RestaureBackupDb
	@bind: ()->

    $("#respaldo").on 'click', (evt) ->

      $.ajax "/db_backup_restore/backup.json",
        type: 'GET'
        dataType: 'json'
        error: (jqXHR, textStatus, errorThrown) ->
          swal 
            title:'Ha ocurrido un problema al intentar respaldar la base de datos'
            type: 'error'
        success: (data, textStatus, jqXHR) ->
          swal
            title: 'Ha respaldado la base de datos exitosamente'
            type: 'success' 

    $("#restaurar").on 'click', (evt) ->

      swal
        type: 'warning'
        title: '¿Esta seguro que desea restaurar la base de datos?'
        text: 'Los cambios realizado dentro de ella se perderan si no han sido guardados.'
        showCancelButton: true
        closeOnConfirm: false
        showLoaderOnConfirm: true
        ,() => 
          console.log 'aca'
          $.ajax "/db_backup_restore/restore.json",
            type: 'GET'
            dataType: 'json'
            error: (jqXHR, textStatus, errorThrown) ->
              swal 
                title:'Ha ocurrido un problema al intentar restaurar la base de datos'
                type: 'error'

            success: (data, textStatus, jqXHR) =>
              swal
                title: 'Ha restaurado la base de datos exitosamente'
                type: 'success' 

$ ()->
  RestaureBackupDb.bind()