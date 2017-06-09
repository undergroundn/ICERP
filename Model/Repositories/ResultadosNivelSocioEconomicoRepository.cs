using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class ResultadosNivelSocioEconomicoRepository : GenericRepository<IcerpEntities, ResultadosNivelSocioEconomico>
    {
        public ResultadosNivelSocioEconomicoRepository()
        {
            Context = new IcerpEntities();
        }
        public ResultadosNivelSocioEconomicoRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<ResultadosNivelSocioEconomico> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<ResultadosNivelSocioEconomico> GetBy(System.Linq.Expressions.Expression<Func<ResultadosNivelSocioEconomico, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public ResultadosNivelSocioEconomico GetSingle(int Id)
        {
            var query = Context.ResultadosNivelSocioEconomico.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(ResultadosNivelSocioEconomico single)
        {
            Add(single);
        }

        public void UpdateSingle(ResultadosNivelSocioEconomico single)
        {
            Edit(single);
        }
    }
}
