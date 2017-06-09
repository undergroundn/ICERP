using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.CustomModel
{
    public sealed class StoredProcedureRepository
    {
        private DbContext Context;
        public StoredProcedureRepository()
        {
            Context = new IcerpEntities();
        }
        #region Metodos para Manejo de Usuarios

        //Example
        public getCredencialesUsuario_Result GetUserCredenciales(string nomUser, string pass)
        {
            return ((IcerpEntities)Context).getCredencialesUsuario(nomUser,pass).FirstOrDefault();
        }

        #endregion

        #region Métodos para el catálogo de Consultorios
        public IEnumerable<spObtenerDetallesConsultorios_Result> ObtenerDetallesConsultorios()
        {
            return ((IcerpEntities)Context).spObtenerDetallesConsultorios();
        }
        #endregion
    }
}
