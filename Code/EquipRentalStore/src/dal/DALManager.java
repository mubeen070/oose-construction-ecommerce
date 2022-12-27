/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import models.SMSFactory;
import model.dto.ItemsDTO;
import model.dto.Message;
import model.dto.MessageType;
import model.dto.Response;

/**
 *
 * @author mubee
 */
public class DALManager {

    MySqlConnection mysql;
    DBReader objReader;
    RecordsMapper objMapper;
    RecordsAdder objAdder;

    public DALManager(RecordsMapper mapper) {
        mysql = new MySqlConnection();
        objReader = new DBReader();
        objAdder = SMSFactory.getInstanceOfAdder();
        this.objMapper = mapper;
//    objModifier = SMSFactory.getInstanceOfModifier();
    }

    public ArrayList<ItemsDTO> getEmployeesList(String searchKey) {
        Connection dbConnection = mysql.mysql();
        String viewEmployeesQuery = "Select * from Employees";
        if (searchKey == null || searchKey.length() > 0) {
            viewEmployeesQuery += " where FirstName LIKE '%" + searchKey + "%' OR LastName LIKE '%" + searchKey + "%' OR Title LIKE '%" + searchKey + "%';";
        }
        ResultSet rs = objReader.getRecords(viewEmployeesQuery, dbConnection);
        return objMapper.getEmployees(rs);
    }

    public void saveItem(ItemsDTO objItem, Response objResponse) {
        try {
            Connection dbConnection = objConnection.getConnection();
            objAdder.saveEmployee(objItem, objResponse, dbConnection);
        } catch (Exception e) {
            objResponse.messagesList.add(new Message("Ooops! Failed to create employee, Please contact support that there an issue while saving new employee.", MessageType.Error));
            objResponse.messagesList.add(new Message(e.getMessage() + "\n Stack Track:\n" + e.getStackTrace(), MessageType.Exception));
        }
    }

}
