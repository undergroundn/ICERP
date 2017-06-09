using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoConsultorioRepository: GenericRepository<IcerpEntities, TipoConsultorio>
    {
        public TipoConsultorioRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoConsultorioRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoConsultorio> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoConsultorio> GetBy(System.Linq.Expressions.Expression<Func<TipoConsultorio, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoConsultorio GetSingle(int Id)
        {
            var query = Context.TipoConsultorio.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoConsultorio single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoConsultorio single)
        {
            Edit(single);
        }
    }
}
