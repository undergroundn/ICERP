using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class UsuariosRepository : GenericRepository<IcerpEntities, Usuarios>
    {
        public UsuariosRepository()
        {
            Context = new IcerpEntities();
        }
        public UsuariosRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<Usuarios> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<Usuarios> GetBy(System.Linq.Expressions.Expression<Func<Usuarios, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public Usuarios GetSingle(int Id)
        {
            var query = Context.Usuarios.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(Usuarios single)
        {
            Add(single);
        }

        public void UpdateSingle(Usuarios single)
        {
            Edit(single);
        }
    }
}
