/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import dal.DALManager;
import java.util.ArrayList;
import model.dto.Cartitems;
import model.dto.ItemsDTO;
import model.dto.Response;
import model.validator.CommonValidator;

/**
 *
 * @author mubee
 */
public class Controller {
    DALManager objDAL;
    public Controller(){
    objDAL = ProjCreator.getInstanceOfDALManager();
    }

    public ArrayList<ItemsDTO> viewEmployees(String searchKey) {
        return objDAL.getItemList(searchKey);
    }

    public Response addItems(ItemsDTO objEmp) {
        Response objResponse = ProjCreator.getResponseInstance();
        CommonValidator.validateEmployee(objEmp,objResponse);
        if(objResponse.isSuccessfull()){
            objDAL.saveItem(objEmp,objResponse);
        }
        return objResponse;
    }
     public Response gorenting(Cartitems objcart) {
        Response objResponse = ProjCreator.getResponseInstance();
        CommonValidator.validateCart(objcart,objResponse);
        if(objResponse.isSuccessfull()){
           // objDAL.saveItem(objcart,objResponse);//
        }
        return objResponse;
    }
}
