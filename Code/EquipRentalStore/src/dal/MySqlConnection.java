/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;

/**
 *
 * @author mubee
 */
public class MySqlConnection {

    private String dbName;
    private String serverName;
    private String userName;
    private String password;
//

    MySqlConnection() {
        mysql();
    }

    public Connection mysql() {
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Northwind", "root", "root");
        } catch (Exception e) {
            System.out.println("Error Trace in getConnection() : " + e.getMessage());
        }
        return null;
    }

}
