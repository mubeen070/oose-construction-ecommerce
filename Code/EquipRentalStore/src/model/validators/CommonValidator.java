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

    public static void validateItems(ItemsDTO objItem, Response objResponse) {
        if (objItem.Id.compareTo("") == 0 && objItem.name.compareTo("") == 0 && objItem.desc.compareTo("") == 0 && objItem.price.compareTo("") == 0) {
            objResponse.messagesList.add(Creator.getInstanceofMessage("Please Enter some data in the above boxes.", MessageType.Error));
        } else {
            if (objItem.Id == null) {
                objResponse.messagesList.add(Creator.getInstanceofMessage("Id is not valid, Provide valid unique id.\n", MessageType.Error));
            }
            if (objItem.name == null || objItem.name.length() < 3) {
                objResponse.messagesList.add(Creator.getInstanceofMessage("Name is not valid, Provide valid name with at least 3 characters.\n", MessageType.Error));
            }
            if (objItem.desc == null || objItem.desc.length() < 20) {
                objResponse.messagesList.add(Creator.getInstanceofMessage("Desc Name is not valid, Provide a valid desc name with at least 20 characters.\n", MessageType.Error));
            }
            if (objItem.price == null || objItem.price.length() < 3) {
                objResponse.messagesList.add(Creator.getInstanceofMessage("Price is not valid, Provide valid price.\n", MessageType.Error));
            }
            // Todo validate the rest
        }
    }
}
