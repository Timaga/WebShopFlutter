using Microsoft.AspNetCore.Mvc;
using Npgsql;

namespace WEB.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LogsContoller : ControllerBase
    {
        
       

            [HttpPost]
            [Route("insert")]
            public IActionResult Insert(string message,string ip)
            {
                var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
                using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
                {
                    connection.Open();
                string filePath = "log.txt"; 
                System.IO.File.WriteAllText(filePath, message);
                byte[] fileBytes = System.IO.File.ReadAllBytes(filePath);
                var command = new NpgsqlCommand("insert into log (ip,data,message) values (@ip,@data,@message)", connection);                  
                command.Parameters.AddWithValue("ip", ip);
                command.Parameters.AddWithValue("data", DateTime.Now);
                command.Parameters.AddWithValue("message", fileBytes);
                command.ExecuteNonQuery();
                    connection.Close();
                }
                return Ok(true);
            }

            /*[HttpPut]
            [Route("update")]
            public IActionResult Update(int id, string title, TimeSpan date_create)
            {
                try
                {
                    var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
                    using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
                    {
                        connection.Open();
                        var command = new NpgsqlCommand("update continent set title = @title, date_create = @date_create where id = @id", connection);
                        command.Parameters.AddWithValue("id", id);
                        command.Parameters.AddWithValue("title", title);
                        command.Parameters.AddWithValue("date_create", date_create);
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                    return Ok(true);
                }
                catch
                {
                    return Ok(false);
                }
            }
            */
           /* [HttpDelete]
            [Route("delete")]
            public IActionResult Delete(int id)
            {
                try
                {
                    var configuration = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.Development.json").Build();
                    using (var connection = new NpgsqlConnection(configuration.GetConnectionString("DefaultConnection")))
                    {
                        connection.Open();
                        var command = new NpgsqlCommand("delete from continent where id = @id", connection);
                        command.Parameters.AddWithValue("id", id);
                        command.ExecuteNonQuery();
                        connection.Close();
                    }
                    return Ok(true);
                }
                catch
                {
                    return Ok(false);
                }
            }*/
        }
    }
