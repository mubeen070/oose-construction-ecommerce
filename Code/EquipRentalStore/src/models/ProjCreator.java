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
import dal.RecordsModifier;

/**
 *
 * @author mubee
 */
public class ProjCreator {

    static DALManager getInstanceOfDALManager() {
        return new DALManager(new RecordsMapper());
    }

    public static Controller getInstanceOfSMSController() {
        return new Controller();
    }

    static Response getResponseInstance() {
        return new Response();
    }

    public static RecordsAdder getInstanceOfAdder() {
        return new RecordsAdder();
    }
    public static RecordsModifier getInstanceOfModifier() {
        return new RecordsModifier();
    }
}
