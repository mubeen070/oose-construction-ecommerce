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

/**
 *
 * @author mubee
 */
public class sqlConnection implements IConnection {

    private String serverName;
    private String dbName;
    private String dbUserName;
    private String dbUserPassword;

    sqlConnection(String sName, String dbName, String userId, String userPass) {
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
        catch (Exception e) {
            System.out.println("Error Trace in getConnection() : " + e.getMessage());
        }
        return null;
    }

}
