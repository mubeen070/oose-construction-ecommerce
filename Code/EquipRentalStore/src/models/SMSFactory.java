/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import dal.DALManager;
import dal.RecordsMapper;
import model.dto.Response;
import dal.RecordsAdder;

/**
 *
 * @author mubee
 */
public class SMSFactory {

    static DALManager getInstanceOfDALManager() {
        return new DALManager(new RecordsMapper());
    }

    public static OSSController getInstanceOfSMSController() {
        return new OSSController();
    }

    static Response getResponseInstance() {
        return new Response();
    }

    public static RecordsAdder getInstanceOfAdder() {
        return new RecordsAdder();
    }

}
