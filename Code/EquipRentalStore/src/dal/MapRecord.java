/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.dto.ItemsDTO;
import model.dto.Cartitems;

/**
 *
 * @author mubee
 */
public class MapRecord {

    ArrayList<ItemsDTO> getItems(ResultSet rs) {
        ArrayList<ItemsDTO> itemlist = new ArrayList<>();
        try {
            while (rs.next()) {
                ItemsDTO objItem = new ItemsDTO();
                objItem.Id = rs.getString(1);
                objItem.name = rs.getString(2);
                objItem.desc = rs.getString(3);
                objItem.price = rs.getString(4);
                itemlist.add(objItem);
            }
        } catch (SQLException e) {
        }
        return itemlist;
    }

    ArrayList<Cartitems> getCartitems(ResultSet rs) {
        ArrayList<Cartitems> emplist = new ArrayList<>();
        try {
            while (rs.next()) {
                Cartitems objItem = new Cartitems();
                objItem.Id = rs.getString(1);
                objItem.name = rs.getString(3);
                objItem.quantity = rs.getInt(2);

                emplist.add(objItem);
            }
        } catch (Exception e) {
        }
        return emplist;
    }

}
