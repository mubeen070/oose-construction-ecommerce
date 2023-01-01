/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Creator;
import model.dto.ItemsDTO;
import model.dto.Cartitems;
import model.dto.Message;
import model.dto.MessageType;
import model.dto.Response;

/**
 *
 * @author Mukhtiar
 */
public class DALManager {

    IConnection objConnection;
    DBReader objReader;
    RecordsMapper objMapper;
    RecordsAdder objAdder;
    RecordsModifier objModifier;

    public DALManager(RecordsMapper mapper) {
        try {

            objConnection = new SQLConnection("localhost", "master", "sa", "root123");
            objReader = new DBReader();
            objAdder = Creator.getInstanceOfAdder();
            this.objMapper = mapper;
            objModifier = Creator.getInstanceOfModifier();
        } catch (Exception e) {
            System.out.println(e.getStackTrace());
        }
    }

    public ArrayList<Cartitems> getCarttemsList(String searchKey) {

        Connection dbConnection = objConnection.getConnection();
        String viewItemsQuery = "Select * from items";
        if (searchKey == null || searchKey.length() > 0) {
            viewItemsQuery += " where FirstName LIKE '%" + searchKey + "%' OR LastName LIKE '%" + searchKey + "%' OR Title LIKE '%" + searchKey + "%';";
        }
        ResultSet rs = objReader.getRecords(viewItemsQuery, dbConnection);
        return objMapper.getCartitems(rs);
    }

    public ArrayList<ItemsDTO> getItemsList(String searchKey) {

        Connection dbConnection = objConnection.getConnection();
        String viewEmployeesQuery = "Select * from items";
        if (searchKey == null || searchKey.length() > 0) {
            viewEmployeesQuery += " where item_id LIKE '%" + searchKey + "%' OR item_name LIKE '%" + searchKey + "%';";
        }
        ResultSet rs = objReader.getRecords(viewEmployeesQuery, dbConnection);
        return objMapper.getItems(rs);
    }

    public void saveItems(ItemsDTO objEmp, Response objResponse) {
        try {
            Connection dbConnection = objConnection.getConnection();
            objAdder.addItems(objEmp, objResponse, dbConnection);
        } catch (Exception e) {
            objResponse.messagesList.add(new Message("Ooops! Failed to create employee, Please contact support that there an issue while saving new employee.", MessageType.Error));
            objResponse.messagesList.add(new Message(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
    }

    public Response deleteItems(String selectedId, Response objResponse) {
        try {
            Connection dbConnection = objConnection.getConnection();
            objModifier.deleteEmployee(selectedId, objResponse, dbConnection);
            return objResponse;
        } catch (Exception e) {
            objResponse.messagesList.add(new Message("Ooops! Failed to delete employee, Please contact support that there an issue while saving new employee.", MessageType.Error));
            objResponse.messagesList.add(new Message(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
        return null;
    }

}
