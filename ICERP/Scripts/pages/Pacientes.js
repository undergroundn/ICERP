$(document).ready(function () {

    ICERP_Core.llamarAjax("Pacientes.aspx/obtenerDerivados", null, "crearControlDerivados");

    ICERP_Core.llamarAjax("Pacientes.aspx/obtenerTurnos", null, "crearControlTurnos");

    ICERP_Core.llamarAjax("Pacientes.aspx/obtenerPacientes", null, "crearTablaPacientes");
    
    $("#btnRegistrarPaciente").click(function (ev) {
        
        var isValid = ICERP_Core.validarFormulario('registrarPaciente');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarPaciente');
            ev.preventDefault();
            return;
        }
        guardarPaciente();
    });

    $("#btnActualizarPaciente").click(function (ev) {
        var isValid = ICERP_Core.validarFormulario('registrarPaciente');
        if (!isValid) {
            ICERP_Core.reiniciarValidación('registrarPaciente');
            ev.preventDefault();
            return;
        }
        actualizarPaciente();
    });
    $("#btnCancelar").click(function (ev) {        
        limpiarCampos();
    });
    
    $("#btnRegistrarPaciente").show();
    $("#btnActualizarPaciente").hide();
});
function limpiarCampos() {
    $("#hdnIdPaciente").val("");
    $("#nombre").val("");
    $("#apPaterno").val("");
    $("#apMaterno").val("");
    $("#datepicker").val("");
    $("#Edad").val("");

    $("#gm").prop("checked", true);
    $("#gf").prop("checked", false);    
    $("#gm").removeClass("flat-red").addClass("flat-red");   
    $("#gf").removeClass("flat-red").addClass("flat-red");    
    $("#Horario").val("");
    $("#sltTurno").val("0");
    $("#Motivo").val("");
    $("#MedioDifusion").val("");
    $("#chkActivo").prop("checked", false);
    $("#chkActivo").removeClass("flat-red").addClass("flat-red");
    $('#divDerivados input[type=radio]').each(function () {
        $(this).prop("checked", false);
    });
    //tabla tutor
    $("#NombreTutor").val("");
    $("#TelefonoTutor").val("");
    $("#ViaContactoTutor").val("");
    $("#ParentezcoTutor").val("");

    $("#btnRegistrarPaciente").show();
    $("#btnActualizarPaciente").hide();
}
//Resultado de la llamada a Consultorios.aspx/obtenerTiposConsultorios
function crearControlDerivados(resultado) {
    var contenido = JSON.parse(resultado);
    $.each(contenido, function (index, item) {
        var checkBoxAd = "<input id=\"chk" + item.QuienDeriva + "Ad\" value=\"" + item.IdDerivado + "\" type=\"radio\" name=\"rder\" class=\"flat-red tiposDerivados validate[funcCall[verificarDerivado]]\" />" +
            "<label>&nbsp;&nbsp;&nbsp;" + item.QuienDeriva + "&nbsp;&nbsp;&nbsp;</label>";
            //"<span style=\"margin-right: 20px\">" + item.QuienDeriva + "</span>";
        $("#divDerivados").append(checkBoxAd);
      
    });
    $('#divDerivados input[type="radio"].flat-red').iCheck({
        radioClass: 'iradio_flat-red'
    });
}

//Resultado de la llamada a Pacientes.aspx/obtenerTurnos
function crearControlTurnos(resultado) {
    var contenido = JSON.parse(resultado);
    $.each(contenido, function (index, item) {
        //llenar lista de turnos disponibles en BD
        var turnos = "<option value=" + item.ID + ">" + item.Turno + "</option>";
        $("#sltTurno").append(turnos);        
    });
}

//Resultado de la llamada a Consultorios.aspx/obtenerConsultorios
function crearTablaPacientes(resultado) {
    var contenido = JSON.parse(resultado);
    $('#tblPacientes tbody').html("");
    $.each(contenido, function (key, item) {
        var $tr = $('<tr>');
        $.each(item, function (index, data) {
            $tr.append($('<td>').text(data));
        });
        $tr.append($('<td style="text-align:center">').html('<a role="button" class="btn btn-default btnEditarPaciente" data-toggle="modal"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span></a>'));
        $tr.appendTo('#tblPacientes tbody');
    });

    $("#tblPacientes").DataTable({
        "language": {
            "url": "//cdn.datatables.net/plug-ins/1.10.15/i18n/Spanish.json"
        },
        "responsive": true,
        "columnDefs": [
            { "visible": false, "targets": 0 }
        ]
    });

    clickEditarPaciente();
}

