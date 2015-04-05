using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
 public   class ModelBase
    {
        /// <summary>
        /// 聚合函数查询枚举
        /// </summary>
        public enum GroupState
        {
            max=1,
            min=2,
            avg=3,
            sum=4
        }
    
    }
}
