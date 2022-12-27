/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dal;

import java.sql.ResultSet;
import java.util.ArrayList;
import model.dto.ItemsDTO;

/**
 *
 * @author mubee
 */
public class RecordsMapper {

    ArrayList<ItemsDTO> getEmployees(ResultSet rs) {
        ArrayList<ItemsDTO> emplist = new ArrayList<>();
        try{
        while (rs.next())
            {
                ItemsDTO objItem=new ItemsDTO();                
                objItem.Id=rs.getString(1);
                objItem.name= rs.getString(3);
                objItem.stock =rs.getString(2);
                objItem.price = Integer.parseInt(rs.getString(8));                  
                emplist.add(objItem);
            }
        }catch (Exception e){
        }
        return emplist;
    }
    
}
