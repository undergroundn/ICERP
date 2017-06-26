$(document).ready(function () {
    ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerTiposConsultorios", null, "crearTablaTipoConsultorios");

    $("#btnRegistrarTipoConsultorio").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('registrarTipoConsultorio');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarTipoConsultorio');
            ev.preventDefault();
            return;
        }
        guardarTipoConsultorio();
    });

    $("#btnEditarTipoConsultorio").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('editarTipoConsultorio');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('editarTipoConsultorio');
            ev.preventDefault();
            return;
        }
        actualizarTipoConsultorio();
    });
});

//Resultado de la llamada a TipoConsultorios.aspx/obtenerTiposConsultorios
function crearTablaTipoConsultorios(resultado) {
    var contenido = JSON.parse(resultado);
    $('#tblTiposConsultorios tbody').html("");
    $.each(contenido, function (key, item) {
        var $tr = $('<tr>');
        $.each(item, function (index, data) {
            $tr.append($('<td>').text(data));
        });
        $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarTipoConsultorio" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
        $tr.appendTo('#tblTiposConsultorios tbody');
    });

    $("#tblTiposConsultorios").DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
        },
        "responsive": true,
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ]
    });

    clickEditarTipoConsultorio();
}

function guardarTipoConsultorio() {
    var nombre = $("#txtTipoConsultorio").val();
    var activo = $("#chkActivo").prop('checked');

    var tipoConsultorio = new Object();
    tipoConsultorio.Tipo = nombre;
    tipoConsultorio.Activo = activo;

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("TipoConsultorios.aspx/guardarTipoConsultorio", "{ 'tipoConsultorio': " + JSON.stringify(tipoConsultorio) + "}", "tipoConsultorioGuardado");
}

//Resultado de la llamada a TipoConsultorios.aspx/guardarTipoConsultorio de la función "guardarTipoConsultorio"
function tipoConsultorioGuardado() {
    $('#tblTiposConsultorios').DataTable().destroy();
    ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerTiposConsultorios", null, "crearTablaTipoConsultorios");
    ICERP_Core.desbloquearPantalla();
    ICERP_Core.mostrarMensaje("Se almacenó el tipo de consultorio satisfactoriamente", "type-success");
}

function clickEditarTipoConsultorio() {
    $(".btnModalEditarTipoConsultorio").click(function () {
        var row = $(this).closest('tr');
        var data = $('#tblTiposConsultorios').dataTable().fnGetData(row);
        var idTipoConsultorio = Number(data[0]);
        ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerDatosTipoConsultorio", "{ 'idTipoConsultorio': " + idTipoConsultorio + " }", "mostrarDatosTipoConsultorio");
    });
}

//Resultado de la llamada a TipoConsultorios.aspx/obtenerDatosTipoConsultorio de la función "clickEditarTipoConsultorio"
function mostrarDatosTipoConsultorio(resultado) {
    var tipoConsultorio = JSON.parse(resultado);
    $("#hdnIdTipoConsultorio").val(tipoConsultorio.ID);
    $("#txtTipoConsultorioEd").val(tipoConsultorio.Tipo);
    $("#chkActivoEd").prop("checked", false);
    if (tipoConsultorio.Activo) {
        $("#chkActivoEd").prop("checked", true);
        $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
    }
    $('#mdlEditarTipoConsultorio input[type="checkbox"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-red'
    });
    $("#mdlEditarTipoConsultorio").validationEngine("hideAll");
    $("#mdlEditarTipoConsultorio").modal("show");
}

function actualizarTipoConsultorio() {
    var idTipoConsultorio = Number($("#hdnIdTipoConsultorio").val());
    var tipo = $("#txtTipoConsultorioEd").val();
    var activo = $("#chkActivoEd").prop('checked');

    var tipoConsultorio = new Object();
    tipoConsultorio.ID = idTipoConsultorio;
    tipoConsultorio.Tipo = tipo;
    tipoConsultorio.Activo = activo;

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("TipoConsultorios.aspx/actualizarTipoConsultorio", "{ 'tipoConsultorio': " + JSON.stringify(tipoConsultorio) + "}", "tipoConsultorioActualizado");
}

function tipoConsultorioActualizado() {
    $('#tblTiposConsultorios').DataTable().destroy();
    ICERP_Core.llamarAjax("TipoConsultorios.aspx/obtenerTiposConsultorios", null, "crearTablaTipoConsultorios");
    ICERP_Core.desbloquearPantalla();
    $("#mdlEditarTipoConsultorio").modal("hide");
    ICERP_Core.mostrarMensaje("Se actualizó el tipo de consultorio satisfactoriamente", "type-success");
}