using System;
using System.Diagnostics;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.ServiceRuntime;
using Microsoft.WindowsAzure.Storage;
using Newtonsoft.Json;
using Models;
using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.Azure.NotificationHubs;

namespace Processa_Pedidos
{
    public class WorkerRole : RoleEntryPoint
    {
        private readonly CancellationTokenSource cancellationTokenSource = new CancellationTokenSource();
        private readonly ManualResetEvent runCompleteEvent = new ManualResetEvent(false);

        CloudQueue cloudQueue;
        private static NotificationHubClient _hub;

        public override void Run()
        {
            var connectionString = "DefaultEndpointsProtocol=https;AccountName=blackfridaystorage;AccountKey=kHDL6D7IA4XSZPtMjiq9jzEyTWlHcbDsmjXbkxzWD39BUIxb+sc4A+8wMaBdBUplK/Z0bENef5Nwc6ICQ21W0Q==";

            CloudStorageAccount cloudStorageAccount = null;

            try
            {
                CloudStorageAccount.TryParse(connectionString, out cloudStorageAccount);
            }
            catch (Exception e)
            {

            }

            var cloudQueueClient = cloudStorageAccount.CreateCloudQueueClient();
            cloudQueue = cloudQueueClient.GetQueueReference("demoqueue");

            // Note: Usually this statement can be executed once during application startup or maybe even never in the application.
            //       A queue in Azure Storage is often considered a persistent item which exists over a long time.
            //       Every time .CreateIfNotExists() is executed a storage transaction and a bit of latency for the call occurs.
            cloudQueue.CreateIfNotExists();

            Trace.TraceInformation("Processa Pedidos is running");

            try
            {
                this.RunAsync(this.cancellationTokenSource.Token).Wait();
            }
            finally
            {
                this.runCompleteEvent.Set();
            }
        }

        public override bool OnStart()
        {               
            // Set the maximum number of concurrent connections
            ServicePointManager.DefaultConnectionLimit = 12;

            // For information on handling configuration changes
            // see the MSDN topic at https://go.microsoft.com/fwlink/?LinkId=166357.

            bool result = base.OnStart();

            Trace.TraceInformation("Processa Pedidos has been started");

            ConnectNotificationClient();

            Trace.TraceInformation("Conecta com o cliente da notificaçâo");

            return result;
        }

        public override void OnStop()
        {
            Trace.TraceInformation("Processa Pedidos is stopping");

            this.cancellationTokenSource.Cancel();
            this.runCompleteEvent.WaitOne();

            base.OnStop();

            Trace.TraceInformation("Processa Pedidos has stopped");
        }

        private async Task RunAsync(CancellationToken cancellationToken)
        {
            // TODO: Replace the following with your own logic.
            while (!cancellationToken.IsCancellationRequested)
            {
                var cloudQueueMessage = cloudQueue.GetMessage();

                if (cloudQueueMessage != null)
                {           
                    Pedido pedido = JsonConvert.DeserializeObject<Pedido>(cloudQueueMessage.AsString);

                    cloudQueue.DeleteMessage(cloudQueueMessage);

                    QueueNotification(pedido);
                }
            
                //
                Trace.TraceInformation("Working");
                await Task.Delay(1000);
            }
        }

        public async void QueueNotification(Pedido pedido)
        {
            await SendNotificationAsync("gcm", "Compra do produto "+pedido.produto+" realizada!", "wlad");
        }

        public void ConnectNotificationClient()
        {
            string defaultFullSharedAccessSignature = "Endpoint=sb://puc-pos-blackfriday.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=ZSXc8AohJmOpRGDuD8LDI0V+3tb28Oqne/szXvnm2fc=";
            string hubName = "hub-pedidos";
            _hub = NotificationHubClient.CreateClientFromConnectionString(defaultFullSharedAccessSignature, hubName);         

        }

        public async Task<bool> SendNotificationAsync(string platform, string message, string to_tag)
        {
            var user = "Wladmir";
            string[] userTag = new string[1];
            userTag[0] = to_tag;

            NotificationOutcome outcome = null;

            switch (platform.ToLower())
            {
                case "gcm":
                    // Android
                    var notif = "{ \"data\" : {\"message\":\"" + "From " + user + ": " + message + "\"}}";
                    outcome = await _hub.SendGcmNativeNotificationAsync(notif, userTag);
                    break;
            }

            if (outcome != null)
            {
                if (!((outcome.State == NotificationOutcomeState.Abandoned) ||
                    (outcome.State == NotificationOutcomeState.Unknown)))
                {
                    return true;
                }
            }
            return false;
        }
    }
}
