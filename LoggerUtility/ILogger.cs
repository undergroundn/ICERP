using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoggerUtility
{
    public interface ILogger
    {
        void Warn(String logMessage);
        void Warn(String logMessage, Exception exception);
        void Info(String logMessage);
        void Info(String logMessage, Exception exception);
        void Error(String logMessage);
        void Error(String logMessage, Exception exception);
        void Debug(String logMessage);
        void Debug(String logMessage, Exception exception);
        void Fatal(String logMessage);
        void Fatal(String logMessage, Exception exception);
    }
}
