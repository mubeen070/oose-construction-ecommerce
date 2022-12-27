/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ui;

import java.awt.Color;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JTextField;
import model.dto.Response;

/**
 *
 * @author mubee
 */
public class CommonHandler {

    static void handleResponse(Response objResponse,JComponent uiComponent) {
        if(objResponse.hasError()){
            if(uiComponent instanceof JLabel){
                ((JLabel)uiComponent).setText(objResponse.getErrorMessages());
                ((JLabel)uiComponent).setForeground(Color.RED);
            }
        }
    }
    
}
