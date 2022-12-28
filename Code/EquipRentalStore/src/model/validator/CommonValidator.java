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
        if(objEmp.name == null || objEmp.Id.length() < 3 || objEmp.stock == null || objEmp.desc == null){
            objResponse.messagesList.add(new Message("Provide valid details in text fields.",MessageType.Error));
        }
        // Todo validate the rest
    }
    
}
