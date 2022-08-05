*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}     http://114.143.149.14:4356/TaskbaseAWS-2.0/NeovaTaskBase/LoginPage.aspx
${BROWSER}       Chrome
${OPTION}        options=add_argument("--incognito")
${InputText}     Automation training assignment using selenium or robot framework with python
${userName}      Pravin Kute     #change to your user name

*** Test Cases ***
Valid Login
    launch URL
    Input Username       test@neovasolutions.in         #add User name
    Input Password       password                         #add Password
    Click Button         id:btnLogin
    Welcome Page Should Be
    Select Date From Calander
    Select Value From DropDown
    Input Description
    Save Data
    Validate Description Column
    [Teardown]    Close Browser

*** Keywords ***
launch URL
    Open Browser    ${LOGIN URL}  ${BROWSER}  ${OPTION}
    maximize browser window
    set selenium speed  1
Input Username
    [Arguments]    ${username}
    Input Text     Xpath://input[@id="txtUserName"]   ${username}
Input Password
    [Arguments]    ${password}
    Input Text    Xpath://input[@id="txtPassword"]   ${password}

#Username
#    ${userName}    get element attribute
#    log to console    ${userName}
#    [Arguments]    ${name}

Welcome Page Should Be
    Title Should Be    Neova Task Base
    PAGE SHOULD CONTAIN    My Timesheet
    element should contain    Xpath://*[@id="ctl00_ContentPlaceHolder1_ddEmployee"]/option    ${userName}

Select Date From Calander
    click element    Xpath://*[@id="imgBtnCal"]
    click element    xpath://td[@class='day active today']

Select Value From DropDown
    select from list by label    Xpath://*[@id="ctl00_ContentPlaceHolder1_ddProjects"]    NON-BILLABLE
    select from list by label    Xpath://*[@id="ctl00_ContentPlaceHolder1_ddPhase"]      Training - Internal
    select from list by label    CSS:#ctl00_ContentPlaceHolder1_ddEntryHours     7

Input Description
    Input Text    Xpath://*[@id="ctl00_ContentPlaceHolder1_txtDescription"]   ${InputText}

Save Data
    click element    Xpath://*[@id="ctl00_ContentPlaceHolder1_btnAddTimesheetEntry"]

Validate Description Column
#    element should contain    Xpath://*[@id="ctl00_ContentPlaceHolder1_gvTimesheet"]/tbody/tr[2]/td[4]    ${InputText}
    table column should contain    xpath://*[@id="ctl00_ContentPlaceHolder1_gvTimesheet"]/tbody    4    ${InputText}

