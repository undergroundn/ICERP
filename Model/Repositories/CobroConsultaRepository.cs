using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class CobroConsultaRepository : GenericRepository<IcerpEntities, CobroConsulta>
    {
        public CobroConsultaRepository()
        {
            Context = new IcerpEntities();
        }
        public CobroConsultaRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<CobroConsulta> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<CobroConsulta> GetBy(System.Linq.Expressions.Expression<Func<CobroConsulta, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public CobroConsulta GetSingle(int Id)
        {
            var query = Context.CobroConsulta.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(CobroConsulta single)
        {
            Add(single);
        }

        public void UpdateSingle(CobroConsulta single)
        {
            Edit(single);
        }
    }
}
