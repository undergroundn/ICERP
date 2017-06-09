using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoAccionRepository : GenericRepository<IcerpEntities, TipoAccion>
    {
        public TipoAccionRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoAccionRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoAccion> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoAccion> GetBy(System.Linq.Expressions.Expression<Func<TipoAccion, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoAccion GetSingle(int Id)
        {
            var query = Context.TipoAccion.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoAccion single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoAccion single)
        {
            Edit(single);
        }
    }
}
