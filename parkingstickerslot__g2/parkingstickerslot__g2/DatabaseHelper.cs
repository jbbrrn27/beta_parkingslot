using MySql.Data.MySqlClient;
using System;
using System.Data;

public class DatabaseHelper
{
    private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MySqlConnection"].ConnectionString;

    public MySqlConnection GetConnection()
    {
        return new MySqlConnection(connectionString);
    }

    public DataTable GetData(string query)
    {
        DataTable dt = new DataTable();
        using (MySqlConnection conn = GetConnection())
        {
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand(query, conn))
            {
                using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }
        }
        return dt;
    }

    public int ExecuteQuery(string query)
    {
        int result;
        using (MySqlConnection conn = GetConnection())
        {
            conn.Open();
            using (MySqlCommand cmd = new MySqlCommand(query, conn))
            {
                result = cmd.ExecuteNonQuery();
            }
        }
        return result;
    }
}
