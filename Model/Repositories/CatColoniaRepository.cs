using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model.Infrastructure;

namespace Model.Repositories
{
    public class CatColoniaRepository : GenericRepository<IcerpEntities, CatColonia>
    {
        public CatColoniaRepository()
        {
            Context = new IcerpEntities();
        }
        public CatColoniaRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CatColonia> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CatColonia> GetBy(System.Linq.Expressions.Expression<Func<CatColonia, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CatColonia GetSingle(int Id)
        {
            var query = Context.CatColonia.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CatColonia single)
        {
            Add(single);
        }

        public void UpdateSingle(CatColonia single)
        {
            Edit(single);
        }
    }
}
