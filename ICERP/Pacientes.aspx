﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Principal.Master" AutoEventWireup="true" CodeBehind="Pacientes.aspx.cs" Inherits="ICERP.Pacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContent" runat="server">
     
    <script src="Scripts/pages/Pacientes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContent" runat="server">
    <section class="content">
        <div class="row">
            <div class="box box-danger">
                <input id="hdnIdPaciente" type="hidden" />
                <div class="box-header with-border">
                    <h3 class="box-title">Registro de Pacientes</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="nombre">Nombre</label>
                                <input type="text" class="form-control validate[required]" id="nombre" placeholder="Nombre de paciente" validgroup="registrarPaciente">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="apPaterno">Apellido Paterno</label>
                                <input type="text" class="form-control validate[required]" id="apPaterno" placeholder="Apellido Paterno" validgroup="registrarPaciente">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="apMaterno">Apellido Materno</label>
                                <input type="text" class="form-control" id="apMaterno" placeholder="Apellido Materno" >
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label>Fecha de Nacimiento</label>
                                <div class="input-group date">
                                    <div class="input-group-addon">
                                        <i class="fa fa-calendar"></i>
                                    </div>
                                    <input type="date" class="form-control pull-right" id="datepicker">
                                </div>
                                <!-- /.input group -->
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="Edad">Edad</label>
                                <input type="number" class="form-control" id="Edad" placeholder="Edad">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label>Genero</label><br />
                                <label>
                                    Masculino
                 
                            <input type="radio" name="r3" id="gm" class="flat-red" checked>
                                </label>
                                <label>
                                    Femenino
                 
                            <input type="radio" name="r3" id="gf" class="flat-red">
                                </label>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="Horario">Horario</label>
                                <input type="text" class="form-control" id="Horario" placeholder="horario disponible">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                                <label for="turno">Turno</label>
                                <%--<input type="text" class="form-control" id="turno" placeholder="turno">--%>
                                <select id="sltTurno" class="form-control select2" style="width: 100%;">
                                    <option value="0" selected="selected">--Seleccione--</option>
                                    <%--<option value="1">Matutino</option>
                                    <option value="2">Vespertino</option>   --%>                                 
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="Motivo">Motivo</label>
                        <input type="text" class="form-control" id="Motivo" placeholder="Motivo de Consulta">
                    </div>
                    <div class="form-group">
                        <label for="NombreTutor">Tutor</label>
                        <input type="text" class="form-control" id="NombreTutor" placeholder="Persona Responsable">
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="TelefonoTutor">Teléfono</label>
                                <div class="input-group">
                                    <div class="input-group-addon">
                                        <i class="fa fa-phone"></i>
                                    </div>
                                    <input type="text" class="form-control" id="TelefonoTutor" placeholder="Teléfono del tutor" data-inputmask='"mask": "(999) 999-9999"' data-mask>
                                </div>

                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="ViaContactoTutor">Vía de Contacto</label>
                                <input type="text" class="form-control" id="ViaContactoTutor" placeholder="Vía de contacto del tutor (mensaje, llamanda, correo..)">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="ParentezcoTutor">Parentezco</label>
                                <input type="text" class="form-control" id="ParentezcoTutor" placeholder="Madre, Padre, Abuelos..">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="MedioDifusion">Medio de Difusión</label>
                        <input type="text" class="form-control" id="MedioDifusion" placeholder="Como se entero del Instituto">
                    </div>
                    <div class="form-group">
                        <label>Derivado por</label>
                        <br />
                        <div id="divDerivados" style="display: inline-block;">
                        </div>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" class="flat-red" id="chkActivo" checked>
                            Activo                 
                        </label>
                    </div>
                </div>
                <!-- /.box-body -->

                <div class="box-footer">
                    <div class="col-md-1">
                        <button type="button" class="btn btn-success" id="btnRegistrarPaciente">Registrar</button>
                         <button type="button" class="btn btn-primary" id="btnActualizarPaciente">Actualizar</button>
                    </div>
                    <div class="col-md-1">
                        <button type="button" class="btn btn-warning" id="btnCancelar">Cancelar</button>
                    </div>

                </div>
            </div>
             <div class="box">
                <div class="box-header">
                    <h3 class="box-title">Pacientes</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">
                    <div class="dataTables_wrapper form-inline dt-bootstrap">

                        <div style="width: 100%">
                            <br />

                            <table id="tblPacientes" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th style="display:none">IdPaciente</th>
                                        <th>Nombre</th>                                       
                                        <th>Edad</th>
                                        <th>Motivo</th>
                                        <th>Horario</th>
                                        <th>Tutor</th>
                                        <th>Teléfono</th>
                                        <th>Contacto</th>
                                        <th>Activo</th>
                                        <th>Editar</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>

                </div>
                <!-- /.box-body -->
            </div>
        </div>
    </section>
</asp:Content>
