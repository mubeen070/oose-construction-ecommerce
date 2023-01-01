/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import dal.DALManager;
import dal.RecordsAdder;
import dal.RecordsMapper;
import dal.RecordsModifier;
import model.dto.Response;
import model.dto.Message;
import model.dto.MessageType;

/**
 *
 * @author mubee
 */
public class Creator {

    public static DALManager getInstanceOfDALManager() {
        return new DALManager(new RecordsMapper());
    }

    public static OSSController getInstanceOfSMSController() {
        return new OSSController();
    }

    public static Response getResponseInstance() {
        return new Response();
    }

    public static RecordsAdder getInstanceOfAdder() {
        return new RecordsAdder();
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
}
