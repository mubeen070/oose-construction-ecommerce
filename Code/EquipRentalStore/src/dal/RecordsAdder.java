/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.dto.ItemsDTO;
import model.dto.Message;
import model.dto.MessageType;
import model.dto.Response;

/**
 *
 * @author mubee
 */
public class RecordsAdder {

    void saveEmployee(ItemsDTO objItem, Response objResponse, Connection dbConnection) {
        try {
            PreparedStatement p = dbConnection.prepareStatement("INSERT INTO items (name,stock) VALUES (?,?);");
            p.setString(1, objItem.name);
            p.setString(2, objItem.stock);
            int rowsInserted = p.executeUpdate();
            if (rowsInserted > 0) {
                objResponse.messagesList.add(new Message("Item added successfully.", MessageType.Information));
            }
        } catch (SQLException e) {
            objResponse.messagesList.add(new Message("Ooops! Failed to create item, Please contact support that there an issue while saving new employee.", MessageType.Error));
            objResponse.messagesList.add(new Message(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
    }

}
