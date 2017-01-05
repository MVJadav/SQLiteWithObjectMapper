//
//  Demo.swift
//  ContactList
//
//  Created by Mac33 on 02/01/17.
//  Copyright © 2017 JadavMehul. All rights reserved.
//

import UIKit

class Demo {
    
    let objloginModel:ContactModel  = ContactModel()
    objloginModel.UserID            = serviceResponse.UserID
    objloginModel.FirstName         = txtFirstname.text
    objloginModel.LastName          = txtLastname.text
    objloginModel.Image             = imageName
    objloginModel.Address           = txtAddress.text
    objloginModel.MobileNumber      = txtMobile.text
    objloginModel.PhoneNumber       = txtPhone.text
    objloginModel.DOB               = txtDOB.text
    //For Insert
    if(DBManager.getSharedInstance().insert(queryString: SQLQuery.insert(Obj: objloginModel))){ }
    //For Update
    if(DBManager.getSharedInstance().update(queryString: SQLQuery.update(Obj: objloginModel))){ }
    //For Delele
    if(DBManager.getSharedInstance().delete(strQuery: SQLQuery.delete(Obj: objloginModel))){ }
}
