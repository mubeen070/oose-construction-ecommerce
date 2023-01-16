/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.dto.Message;
import model.dto.MessageType;
import model.dto.Response;

/**
 *
 * @author mubee
 */
public class RecordsModifier {

    void deleteItem(String selectedId, Response objResponse, Connection dbConnection) {
        try {
            PreparedStatement p;
            p = dbConnection.prepareStatement("delete from Items where item_id=?");
            p.setString(1, selectedId);
            int rowsInserted = p.executeUpdate();
            if (rowsInserted > 0) {
                objResponse.messagesList.add(new Message("Item with id:" + selectedId + "has been deleted successfully.", MessageType.Information));
            }
        } catch (SQLException e) {
            objResponse.messagesList.add(new Message("Ooops! Failed to create employee, Please contact support that there an issue while saving new employee.", MessageType.Error));
            objResponse.messagesList.add(new Message(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
    }

}
