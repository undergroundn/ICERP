<%@ Page Title="" Language="C#" MasterPageFile="~/General.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Autenticacion.aspx.cs" Inherits="ICERP.Autenticacion1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function iniciar() {
            alert("entro");
            window.location.replace("~/Index.aspx");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="login-box">
  <div class="login-logo">
    <a href="Index.aspx"><%--<b>ICERP</b>--%>
        <img src="Images/logo/logoIcerp.jpg" />
    </a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
      <div class="box box-danger"> 
<div class="box-header with-border">
    <h3 class="box-title">Autenticación de Usuario</h3>
</div>
      <div class="box-body">
    <%--<p class="login-box-msg"><b>Autenticación de Usuario</b></p>--%>

    <form action="Index.aspx" method="post">
      <div class="form-group has-feedback">
       <%-- <input type="text" class="form-control" placeholder="Usuario">--%>
         <asp:TextBox ID="Tbx_Nombre" runat="server" CssClass="form-control" PlaceHolder="Nombre de usuario" MaxLength="150"></asp:TextBox>
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <%--<input type="password" class="form-control" placeholder="Contraseña">--%>
          <asp:TextBox ID="Tbx_Password" runat="server" TextMode="Password" CssClass="form-control" PlaceHolder="Contraseña" MaxLength="50"></asp:TextBox>
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-6">
          <div class="checkbox icheck">
            <label>
              <%--<input type="checkbox" runat="server" id="chkPersistCookie"> Recordarme--%>
               <asp:CheckBox ID="chkPersistCookie" runat="server" />Recordarme
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-6">
          <%--<button type="submit" class="btn btn-danger btn-block" onclick="bloq();">Iniciar Sesión</button>--%>
          <asp:Button ID="btnIniciarSesion" CssClass="btn btn-danger btn-block" runat="server" Text="Iniciar Sesión" OnClientClick="bloq();" OnClick="btnIniciarSesion_Click"/>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <a href="#">Olvide mi contraseña</a><br>
    <%--<a href="register.html" class="text-center">Registrarme</a>--%></div>
</div>
  </div>
  <!-- /.login-box-body -->
</div>
</asp:Content>
