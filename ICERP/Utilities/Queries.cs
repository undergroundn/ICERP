using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Model.UnitOfWork;

namespace ICERP.Utilities
{
    public class Queries
    {
        public static Usuarios GetCurrentUser()
        {
            var uow = new UnitOfWork();
            var idUsuario = int.MinValue;
            var idUsuarioTxt = HttpContext.Current.Session["userID"];
            if (idUsuarioTxt != null)
                idUsuario = !string.IsNullOrEmpty(idUsuarioTxt.ToString()) ? int.Parse(idUsuarioTxt.ToString()) : int.MinValue;
            if (idUsuario == int.MinValue)
            {
                var cuentaDominio = HttpContext.Current.User.Identity.Name;
                var usuario = uow.UsuariosRepository.GetBy(u => u.NombreUsuario.Equals(cuentaDominio)).Single();
                HttpContext.Current.Session.Add("userID", usuario.ID);
                HttpContext.Current.Session.Add("userRol", usuario.RolId);
                HttpContext.Current.Session.Add("userNombre", usuario.Nombres + " " + usuario.ApPaterno + " " + usuario.ApMaterno);
                return usuario;
            }
            return uow.UsuariosRepository.GetSingle(idUsuario);
        }
    }
}