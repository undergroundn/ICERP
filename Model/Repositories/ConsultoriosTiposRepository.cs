using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class ConsultoriosTiposRepository : GenericRepository<IcerpEntities, ConsultoriosTipos>
    {
        public ConsultoriosTiposRepository()
        {
            Context = new IcerpEntities();
        }
        public ConsultoriosTiposRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<ConsultoriosTipos> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<ConsultoriosTipos> GetBy(System.Linq.Expressions.Expression<Func<ConsultoriosTipos, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public ConsultoriosTipos GetSingle(int Id)
        {
            var query = Context.ConsultoriosTipos.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(ConsultoriosTipos single)
        {
            Add(single);
        }

        public void UpdateSingle(ConsultoriosTipos single)
        {
            Edit(single);
        }
    }
}
