using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoTrastornoRepository : GenericRepository<IcerpEntities, TipoTrastorno>
    {
        public TipoTrastornoRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoTrastornoRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoTrastorno> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoTrastorno> GetBy(System.Linq.Expressions.Expression<Func<TipoTrastorno, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoTrastorno GetSingle(int Id)
        {
            var query = Context.TipoTrastorno.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoTrastorno single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoTrastorno single)
        {
            Edit(single);
        }
    }
}
