using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class PermisosRepository : GenericRepository<IcerpEntities, Permisos>
    {
        public PermisosRepository()
        {
            Context = new IcerpEntities();
        }
        public PermisosRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Permisos> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Permisos> GetBy(System.Linq.Expressions.Expression<Func<Permisos, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Permisos GetSingle(int Id)
        {
            var query = Context.Permisos.FirstOrDefault(x => x.PermisoID == Id);
            return query;
        }

        public void AddSingle(Permisos single)
        {
            Add(single);
        }

        public void UpdateSingle(Permisos single)
        {
            Edit(single);
        }
    }
}
