using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CatPaisRepository : GenericRepository<IcerpEntities, CatPais>
    {
        public CatPaisRepository()
        {
            Context = new IcerpEntities();
        }
        public CatPaisRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CatPais> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CatPais> GetBy(System.Linq.Expressions.Expression<Func<CatPais, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CatPais GetSingle(int Id)
        {
            var query = Context.CatPais.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CatPais single)
        {
            Add(single);
        }

        public void UpdateSingle(CatPais single)
        {
            Edit(single);
        }
    }
}
