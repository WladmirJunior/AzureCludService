using Microsoft.WindowsAzure.Storage.Queue;
using Microsoft.WindowsAzure.Storage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Api.Models;
using System.IO;
using Newtonsoft.Json;
using System.Runtime.Serialization.Json;
using Models;

namespace Api.Controllers
{
    public class ValuesController : ApiController
    {
        static int count = 0;
        static CloudQueue cloudQueue;

        public ValuesController()
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
        }

        // GET api/values
        public string Get()
        {
            Pedido pedido = new Pedido();
            pedido.id = "1";
            pedido.produto = "Livro";
            pedido.valor = 24.90;

            MemoryStream stream = new MemoryStream();
            DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(Pedido));

            serializer.WriteObject(stream, pedido);
            stream.Position = 0;
            StreamReader streamReader = new StreamReader(stream);

            return streamReader.ReadToEnd();
        }

        // GET api/values/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        public void Post(Pedido value)
        {                
            var message = new CloudQueueMessage(JsonConvert.SerializeObject(value));
            cloudQueue.AddMessage(message);
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}
