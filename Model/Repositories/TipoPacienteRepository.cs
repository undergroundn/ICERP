using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class TipoPacienteRepository : GenericRepository<IcerpEntities, TipoPaciente>
    {
        public TipoPacienteRepository()
        {
            Context = new IcerpEntities();
        }
        public TipoPacienteRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<TipoPaciente> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<TipoPaciente> GetBy(System.Linq.Expressions.Expression<Func<TipoPaciente, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public TipoPaciente GetSingle(int Id)
        {
            var query = Context.TipoPaciente.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(TipoPaciente single)
        {
            Add(single);
        }

        public void UpdateSingle(TipoPaciente single)
        {
            Edit(single);
        }
    }
}
