using Model.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.Repositories
{
    public class EstudioSocioeconomicoRepository : GenericRepository<IcerpEntities, EstudioSocioeconomico>
    {
        public EstudioSocioeconomicoRepository()
        {
            Context = new IcerpEntities();
        }
        public EstudioSocioeconomicoRepository(IcerpEntities cEntities)
        {
            Context = cEntities;
        }
        public List<EstudioSocioeconomico> Get()
        {
            var query = GetAll();
            return query.ToList();
        }

        public List<EstudioSocioeconomico> GetBy(System.Linq.Expressions.Expression<Func<EstudioSocioeconomico, bool>> predicate)
        {
            var query = FindBy(predicate);
            return query.ToList();
        }

        public EstudioSocioeconomico GetSingle(int Id)
        {
            var query = Context.EstudioSocioeconomico.FirstOrDefault(x => x.ID == Id);
            return query;
        }

        public void AddSingle(EstudioSocioeconomico single)
        {
            Add(single);
        }

        public void UpdateSingle(EstudioSocioeconomico single)
        {
            Edit(single);
        }
    }
}
