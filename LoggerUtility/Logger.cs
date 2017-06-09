using log4net;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LoggerUtility
{
    public class Logger : ILogger
    {
        private static ILogger _Log = null;
        private static ILog _log = null;

        public ILog Log { get; set; }

        #region ILogger Members

        public static ILogger GetInstance()
        {
            _Log = null;
            if (_Log == null)
            {
                _Log = new Logger();
                //load the configuration when class is institiated for the  first time.

                string virtualPath = System.Configuration.ConfigurationManager.AppSettings["log4net_config"];


                string filename = Path.Combine(virtualPath, "log4net.config");
                FileInfo file = new FileInfo(filename);

                log4net.Config.XmlConfigurator.Configure(file);
                file = null;
                ((Logger)_Log).Log = LogManager.GetLogger(Type.GetType("System.Object"));
            }
            return _Log;
        }

        public void Warn(string logMessage)
        {
            Log.Warn(logMessage);
        }

        public void Warn(string logMessage, Exception exception)
        {
            logMessage += FormatExceptionDescription(exception);
            Log.Warn(logMessage);

        }

        public void Info(string logMessage)
        {
            Log.Info(logMessage);

        }

        public void Info(string logMessage, Exception exception)
        {
            logMessage += FormatExceptionDescription(exception);
            Log.Info(logMessage);

        }

        public void Error(string logMessage)
        {
            Log.Error(logMessage);

        }

        public void Error(string logMessage, Exception exception)
        {
            logMessage += FormatExceptionDescription(exception);
            Log.Error(logMessage);

        }

        public void Debug(string logMessage)
        {
            Log.Debug(logMessage);

        }

        public void Debug(string logMessage, Exception exception)
        {
            logMessage += FormatExceptionDescription(exception);
            Log.Debug(logMessage);

        }

        public void Fatal(string logMessage)
        {
            Log.Fatal(logMessage);

        }

        public void Fatal(string logMessage, Exception exception)
        {
            logMessage += FormatExceptionDescription(exception);
            Log.Fatal(logMessage);

        }

        #endregion
        private string FormatExceptionDescription(Exception e)
        {
            string formatExceptionDescription;
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append(Environment.NewLine + "Exception Detail : " + Environment.NewLine);
                while (e != null)
                {
                    sb.Append("Type: " + e.GetType().FullName + Environment.NewLine);
                    sb.Append("Message: " + e.Message + Environment.NewLine);
                    sb.Append("Source: " + e.Source + Environment.NewLine);
                    sb.Append("TargetSite: " + e.TargetSite + Environment.NewLine);
                    sb.Append("StackTrace: " + e.StackTrace + Environment.NewLine);
                    sb.Append(Environment.NewLine);

                    e = e.InnerException;


                }
                sb.Append(Environment.NewLine);
                formatExceptionDescription = sb.ToString();
            }
            catch (Exception ex)
            {
                StringBuilder sb2 = new StringBuilder();
                sb2.Append(DateTime.Now.ToString("g") + Environment.NewLine);
                sb2.Append("The ErrorHandler.FormatExceptionDescription method has thrown an error (May happen if full logging is enabled and it cannot retrieve the User's Information)" + Environment.NewLine);
                sb2.Append("This is a reduced log entry to reduce the chance of another error being thrown" + Environment.NewLine);
                sb2.Append("The FormatExceptionDescription Method failed to write the error. It received the following error: " + Environment.NewLine);
                sb2.Append(Environment.NewLine);
                sb2.Append("ErrorMessage" + ex.Message.ToString() + Environment.NewLine);
                sb2.Append("ErrorSrc" + ex.Source + Environment.NewLine);
                sb2.Append("TargetSite" + ex.TargetSite + Environment.NewLine);
                sb2.Append("StackTrace" + ex.StackTrace + Environment.NewLine);
                sb2.Append(Environment.NewLine);
                sb2.Append("The original error was:" + Environment.NewLine);
                sb2.Append(Environment.NewLine);
                sb2.Append("ErrorMessage" + e.Message.ToString() + Environment.NewLine);
                sb2.Append("ErrorSrc" + e.Source + Environment.NewLine);
                sb2.Append("TargetSite" + e.TargetSite + Environment.NewLine);
                sb2.Append("StackTrace" + e.StackTrace + Environment.NewLine);
                sb2.Append(Environment.NewLine + "End of Entry." + Environment.NewLine + Environment.NewLine);
                sb2.Append("\n\n");
                formatExceptionDescription = sb2.ToString();
            }

            return formatExceptionDescription;
        }
    }
}
