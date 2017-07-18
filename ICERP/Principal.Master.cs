using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Model.Repositories;
using Model.UnitOfWork;
using System.Threading;

namespace ICERP
{
    public partial class Principal : System.Web.UI.MasterPage
    {
        private static readonly LoggerUtility.ILogger Log = LoggerUtility.Logger.GetInstance();
        UnitOfWork _uow = new UnitOfWork();
        public string nombreCompleto;
        public string nombreDominio;
        public string imageString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //Obtener usuario actual
                var idUsuario = Int32.Parse(Session["userID"].ToString());
                var usuario = _uow.UsuariosRepository.GetSingle(idUsuario);
                var rol = usuario.CatRoles.NombreRol;
                //Obtener opciones de menu principales del usuario
                var menusUsuario = usuario.MenuUsuario.Select(m => m.Menu).Where(m => m.MenuPadreId == null && m.Activo.Value);
                //Generar menu con las opciones del usuario
                var htmlMenu = GeneraHtmlMenu(menusUsuario, usuario);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "menu", "var data = '" + htmlMenu + "' ;", true);
                //Obtener información del usuario para desplegar
                nombreCompleto = usuario.Nombres + " " + usuario.ApPaterno + " " + usuario.ApMaterno;
                var culInfo = Thread.CurrentThread.CurrentCulture;
                var tInfo = culInfo.TextInfo;
                nombreCompleto = tInfo.ToTitleCase(nombreCompleto.ToLower());
                nombreDominio = usuario.NombreUsuario.ToLower();
                var image = usuario.Foto != null ? usuario.Foto : "/dist/img/avatar5.png";
                imageString = image;//ImageConverterString.toBase64String(image);
                //ocultarRoles = "Si";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "mostrarDatos",
                    "var rolUsuario = '" + rol + "'; " +
                    "var nombreCompleto = '" + nombreCompleto + "'; " +
                    "var nombreDominio = '" + nombreDominio + "'; " +
                    //"var cantNotificaciones = " + notifiPendientes + "; " +
                    "var fotoUsuario = '" + imageString + "'; " 
                    //+
                    //"var ocultarRoles = '" + ocultarRoles + "';"
                    , true);
            }
            catch (Exception ex)
            {
                // ignored
            }
        }

        private StringBuilder GeneraHtmlMenu(IEnumerable<Model.Menu> menus, Model.Usuarios usuario)
        {
            StringBuilder sb = new StringBuilder();

            foreach (var menuOpcion in menus)
            {
                var submenus = buscarSubmenus(menuOpcion.MenuId, usuario);
                sb.Append(submenus.Any() ? "<li class=\"treeview\">" : "<li>");
                sb.Append(menuOpcion.MenuUrl != null ? "<a href=\"" + menuOpcion.MenuUrl + "\">" : "<a href=\"#\">");
                sb.Append("<i class=\"fa " + menuOpcion.Icono + "\"></i><span>" + menuOpcion.NombreMenu + "</span>");
                if (submenus.Any())
                {
                    sb.Append("<i class=\"fa fa-angle-left pull-right\"></i>");
                }
                sb.Append("</a>");
                if (submenus.Any())
                {
                    sb.Append(CrearSubmenus(submenus));
                }
                sb.Append("</li>");
            }
            return sb;

        }

        private IEnumerable<Model.Menu> buscarSubmenus(int idMenu, Model.Usuarios usuario)
        {
            var submenus = usuario.MenuUsuario.Select(m => m.Menu).Where(m => m.MenuPadreId == idMenu && m.Activo.Value);
            return submenus;
        }

        private StringBuilder CrearSubmenus(IEnumerable<Model.Menu> listaMenus)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("<ul class=\"treeview-menu\">");
            foreach (var submenu in listaMenus)
            {
                sb.Append("<li>");
                sb.Append(submenu.MenuUrl != null ? "<a href=\"" + submenu.MenuUrl + "\">" : "<a href=\"#\">");
                sb.Append("<i class=\"fa " + submenu.Icono + "\"></i>" + submenu.NombreMenu);
                sb.Append("</a>");
                sb.Append("</li>");
            }
            sb.Append("</ul>");
            return sb;
        }
    }
}