function guardarPaciente() {
    var nombre = $("#nombre").val();
    var apPaterno = $("#apPaterno").val();
    var apMaterno = $("#apMaterno").val();
    var datepicker = $("#datepicker").val();
    var Edad = $("#Edad").val();
    var generom = $("#gm").prop('checked');
    var generof = $("#gf").prop('checked');
    var genero = generom == true ? "Masculino" : "Femenino";
    var Horario = $("#Horario").val();
    var turnoid = $("#sltTurno").val();
    var Motivo = $("#Motivo").val();
    var MedioDifusion = $("#MedioDifusion").val();
    var activo = $("#chkActivo").prop('checked');
    //tabla tutor
    var NombreTutor = $("#NombreTutor").val();
    var TelefonoTutor = $("#TelefonoTutor").val();
    var ViaContactoTutor = $("#ViaContactoTutor").val();
    var ParentezcoTutor = $("#ParentezcoTutor").val();
    var idDerivado = 0;
    $(".tiposDerivados").each(function () {       
        var checked = $(this).prop('checked');
        if (checked) {
            idDerivado = Number($(this).val());          
        }
    });


    var param = "{ 'nombre': '" + nombre
        + "','apPaterno':'" + apPaterno
        + "','apMaterno':'" + apMaterno
        + "','fechaNacimiento':'" + datepicker
        + "','Edad':'" + Edad
        + "','genero':'" + genero
        + "','Horario':'" + Horario
        + "','turnoid':'" + turnoid
        + "','Motivo':'" + Motivo
        + "','MedioDifusion':'" + MedioDifusion
        + "','activo':" + activo
        + ",'NombreTutor':'" + NombreTutor
        + "','TelefonoTutor':'" + TelefonoTutor
        + "','ViaContactoTutor':'" + ViaContactoTutor
        + "','ParentezcoTutor':'" + ParentezcoTutor
        + "','IdDerivado':'" + idDerivado + "'}"

    //var paciente = new Object();
    //paciente.Nombre = nombre;
    //paciente.ApPaterno = apPaterno;
    //paciente.ApMaterno = apMaterno;
    //paciente.Edad = Edad != "" ? Number(Edad): 0;
    //paciente.Motivo = Motivo;
    //paciente.Horario = Horario;
    //paciente.IdTurno = turnoid != 0 ? Number(turnoid): null;
    //paciente.FechaNacimiento = datepicker;
    //paciente.Genero = genero;
    //paciente.MedioDifusion = MedioDifusion;
    //paciente.Activo = activo;

    //if (NombreTutor != "") {
    //    paciente.Tutores = [];
    //    var tutores = new Object();
    //    tutores.ID = 0;
    //    tutores.Nombre = NombreTutor;
    //    tutores.Telefono = TelefonoTutor;
    //    tutores.ViaContacto = ViaContactoTutor;
    //    tutores.Parentezco = ParentezcoTutor;

    //    paciente.Tutores.push(tutores);
    //}
    

    //paciente.ConsultoriosTipos = [];

    //$(".tiposConsultorios").each(function () {
    //    var checked = $(this).prop('checked');
    //    if (checked) {
    //        var idTipo = Number($(this).val());
    //        var consultorioTipo = new Object();
    //        consultorioTipo.IdTipo = idTipo;
    //        consultorio.ConsultoriosTipos.push(consultorioTipo);
    //    }
    //});

    ICERP_Core.bloquearPantalla();
    //ICERP_Core.llamarAjax("Pacientes.aspx/guardarPaciente", "{ 'paciente': " + JSON.stringify(paciente) + "}", "pacienteGuardado");
    ICERP_Core.llamarAjax("Pacientes.aspx/guardarPaciente", param, "pacienteGuardado");
}

//Resultado de la llamada a Consultorios.aspx/guardarConsultorio de la función "guardarConsultorio"
function pacienteGuardado() {
    $('#tblPacientes').DataTable().destroy();
    ICERP_Core.llamarAjax("Pacientes.aspx/obtenerPacientes", null, "crearTablaPacientes");
    limpiarCampos();
    ICERP_Core.desbloquearPantalla();
    ICERP_Core.mostrarMensaje("Se almacenó el paciente satisfactoriamente", "type-success");
}

function clickEditarPaciente() {
    $(".btnEditarPaciente").click(function () {
        var row = $(this).closest('tr');
        var data = $('#tblPacientes').dataTable().fnGetData(row);
        var idPaciente = Number(data[0]);
        ICERP_Core.llamarAjax("Pacientes.aspx/obtenerDatosPaciente", "{ 'IdPaciente': " + idPaciente + " }", "mostrarDatosPaciente");
    });
   
}

