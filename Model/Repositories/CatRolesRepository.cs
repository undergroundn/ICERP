using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CatRolesRepository : GenericRepository<IcerpEntities, CatRoles>
    {
        public CatRolesRepository()
        {
            Context = new IcerpEntities();
        }
        public CatRolesRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CatRoles> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CatRoles> GetBy(System.Linq.Expressions.Expression<Func<CatRoles, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CatRoles GetSingle(int Id)
        {
            var query = Context.CatRoles.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CatRoles single)
        {
            Add(single);
        }

        public void UpdateSingle(CatRoles single)
        {
            Edit(single);
        }
    }
}
