/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.validator;

import model.dto.ItemsDTO;
import model.dto.Message;
import model.dto.MessageType;
import model.dto.Response;

/**
 *
 * @author mubee
 */
public class CommonValidator {

    public static void validateEmployee(ItemsDTO objEmp, Response objResponse) {
        if(objEmp.name == null || objEmp.Id.length() < 3){
            objResponse.messagesList.add(new Message("Name is not valid, Provide valid first name with at least 3 characters.",MessageType.Error));
        }
        // Todo validate the rest
    }
    
}
