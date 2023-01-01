/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ui;

import java.awt.Color;
import javax.swing.JComponent;
import javax.swing.JTextArea;
import model.dto.Response;

/**
 *
 * @author Mukhtiar-HPC
 */
public class CommonHandler {

    static void handleResponse(Response objResponse, JComponent uiComponent) {
        if (objResponse.hasError()) {
            if (uiComponent instanceof JTextArea) {
                ((JTextArea) uiComponent).setText(objResponse.getErrorMessages());
                ((JTextArea) uiComponent).setForeground(Color.RED);
            }
        }
    }
}
