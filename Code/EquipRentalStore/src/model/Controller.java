/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import dal.DALManager;
import java.util.ArrayList;
import model.dto.ItemsDTO;
import model.dto.Response;
import model.validators.CommonValidator;

/**
 *
 * @author mubee
 */
public class Controller {

    DALManager objDAL;

    public Controller() {
        objDAL = Creator.getInstanceOfDALManager();
    }

    public ArrayList<ItemsDTO> viewItems(String searchKey) {
        return objDAL.searchItemss(searchKey);
    }

    public Response addItems(ItemsDTO objItem) {
        Response objResponse = Creator.getResponseInstance();
        CommonValidator.validateItems(objItem, objResponse);
        if (objResponse.isSuccessfull()) {
            objDAL.saveItems(objItem, objResponse);
        }
        return objResponse;
    }

    public Response deleteItems(String selectedId) {
        Response objResponse = Creator.getResponseInstance();
        objDAL.deleteItems(selectedId, objResponse);
        return objResponse;
    }
}
