$(document).ready(function () {
    ICERP_Core.llamarAjax("TiposPacientes.aspx/obtenerTiposPacientes", null, "crearTablaTipoPacientes");

    $("#btnRegistrarTipoPaciente").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('registrarTipoPaciente');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarTipoPaciente');
            ev.preventDefault();
            return;
        }
        guardarTipoPaciente();
    });

    $("#btnEditarTipoPaciente").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('editarTipoPaciente');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('editarTipoPaciente');
            ev.preventDefault();
            return;
        }
        actualizarTipoPaciente();
    });
});

//Resultado de la llamada a TiposPacientes.aspx/obtenerTiposPacientes
function crearTablaTipoPacientes(resultado) {
    var contenido = JSON.parse(resultado);
    $('#tblTiposPacientes tbody').html("");
    $.each(contenido, function (key, item) {
        var $tr = $('<tr>');
        $.each(item, function (index, data) {
            $tr.append($('<td>').text(data));
        });
        $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnModalEditarTipoPaciente" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
        $tr.appendTo('#tblTiposPacientes tbody');
    });

    $("#tblTiposPacientes").DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
        },
        "responsive": true,
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ]
    });

    clickEditarTipoPaciente();
}

function guardarTipoPaciente() {
    var nombre = $("#txtTipoPaciente").val();
    var activo = $("#chkActivo").prop('checked');

    var tipoPaciente = new Object();
    tipoPaciente.Tipo = nombre;
    tipoPaciente.Activo = activo;

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("TiposPacientes.aspx/guardarTipoPaciente", "{ 'tipoPaciente': " + JSON.stringify(tipoPaciente) + "}", "tipoPacienteGuardado");
}

//Resultado de la llamada a TiposPacientes.aspx/guardarTipoPaciente de la función "guardarTipoPaciente"
function tipoPacienteGuardado() {
    $('#tblTiposPacientes').DataTable().destroy();
    ICERP_Core.llamarAjax("TiposPacientes.aspx/obtenerTiposPacientes", null, "crearTablaTipoPacientes");
    ICERP_Core.desbloquearPantalla();
    ICERP_Core.mostrarMensaje("Se almacenó el tipo de paciente satisfactoriamente", "type-success");
}

function clickEditarTipoPaciente() {
    $(".btnModalEditarTipoPaciente").click(function () {
        var row = $(this).closest('tr');
        var data = $('#tblTiposPacientes').dataTable().fnGetData(row);
        var idTipoPaciente = Number(data[0]);
        ICERP_Core.llamarAjax("TiposPacientes.aspx/obtenerDatosTipoPaciente", "{ 'idTipoPaciente': " + idTipoPaciente + " }", "mostrarDatosTipoPaciente");
    });
}

//Resultado de la llamada a TiposPacientes.aspx/obtenerDatosTipoPaciente de la función "clickEditarTipoPaciente"
function mostrarDatosTipoPaciente(resultado) {
    var tipoPaciente = JSON.parse(resultado);
    $("#hdnIdTipoPaciente").val(tipoPaciente.ID);
    $("#txtTipoPacienteEd").val(tipoPaciente.Tipo);
    $("#chkActivoEd").prop("checked", false);
    if (tipoPaciente.Activo) {
        $("#chkActivoEd").prop("checked", true);
        $("#chkActivoEd").removeClass("flat-red").addClass("flat-red");
    }
    $('#mdlEditarTipoPaciente input[type="checkbox"].flat-red').iCheck({
        checkboxClass: 'icheckbox_flat-red'
    });
    $("#mdlEditarTipoPaciente").validationEngine("hideAll");
    $("#mdlEditarTipoPaciente").modal("show");
}

function actualizarTipoPaciente() {
    var idTipoPaciente = Number($("#hdnIdTipoPaciente").val());
    var tipo = $("#txtTipoPacienteEd").val();
    var activo = $("#chkActivoEd").prop('checked');

    var tipoPaciente = new Object();
    tipoPaciente.ID = idTipoPaciente;
    tipoPaciente.Tipo = tipo;
    tipoPaciente.Activo = activo;

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("TiposPacientes.aspx/actualizarTipoPaciente", "{ 'tipoPaciente': " + JSON.stringify(tipoPaciente) + "}", "tipoPacienteActualizado");
}

function tipoPacienteActualizado() {
    $('#tblTiposPacientes').DataTable().destroy();
    ICERP_Core.llamarAjax("TiposPacientes.aspx/obtenerTiposPacientes", null, "crearTablaTipoPacientes");
    ICERP_Core.desbloquearPantalla();
    $("#mdlEditarTipoPaciente").modal("hide");
    ICERP_Core.mostrarMensaje("Se actualizó el tipo de paciente satisfactoriamente", "type-success");
}