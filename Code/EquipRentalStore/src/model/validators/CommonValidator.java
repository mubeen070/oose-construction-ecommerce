/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.validators;

import model.dto.ItemsDTO;
import model.dto.Cartitems;
import model.dto.Message;
import model.dto.MessageType;
import model.dto.Response;
import model.Creator;

/**
 *
 * @author Mukhtiar-HPC
 */
public class CommonValidator {

    public static void validateCart(Cartitems objCart, Response objResponse) {
        if (objCart.name == null || objCart.Id == null || objCart.quantity == 0) {
            objResponse.messagesList.add(new Message("no items present in cart .", MessageType.Error));
        }
        // Todo validate the rest
    }

    public static void validateItems(ItemsDTO objEmp, Response objResponse) {
        if (objEmp.name == null || objEmp.price == null || objEmp.Id == null) {
            objResponse.messagesList.add(Creator.getInstanceofMessage("Text Fields cant be null.", MessageType.Error));
        }
        // Todo validate the rest
    }
}
