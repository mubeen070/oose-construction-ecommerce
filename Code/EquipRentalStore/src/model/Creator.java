/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import dal.DALManager;
import dal.AddRecord;
import dal.MapRecord;
import dal.RecordsModifier;
import model.dto.Response;
import model.dto.Message;
import model.dto.MessageType;
import model.validators.CommonValidator;
import ui.Dashboard;
import ui.AddItemsUI;
import ui.ItemsUInterface;
import model.dto.ItemsDTO;
import ui.Delete;

/**
 *
 * @author mubee
 */
public class Creator {

    public static DALManager getInstanceOfDALManager() {
        return new DALManager(new MapRecord());
    }

    public static Controller getInstanceOfSMSController() {
        return new Controller();
    }

    public static Response getResponseInstance() {
        return new Response();
    }

    public static AddRecord getInstanceOfAdder() {
        return new AddRecord();
    }

    public static RecordsModifier getInstanceOfModifier() {
        return new RecordsModifier();
    }

    public static Object[] getInstanceofObject(int size) {
        return new Object[size];
    }

    public static Message getInstanceofMessage(String errorMessage, MessageType messageType) {
        return new Message(errorMessage, messageType);
    }

    public static CommonValidator getInstanceOf_Validator() {
        return new CommonValidator();
    }

    public static ItemsDTO getInstanceOfItemsDTO() {
        return new ItemsDTO();
    }

    public static Delete getInstanceOfDelete() {
        return new Delete();
    }

    public static Object getInstanceOfAddItems(ItemsUInterface aThis, Controller objController) {
        return new AddItemsUI(aThis, objController);
    }
}