//Resultado de la llamada a Consultorios.aspx/obtenerDatosConsultorio de la función "clickEditarConsultorio"
function mostrarDatosPaciente(resultado) {
    var paciente = JSON.parse(resultado);
    $("#hdnIdPaciente").val(paciente.ID);
    $("#nombre").val(paciente.Nombre);
    $("#apPaterno").val(paciente.ApPaterno);
    $("#apMaterno").val(paciente.ApMaterno);
    $("#datepicker").val(paciente.FechaNacimiento);
    $("#Edad").val(paciente.Edad);
   
    $("#gm").prop("checked", false);
    $("#gf").prop("checked", false);
    if (paciente.Genero == "Masculino") {
        $("#gm").prop("checked", true);
        $("#gm").removeClass("flat-red").addClass("flat-red");
    }
    else {
        $("#gf").prop("checked", true);
        $("#gf").removeClass("flat-red").addClass("flat-red");
    }
    $("#Horario").val(paciente.Horario);
    $("#sltTurno").val(paciente.IdTurno);
    $("#Motivo").val(paciente.Motivo);
    $("#MedioDifusion").val(paciente.MedioDifusion);
    
    $("#chkActivo").prop("checked", false);
    if (paciente.Activo) {
        $("#chkActivo").prop("checked", true);
        $("#chkActivo").removeClass("flat-red").addClass("flat-red");
    }
    $('#divDerivados input[type=radio]').each(function () {
        $(this).prop("checked", false);
    });
    $('#divDerivados input[type=radio]').each(function (index, value) {
        if (value == paciente.IdDerivado) {
            $(this).prop("checked", true);
            $(this).removeClass("flat-red").addClass("flat-red");
        }
    });
    //tabla tutor
    $("#NombreTutor").val(paciente.Tutor);
    $("#TelefonoTutor").val(paciente.telefono);
    $("#ViaContactoTutor").val(paciente.viaContacto);
    $("#ParentezcoTutor").val(paciente.Parentezco);

    $("#btnRegistrarPaciente").hide();
    $("#btnActualizarPaciente").show();
    
   
    //$("#mdlEditarConsultorio").validationEngine("hideAll");
    
}

function actualizarPaciente() {
    var idPaciente = Number($("#hdnIdPaciente").val());

    var nombre = $("#nombre").val();
    var apPaterno = $("#apPaterno").val();
    var apMaterno = $("#apMaterno").val();
    var datepicker = $("#datepicker").val();
    var Edad = $("#Edad").val();
    var generom = $("#gm").prop('checked');
    var generof = $("#gf").prop('checked');
    var genero = generom == true ? "Masculino" : "Femenino";
    var Horario = $("#Horario").val();
    var turnoid = $("#sltTurno").val();
    var Motivo = $("#Motivo").val();
    var MedioDifusion = $("#MedioDifusion").val();
    var activo = $("#chkActivo").prop('checked');
    var idDerivado = 0;
    $(".tiposDerivados").each(function () {
        var checked = $(this).prop('checked');
        if (checked) {
            idDerivado = Number($(this).val());
        }
    });
    //tabla tutor
    var NombreTutor = $("#NombreTutor").val();
    var TelefonoTutor = $("#TelefonoTutor").val();
    var ViaContactoTutor = $("#ViaContactoTutor").val();
    var ParentezcoTutor = $("#ParentezcoTutor").val();

    var param = "{ 'idPaciente': " + idPaciente
        + ",'nombre': '" + nombre
        + "','apPaterno':'" + apPaterno
        + "','apMaterno':'" + apMaterno
        + "','fechaNacimiento':'" + datepicker
        + "','Edad':'" + Edad
        + "','genero':'" + genero
        + "','Horario':'" + Horario
        + "','turnoid':'" + turnoid
        + "','Motivo':'" + Motivo
        + "','MedioDifusion':'" + MedioDifusion
        + "','activo':" + activo
        + ",'NombreTutor':'" + NombreTutor
        + "','TelefonoTutor':'" + TelefonoTutor
        + "','ViaContactoTutor':'" + ViaContactoTutor
        + "','ParentezcoTutor':'" + ParentezcoTutor
        + "','IdDerivado':'" + idDerivado + "'}"

    ICERP_Core.bloquearPantalla();
    ICERP_Core.llamarAjax("Pacientes.aspx/actualizarPaciente", param, "pacienteActualizado");
}

function pacienteActualizado() {
    $('#tblPacientes').DataTable().destroy();
    ICERP_Core.llamarAjax("Pacientes.aspx/obtenerPacientes", null, "crearTablaPacientes");
    limpiarCampos();
    ICERP_Core.desbloquearPantalla();    
    ICERP_Core.mostrarMensaje("Se actualizó el paciente satisfactoriamente", "type-success");
}

//funcion personalizada para validar alta de consultorios
function verificarDerivado(field, rules, i, options) {
    var valid = false;
    $(".tiposDerivados").each(function () {
        var checked = $(this).prop('checked');
        if (checked) {
            valid = true;
            return false;
        }
    });
    if (!valid) {
        $("#divDerivados").validationEngine('showPrompt', '* Seleccione quien deriva el paciente', 'error', 'topRight', true);
        options.isError = true;
    } else {
        $('#divDerivados').validationEngine('hide');
    }
}

