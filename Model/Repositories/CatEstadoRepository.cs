using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CatEstadoRepository: GenericRepository<IcerpEntities, CatEstado>
    {
        public CatEstadoRepository()
        {
            Context = new IcerpEntities();
        }
        public CatEstadoRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CatEstado> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CatEstado> GetBy(System.Linq.Expressions.Expression<Func<CatEstado, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CatEstado GetSingle(int Id)
        {
            var query = Context.CatEstado.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CatEstado single)
        {
            Add(single);
        }

        public void UpdateSingle(CatEstado single)
        {
            Edit(single);
        }
    }
}
