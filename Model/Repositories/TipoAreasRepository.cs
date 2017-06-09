using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoAreasRepository: GenericRepository<IcerpEntities, TipoAreas>
    {
        public TipoAreasRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoAreasRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoAreas> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoAreas> GetBy(System.Linq.Expressions.Expression<Func<TipoAreas, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoAreas GetSingle(int Id)
        {
            var query = Context.TipoAreas.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoAreas single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoAreas single)
        {
            Edit(single);
        }
    }
}
