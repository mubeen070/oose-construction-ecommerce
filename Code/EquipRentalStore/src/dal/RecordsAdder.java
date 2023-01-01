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

    void addItems(ItemsDTO objItem, Response objResponse, Connection dbConnection) {
        try {
            PreparedStatement p = dbConnection.prepareStatement("INSERT INTO Items (item_id,item_name,item_desc,item_price) VALUES (?,?,?,?);");
            p.setString(1, objItem.Id);
            p.setString(2, objItem.name);
            p.setString(3, objItem.desc);
            p.setString(4, objItem.price);
            int rowsInserted = p.executeUpdate();
            if (rowsInserted > 0) {
                objResponse.messagesList.add(new Message("Item added successfully.", MessageType.Information));
            }
        } catch (SQLException e) {
            objResponse.messagesList.add(new Message("Ooops! Failed to add", MessageType.Error));
            objResponse.messagesList.add(new Message(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
    }

}
