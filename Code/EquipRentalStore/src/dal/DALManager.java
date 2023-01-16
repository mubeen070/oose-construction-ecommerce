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
import model.dto.MessageType;
import model.dto.Response;
import model.validators.CommonValidator;

/**
 *
 * @author mubee
 */
public class DALManager {

    IConnection objConnection;
    DBReader objReader;
    MapRecord objMapper;
    AddRecord objAdder;
    RecordsModifier objModifier;
    CommonValidator objVal;

    public DALManager(MapRecord mapper) {
        try {

            objConnection = new SQLConnection("localhost", "master", "sa", "root123");
            objReader = new DBReader();
            objAdder = Creator.getInstanceOfAdder();
            objVal = Creator.getInstanceOf_Validator();
            this.objMapper = mapper;
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

    public ArrayList<ItemsDTO> searchItemss(String searchKey) {

        Connection dbConnection = objConnection.getConnection();
        String viewEmployeesQuery = "Select * from items";
        if (searchKey == null || searchKey.length() > 0) {
            viewEmployeesQuery += " where item_id LIKE '%" + searchKey + "%' OR item_name LIKE '%" + searchKey + "%';";
        }
        ResultSet rs = objReader.getRecords(viewEmployeesQuery, dbConnection);
        return objMapper.getItems(rs);
    }

    public void saveItems(ItemsDTO objItem, Response objResponse) {
        try {
            Connection dbConnection = objConnection.getConnection();
            objAdder.addItems(objItem, objResponse, dbConnection);
        } catch (Exception e) {
            objResponse.messagesList.add(Creator.getInstanceofMessage("Ooops! Failed to create Item, Please contact support that there an issue while saving new Item.", MessageType.Error));
            objResponse.messagesList.add(Creator.getInstanceofMessage(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
    }

    public Response deleteItems(String selectedId, Response objResponse) {
        try {
            Connection dbConnection = objConnection.getConnection();
            objModifier.deleteItem(selectedId, objResponse, dbConnection);
            return objResponse;
        } catch (Exception e) {
            objResponse.messagesList.add(Creator.getInstanceofMessage("Ooops! Failed to delete Item, Please contact support that there an issue while saving new employee.", MessageType.Error));
            objResponse.messagesList.add(Creator.getInstanceofMessage(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
        return null;
    }

}
