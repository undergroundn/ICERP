using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ICERP.Administracion
{
    public partial class Usuarios : System.Web.UI.Page
    {
        Model.UnitOfWork.UnitOfWork uw = new Model.UnitOfWork.UnitOfWork();
        private int _invalidValue = -1;
        //private List<Model.Permisos> _permisoTmp;
        private static readonly LoggerUtility.ILogger _Log = LoggerUtility.Logger.GetInstance();
        private int userid;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Master.LblTituloSecretaria.Text = "Catálogo de Administración de Usuarios";
                var user = Session["userID"];

                userid = user != null ? int.Parse(user.ToString()) : 0;
                LlenaCombo();
                LlenarUsuarios();
            }
        }
        private void LlenaCombo()
        {
            try
            {
                ddlRol.DataSource = uw.CatRolesRepository.Get();
                ddlRol.DataTextField = "NombreRol";
                ddlRol.DataValueField = "ID";
                ddlRol.DataBind();
            }
            catch (Exception e)
            {
                _Log.Error("[ System ] " + " [ Page ] " + "[ AgregarUusarios ] [ LlenaCombo ] [ Fin ]", e);
            }
        }

        private void LlenarUsuarios()
        {
            try
            {
                rptusuario.DataSource = uw.UsuariosRepository.Get();
                rptusuario.DataBind();
            }
            catch (Exception e)
            {
                _Log.Error("[ System ] " + " [ Page ] " + "[ AgregarUusarios ] [ LlenarUsuarios ] [ Fin ]", e);
            }
        }

        public bool agregandopermisos(int usuarioid)
        {
            try
            {
                var listmenus = uw.MenuUsuarioRepository.GetBy(x => x.IdUsuario == usuarioid);
                uw.MenuUsuarioRepository.RemoveAll(listmenus);
                uw.Save();
                var areastotales = uw.MenuUsuarioRepository.Get();

                JavaScriptSerializer jss = new JavaScriptSerializer();

                List<Regreso> nueva = jss.Deserialize<List<Regreso>>(hfnodosseleccionados.Value);

                Model.MenuUsuario areasusuarios = new Model.MenuUsuario();


               foreach (Regreso re in nueva)
                {
                    if (re.state.selected == "True")
                    {
                        int reid = int.Parse(re.id);
                        var areasuser = uw.MenuUsuarioRepository.GetBy(x => x.IdUsuario == usuarioid && x.IdMenu == reid);
                        if (areasuser.Count == 0)
                        {
                            areasusuarios.IdUsuario = usuarioid;
                            areasusuarios.IdMenu = int.Parse(re.id);
                            uw.MenuUsuarioRepository.AddSingle(areasusuarios);
                            uw.Save();

                        }
                        for (var i = 0; i < re.parents.Length; i++)
                        {
                            string valor = re.parents[i];
                            if (valor != "#")
                            {
                                int vid = int.Parse(valor);
                                var areasuser2 = uw.MenuUsuarioRepository.GetBy(x => x.IdUsuario == usuarioid && x.IdMenu == vid);
                                if (areasuser2.Count == 0)
                                {
                                    areasusuarios.IdUsuario = usuarioid;
                                    areasusuarios.IdMenu = int.Parse(valor);
                                    uw.MenuUsuarioRepository.AddSingle(areasusuarios);
                                    uw.Save();
                                }
                            }

                        }
                    }
                }
                if (nueva.Count != 0) { return true; }
                else
                { return false; }                      
            }
            catch (Exception e)
            {
                return false;
                _Log.Error("[ System ] " + " [ Page ] " + "[ AgregarUusarios ] [ agregandopermisos ] [ Fin ]", e);
            }
        }

        protected void btnguardar_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "bloq();", true);
            Model.Usuarios usuario = new Model.Usuarios();
            try
            {
                usuario.Nombres = texbNombre.Text.ToUpper();
                usuario.ApPaterno = texbPaterno.Text.ToUpper();
                usuario.ApMaterno = texbMaterno.Text.ToUpper();
                usuario.NombreUsuario = texbClaveUsuario.Text;
                string pwd = texbCorreo.Text;
                //byte[] array = Encoding.ASCII.GetBytes(pwd);
                //usuario.Contraseña = array;
                usuario.Contraseña = pwd;
                usuario.RolId = int.Parse(ddlRol.SelectedValue.ToString());
                usuario.Activo = chebActivo.Checked;
                uw.UsuariosRepository.AddSingle(usuario);
                uw.Save();

                hfidusuario.Value = usuario.ID.ToString();

                Model.MenuUsuario Area_Usuario = new Model.MenuUsuario();
                Area_Usuario.IdUsuario = int.Parse(hfidusuario.Value);
                int iduser = Area_Usuario.IdUsuario != null ? Convert.ToInt32(Area_Usuario.IdUsuario) : 0;
                bool respuesta = agregandopermisos(iduser);
                if (respuesta == true)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "desbloquear();", true);
                    LlenarUsuarios();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "desbloquear();", true);
                    Model.Usuarios delUser = uw.UsuariosRepository.GetBy(x => x.ID == iduser).SingleOrDefault();
                    uw.UsuariosRepository.Delete(delUser);
                    LlenarUsuarios();
                    ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alert('Agregue permisos a las áreas.');", true);
                }

            }
            catch (Exception ex)
            {
                //ind.Delete(usuario); pendiente
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.error('¡No se pudo guardar la información!');", true);
                _Log.Error("[ System ] " + " [ Page ] " + "[ Areas ] [ btnguardar_Click ] [ Fin ]", ex);
            }
        }



        protected void btnactualizar_Click(object sender, EventArgs e)
        {
            try
            {
                int _usuarioId = int.Parse(hfidusuario.Value);

                Model.Usuarios usuario = uw.UsuariosRepository.GetBy(x => x.ID == _usuarioId).SingleOrDefault();
                usuario.Nombres = texbNombre.Text.ToUpper();
                usuario.ApPaterno = texbPaterno.Text.ToUpper();
                usuario.ApMaterno = texbMaterno.Text.ToUpper();
                usuario.NombreUsuario = texbClaveUsuario.Text;
                string pwd = texbCorreo.Text;
                //byte[] array = Encoding.ASCII.GetBytes(pwd);
                //usuario.Contraseña = array;
                usuario.Contraseña = pwd;
                usuario.RolId = int.Parse(ddlRol.SelectedValue.ToString());
                usuario.Activo = chebActivo.Checked;

                agregandopermisos(_usuarioId);

                uw.UsuariosRepository.UpdateSingle(usuario);
                uw.Save();


                LlenarUsuarios();
                LlenaCombo();
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.success('¡Los cambios han sido guardados!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.error('¡No se pudo guardar los cambios!');", true);
                _Log.Error("[ System ] " + " [ Page ] " + "[ Areas ] [ btnactualizar_Click ] [ Fin ]", ex);
            }
        }

        
        protected void cargarrpt(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "verpopupactulizar();", true);
        }

        [WebMethod]
        public static string llenararbol(string id)
        {
            try
            {
                Model.UnitOfWork.UnitOfWork uow = new Model.UnitOfWork.UnitOfWork();                
                var areas = uow.MenuRepository.GetAll();
                JavaScriptSerializer jss = new JavaScriptSerializer();
                Area ara = new Area();
                List<Area> lista = new List<Area>();
                foreach (Model.Menu ar in areas)
                {
                    if (id == "0")
                    {
                        ara = construir(ar);
                    }
                    else { ara = construiract(ar, id); }
                    lista.Add(ara);
                }
                var resultado = jss.Serialize(lista);
                return resultado;
            }
            catch (Exception e)
            {
                _Log.Error("[ System ] " + " [ Page ] " + "[ Areas ] [ llenararbol ] [ Fin ]", e);
                return string.Empty;
            }
        }

        public static Area construir(Model.Menu nueva)
        {
            try
            {
                Area area = new Area();
                area.id = nueva.MenuId.ToString();
                area.text = nueva.NombreMenu;
                area.parent = nueva.MenuPadreId == null ? "#" : nueva.MenuPadreId.ToString();
                state st = new state();
                st.loaded = "True";
                st.opened = "True";
                area.state = st;
                return area;

            }
            catch (Exception e) { _Log.Error("[ System ] " + " [ Page ] " + "[ Areas ] [ construir ] [ Fin ]", e); return new Area { }; }
        }

        public class Area
        {
            public string id;
            public string parent;
            public string text;
            public state state;
        }

        public class Regreso
        {
            public string id;
            public string parent;
            public string text;
            public string[] parents;
            public state state;
        }

        public class state
        {
            public string loaded;
            public string opened;
            public string selected;
            public string disabled;
        }

        public static Area construiract(Model.Menu nueva, string usuarioId)
        {
            try
            {
                Model.UnitOfWork.UnitOfWork uow = new Model.UnitOfWork.UnitOfWork();

                Area area = new Area();
                area.id = nueva.MenuId.ToString();
                area.text = nueva.NombreMenu;
                area.parent = nueva.MenuPadreId == null ? "#" : nueva.MenuPadreId.ToString();
                int iduser = int.Parse(usuarioId);
                int idar = int.Parse(area.id);
                var usuario = uow.MenuUsuarioRepository.GetBy(x => x.IdUsuario == iduser && x.IdMenu == idar);

                int contar = 0;
                if (usuario.Count > 0)
                {
                    int menuid = usuario[0].IdMenu != null ? Int32.Parse(usuario[0].IdMenu.ToString()) : 0;
                    var usuario1 = uow.MenuRepository.GetBy(x => x.MenuPadreId == menuid);
                    contar = usuario1.Count;
                }
                state st = new state();

                if (usuario.Count > 0) { 
                    if (area.parent == "#" && contar > 0) { 
                        
                        //st.opened = "True";
                            st.selected = null;
                        
                    
                    } 
                    else { st.selected = "True"; } }
                else { 
                    st.selected = null; 
                    //st.opened = null; 
                    //st.disabled = null;
                }
                st.loaded = "True";
                st.opened = "True";
                area.state = st;
                return area;
            }
            catch (Exception e)
            {

                _Log.Error("[ System ] " + " [ Page ] " + "[ Areas ] [ construiract ] [ Fin ]", e);
                return new Area { };
            }
        }
    }
}