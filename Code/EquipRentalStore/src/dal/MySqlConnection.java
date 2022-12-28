/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author mubee
 */
public class MySqlConnection implements IConnection {

    private String serverName;
    private String dbName;
    private String dbUserName;
    private String dbUserPassword;
    
    MySqlConnection(String sName, String dbName, String userId, String userPass) {
        this.serverName = sName;
        this.dbName = dbName;
        this.dbUserName = userId;
        this.dbUserPassword = userPass;
    }

    @Override
    public Connection getConnection() {
        try {
            return DriverManager.getConnection("jdbc:mysql://;databaseName="+this.dbName+";trustServerCertificate=true;", this.dbUserName,this.dbUserPassword);
        }
        catch (Exception e) {
            System.out.println("Error Trace in getConnection() : " + e.getMessage());
        }
        return null;
    }
    
}
