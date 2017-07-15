using Model.UnitOfWork;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model;

namespace ICERP
{
    public partial class Autenticacion1 : System.Web.UI.Page
    {
        private static readonly LoggerUtility.ILogger _Log = LoggerUtility.Logger.GetInstance();
        UnitOfWork uow = new UnitOfWork();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var logout = Request.QueryString["action"];
                if (logout == "logout")
                {
                    FormsAuthentication.SignOut();
                    HttpContext.Current.Session.Clear();
                    HttpContext.Current.Session.Abandon();
                    Response.Redirect("~/Autenticacion.aspx", false);
                }
            }
            catch (Exception ex)
            {
                _Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
            }
        }

        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            ValidateUser();
        }
       
        private void ValidateUser()
        {
            try
            {
                var usuario = Tbx_Nombre.Text.Trim().ToLower();               
                var contraseña = Tbx_Password.Text.Trim();

                if (!string.IsNullOrEmpty(usuario) && !string.IsNullOrEmpty(contraseña))
                {
                    var user = new Model.CustomModel.StoredProcedureRepository().GetUserCredenciales(usuario, contraseña);                       
                   
                    if (user != null)//  || user.ID != 0 )
                    {
                        if ((user != null && user.ID != 0 && user.Activo == false))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "mensajedesactivado",
                                "mostrarMensaje('Su usuario se encuentra desactivado.<br/>Contácte con el administrador para más detalles.');",
                                true);
                            return;
                        }
                       
                        //var valid = Membership.ValidateUser(usuarioUat, contraseña);
                        if (user.Contraseña != null && user.NombreUsuario != null)
                        //if (Membership.ValidateUser(usuarioUat, contraseña)) //comentar para prueba
                        {                           

                            int idrol = user.RolId != null ? Int32.Parse(user.RolId.ToString()) : 0;
                            // Se crea el ticket de autenticación
                            var ticket = new FormsAuthenticationTicket(
                                1, // Versión del ticket
                                usuario, // Nombre de usuario asociado al ticket
                                DateTime.Now, // Fecha de creación del ticket
                                DateTime.Now.AddMinutes(60), // Fecha y Hora de las expiración de la cookie
                                chkPersistCookie.Checked, // Si el usuario cliquó en "Recuérdame" la cookie no expira.
                                idrol.ToString(CultureInfo.InvariantCulture),
                                // Almacena datos del usuario, en este caso los roles
                                FormsAuthentication.FormsCookiePath);
                            // El path de la cookie especificado en el Web.Config

                            // Se encripta la cookie para añadir más seguridad
                            var hashCookies = FormsAuthentication.Encrypt(ticket);
                            var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, hashCookies);
                            // Cookie encriptada
                            if (chkPersistCookie.Checked)
                                cookie.Expires = ticket.Expiration;
                            cookie.Path = FormsAuthentication.FormsCookiePath; 
                            // Se añade la cookie a la respuesta
                            Response.Cookies.Add(cookie);

                            // Se recupera la url que el usuario trataba de acceder, si no existe dicha url redirigimos al usuario a la pagina por defecto
                            //var returnUrl = Request.QueryString["ReturnUrl"] ?? "~/Default.aspx";

                            //FormsAuthentication.SetAuthCookie(txtUsername.Text, chkRecordar.Checked);
                            //Session.Add("user", user.nombreUsuario);
                            Session.Add("userID", user.ID);
                            Session.Add("userRol", user.RolId);
                            Session.Add("userNombre", user.Nombres + " " + user.ApPaterno + " " + user.ApMaterno);
                           
                            //LogActions.logAccion(user.ID, "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ]", "El usuario " + user.NombreUsuario + ", ha accedido al sistema.", "ACC");
                            Response.Redirect("~/Index.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                            
                        }
                        else
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "mensajeincorrecto",
                                "mostrarMensaje('¡Su usuario y/o contraseña son incorrectos!');", true);
                        
                    }
                    else
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "mensajenoregistro",
                            "mostrarMensaje('¡Su usuario no está registrado!');", true);
                    
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "mensajevacio",
                            "mostrarMensaje('¡Ingrese un nombre de usuario y contraseña!');", true);
                    
                }
            }
            catch (Exception ex)
            {
                _Log.Error("[ System ] " + " [ Page ] " + "[ " + System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name.ToString() + " ] [ " + System.Reflection.MethodBase.GetCurrentMethod().Name.ToString() + " ] [ Fin ]", ex);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mensajeerror",
                    "mostrarMensaje('¡Se presentó un problema al momento de autenticar el usuario!<br/>Contácte con el administrador para más detalles.');",
                    true);
            }
        } 
    }
}