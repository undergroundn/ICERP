using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class DependientesEconomicosESRepository: GenericRepository<IcerpEntities, DependientesEconomicosES>
    {
        public DependientesEconomicosESRepository()
        {
            Context = new IcerpEntities();
        }
        public DependientesEconomicosESRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<DependientesEconomicosES> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<DependientesEconomicosES> GetBy(System.Linq.Expressions.Expression<Func<DependientesEconomicosES, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public DependientesEconomicosES GetSingle(int Id)
        {
            var query = Context.DependientesEconomicosES.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(DependientesEconomicosES single)
        {
            Add(single);
        }

        public void UpdateSingle(DependientesEconomicosES single)
        {
            Edit(single);
        }
    }
}
