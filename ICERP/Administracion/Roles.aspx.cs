using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ICERP.Administracion
{
    public partial class Roles : System.Web.UI.Page
    {
        #region Variables, Constantes y Propiedades
        Model.UnitOfWork.UnitOfWork worker = new Model.UnitOfWork.UnitOfWork();
        private static readonly LoggerUtility.ILogger _Log = LoggerUtility.Logger.GetInstance();
        #endregion

        #region Funciones y Procedimientos del Controles
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BingGV();

                panCaptura.Visible = false;
                //Master.LblTituloSecretaria.Text = "Catálogo de Perfiles";
            }
        }

        protected void butCancelar_Click(object sender, EventArgs e)
        {
            panCaptura.Visible = false;

        }
        protected void OnRowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='hightlighrow'");
                e.Row.Attributes.Add("onmouseout", "this.className='normalrow'");
            }
        }

        protected void butNuevaCaptura_Click(object sender, EventArgs e)
        {
            texbRol.Text = "";
            butGuardar.Visible = true;
            butActualizar.Visible = false;
            panCaptura.Visible = true;

        }

        protected void butGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                Model.CatRoles RolesModel = new Model.CatRoles();
                RolesModel.NombreRol = texbRol.Text;
                RolesModel.Activo = chebActivo.Checked;
                worker.CatRolesRepository.AddSingle(RolesModel);
                worker.Save();
                BingGV();
                panCaptura.Visible = false;
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.success('¡Registro Exitoso!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.error('¡No se pudo guardar el registro!');", true);
                _Log.Error("[ System ] " + " [ Page ] " + "[ Perfiles ] [ butGuardar_Click ] [ Fin ]", ex);
            }
        }

        protected void butActualizar_Click(object sender, EventArgs e)
        {
            try
            {
                int _RolID = int.Parse(hfPerfiles.Value);
                Model.CatRoles RolesModel = worker.CatRolesRepository.GetBy(x => x.ID == _RolID).SingleOrDefault();
                RolesModel.NombreRol = texbRol.Text;
                RolesModel.Activo = chebActivo.Checked;
                worker.CatRolesRepository.UpdateSingle(RolesModel);
                worker.Save();
                BingGV();
                panCaptura.Visible = false;
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.success('¡Los cambios han sido guardados!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ob1", "alertify.error('¡No se pudo guardar los cambios!');", true);
                _Log.Error("[ System ] " + " [ Page ] " + "[ Perfiles ] [ butActualizar_Click ] [ Fin ]", ex);
            }
        }






        protected void abrir(object sender, EventArgs e)
        {
            try
            {
                int _rolID = int.Parse(hfPerfiles.Value);
                Model.CatRoles RolesModel = new Model.CatRoles();
                RolesModel = worker.CatRolesRepository.GetSingle(_rolID);
                LlenaRolCampos(RolesModel);
                butGuardar.Visible = false;
                butActualizar.Visible = true;
                panCaptura.Visible = true;

            }
            catch
            { }
        }



        #endregion

        #region Funciones y Procedimientos Generales
        private void BingGV()
        {
            try
            {
                rptPerfiles.DataSource = worker.CatRolesRepository.Get();
                rptPerfiles.DataBind();
            }
            catch (Exception e)
            {
                _Log.Error("[ System ] " + " [ Page ] " + "[ Perfiles ] [ BingGV ] [ Fin ]", e);
            }
        }

        private void LlenaRolCampos(Model.CatRoles RolesModel)
        {
            texbRol.Text = "";
            texbRol.Text = RolesModel.NombreRol;
            chebActivo.Checked = RolesModel.Activo;
        }

        #endregion
    }
}