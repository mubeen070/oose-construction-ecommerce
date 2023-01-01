/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author MK
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author mubee
 */
public class SQLConnection implements IConnection {

    final private String serverName;
    final private String dbName;
    final private String dbUserName;
    final private String dbUserPassword;

    SQLConnection(String sName, String dbName, String userId, String userPass) {
        this.serverName = sName;
        this.dbName = dbName;
        this.dbUserName = userId;
        this.dbUserPassword = userPass;
    }

        @Override
    public Connection getConnection() {
        try {
            return DriverManager.getConnection("jdbc:sqlserver://;databaseName="+this.dbName+";trustServerCertificate=true;", this.dbUserName,this.dbUserPassword);
        }
        catch (SQLException e) {
            System.out.println("Error Trace in getConnection() : " + e.getMessage());
        }
        return null;
    }

}
